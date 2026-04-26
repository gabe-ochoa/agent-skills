# Business launch playbook

Companion to `skills/personal/business-launch/SKILL.md`. Use when you need the *how*, not just the *what*.

## Phase 1. Discovery (template questions)

```
1. "Who is the ONE person this is for?" — single persona, named if possible
2. "Walk me through the painful moment they have today." — the trigger
3. "What would make them say 'shut up and take my money'?" — the hero outcome
4. "What's the smallest version we could ship that delivers that outcome?" — MVP scope
```

Write the answers verbatim into `.lovable/plan.md`. Refer back every phase. When scope creeps, this is your anchor.

## Phase 2. Brand checklist

```
[ ] Name chosen, .com checked
[ ] 3-color palette in HSL added to src/index.css :root and .dark
[ ] Display font + body font added via <link> in index.html
[ ] One signature visual motif decided (rounded image frames? thick left borders? colored icon circles?)
[ ] Button variants: default, hero, ghost, all use semantic tokens
[ ] Dark mode tested (or explicitly deferred)
```

Bad: `<div className="bg-green-500 text-white">`

Good: `<div className="bg-primary text-primary-foreground">`

## Phase 3. Route scaffolding

`src/App.tsx` shape:

```tsx
<BrowserRouter>
  <Routes>
    {/* PUBLIC: must render without auth, must not redirect */}
    <Route path="/" element={<Landing />} />
    <Route path="/upgrade" element={<Upgrade />} />
    <Route path="/auth" element={<Auth />} />
    <Route path="/unsubscribe" element={<Unsubscribe />} />

    {/* PROTECTED */}
    <Route element={<ProtectedRoute><AppShell /></ProtectedRoute>}>
      <Route path="/dashboard" element={<Dashboard />} />
      <Route path="/onboarding" element={<Onboarding />} />
      {/* other app routes */}
    </Route>

    <Route path="*" element={<NotFound />} />
  </Routes>
</BrowserRouter>
```

Pricing pages MUST be public. If a logged-out user hits "Subscribe", route them to `/auth?redirect=/upgrade`.

## Phase 4. Schema starter

See `skills/personal/business-launch/templates/schema.sql`. Always include:

- `profiles` with trigger on `auth.users` insert
- `subscriptions` keyed on `user_id`
- `user_events(event_name, metadata jsonb, user_id, created_at)` for analytics
- RLS enabled on every table with `auth.uid() = user_id` policies

For roles, NEVER store on profiles:

```sql
create type app_role as enum ('admin', 'user');
create table user_roles (id uuid pk, user_id uuid, role app_role, unique(user_id, role));
-- plus has_role(_user_id, _role) SECURITY DEFINER function
```

## Phase 5. Auth flow

```tsx
// useAuth.tsx: wraps supabase auth, exposes { user, session, loading, signOut }
// ProtectedRoute.tsx: if !loading && !user, <Navigate to="/auth" />
// Auth.tsx: tabs for sign in / sign up, Google button, link to /
// Onboarding redirect: useEffect on dashboard load: if !profile.onboarding_completed, navigate('/onboarding')
```

Email confirmation stays ON. Do not call `supabase--configure_auth` to disable unless the user explicitly asks.

## Phase 6. Hero feature pattern

For a "track X" style product:

1. Add table plus RLS
2. List page (`/items`) with empty state CTA
3. Add dialog with form (react-hook-form plus zod)
4. Detail page (`/items/:id`) with edit/delete
5. One AI moment, "Get advice on this item", edge function, streamed response

For an AI-first product (chat, generation):

1. Conversation table plus messages table
2. Edge function that calls Lovable AI Gateway (handle 429 and 402 explicitly)
3. Stream tokens to UI via SSE
4. Save full conversation on completion

**Lovable AI edge function skeleton:**

```ts
const LOVABLE_API_KEY = Deno.env.get("LOVABLE_API_KEY");
const res = await fetch("https://ai.gateway.lovable.dev/v1/chat/completions", {
  method: "POST",
  headers: {
    Authorization: `Bearer ${LOVABLE_API_KEY}`,
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    model: "google/gemini-2.5-flash",
    messages: [{ role: "user", content: prompt }],
  }),
});
if (res.status === 429) return new Response("Rate limit", { status: 429 });
if (res.status === 402) return new Response("Out of credits", { status: 402 });
```

## Phase 7. Stripe in 4 edge functions

| Function | Purpose | Auth |
|---|---|---|
| `create-checkout` | Make a Checkout Session, return URL | JWT required |
| `customer-portal` | Make a Billing Portal session | JWT required |
| `check-subscription` | Sync DB from Stripe (idempotent) | JWT required |
| `stripe-webhook` | Receive events, update `subscriptions` | JWT off, verify signature |

In `supabase/config.toml`:

```toml
[functions.stripe-webhook]
verify_jwt = false
```

Tier gating hook:

```tsx
const { tier, isActive } = useSubscription();
const canUseProFeature = isActive && (tier === "pro" || tier === "premium");
```

Soft limits beat hard walls. "You're on free, add 5 more by upgrading" converts better than "Limit reached."

## Phase 8. Email infrastructure

Run `email_domain--setup_email_infra` early. While DNS propagates, build the templates.

Required templates (React Email plus the project's `_shared/transactional-email-templates/` pattern):

- `welcome`: fires on first signup
- `subscription-confirmation`: fires on `customer.subscription.created`
- Custom auth: signup confirmation, magic link, password reset

Suppression check before every send:

```ts
const { data } = await supabase.from("suppressed_emails").select("email").eq("email", to).maybeSingle();
if (data) return; // skip
```

Unsubscribe flow: link to `/unsubscribe?token=...`, marks email in `suppressed_emails`.

## Phase 9. SEO essentials

Per-page `<SEOHead>` component (see `skills/personal/business-launch/templates/seo-head.tsx`).

**JSON-LD on landing:**

```tsx
<script type="application/ld+json">{JSON.stringify({
  "@context": "https://schema.org",
  "@type": "WebApplication",
  name: "Your App",
  url: "https://yourapp.com",
  description: "...",
  offers: { "@type": "Offer", price: "4.99", priceCurrency: "USD" },
})}</script>
```

**Sitemap rules:**

- Only public routes
- Accurate `<lastmod>` dates (update them when you ship changes)
- Verify each URL with `curl -I` returns `200`, not `301/302`
- Submit to Google Search Console after each major release

**The "page with redirect" trap:** a sitemap URL wrapped in `ProtectedRoute` redirects to `/auth`, and Google drops the entire sitemap's authority. Fix by making the route public, even if the conversion action requires auth.

## Phase 10. Launch checklist

See `skills/personal/business-launch/checklists/launch.md`.

## Common rescues

| Symptom | Fix |
|---|---|
| Google: "Page with redirect" | Move route out of `ProtectedRoute`, remove from sitemap if truly auth-only |
| RLS errors on insert | You forgot the `INSERT` policy or `user_id` isn't being set |
| Stripe webhook 401 | `verify_jwt = false` missing in `config.toml` |
| Email not sending | Check `suppressed_emails`, then domain verification status |
| AI 429 | Add user-facing toast, surface "try again in a moment" |
| AI 402 | Lovable AI credits exhausted, tell user to top up workspace |
| Trial users not converting | Add a usage milestone email at day 5 of trial |

## What to do when stuck

1. Reproduce the bug yourself before guessing (browser tools, console logs, network tab).
2. Read the actual error message. Don't pattern-match.
3. If 3 attempts fail, change approach (simpler implementation, different library, ask user).
4. Verify the fix with the same signal that revealed the bug.
