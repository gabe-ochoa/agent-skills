-- Starter schema for a new SaaS on Lovable Cloud.
-- Run via supabase--migration. Adapt domain tables to your product.

-- =========================================
-- PROFILES (1:1 with auth.users)
-- =========================================
create table public.profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique,           -- references auth.users(id) via trigger, NOT a FK
  display_name text,
  avatar_url text,
  onboarding_completed boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "Users can view own profile" on public.profiles
  for select using (auth.uid() = user_id);
create policy "Users can update own profile" on public.profiles
  for update using (auth.uid() = user_id);
create policy "Users can insert own profile" on public.profiles
  for insert with check (auth.uid() = user_id);

-- Auto-create profile on signup
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (user_id, display_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1)));
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- updated_at trigger (reusable)
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end;
$$;

create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

-- =========================================
-- SUBSCRIPTIONS (mirrors Stripe)
-- =========================================
create table public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique,
  tier text not null default 'free',           -- 'free' | 'pro' | 'premium'
  status text not null default 'inactive',     -- 'active' | 'trialing' | 'canceled' | 'inactive'
  stripe_customer_id text,
  stripe_subscription_id text,
  current_period_start timestamptz,
  current_period_end timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.subscriptions enable row level security;

create policy "Users can view own subscription" on public.subscriptions
  for select using (auth.uid() = user_id);
-- Inserts/updates happen from edge functions (service role bypasses RLS)

create trigger subscriptions_set_updated_at
  before update on public.subscriptions
  for each row execute function public.set_updated_at();

-- =========================================
-- USER EVENTS (product analytics)
-- =========================================
create table public.user_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  event_name text not null,
  metadata jsonb,
  created_at timestamptz not null default now()
);

alter table public.user_events enable row level security;

create policy "Users can insert own events" on public.user_events
  for insert with check (auth.uid() = user_id or user_id is null);
create policy "Users can view own events" on public.user_events
  for select using (auth.uid() = user_id);

create index user_events_user_id_created_at_idx
  on public.user_events (user_id, created_at desc);

-- =========================================
-- ROLES (only if your app needs them)
-- =========================================
-- create type public.app_role as enum ('admin', 'user');
--
-- create table public.user_roles (
--   id uuid primary key default gen_random_uuid(),
--   user_id uuid not null,
--   role app_role not null,
--   unique (user_id, role)
-- );
-- alter table public.user_roles enable row level security;
--
-- create or replace function public.has_role(_user_id uuid, _role app_role)
-- returns boolean language sql stable security definer set search_path = public as $$
--   select exists (select 1 from public.user_roles where user_id = _user_id and role = _role);
-- $$;
--
-- create policy "Users can view own roles" on public.user_roles
--   for select using (auth.uid() = user_id);

-- =========================================
-- EMAIL SUPPRESSION (always include)
-- =========================================
create table public.suppressed_emails (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  reason text not null,                  -- 'unsubscribe' | 'bounce' | 'complaint'
  metadata jsonb,
  created_at timestamptz not null default now()
);
-- No RLS policies — only edge functions read/write this.
alter table public.suppressed_emails enable row level security;
