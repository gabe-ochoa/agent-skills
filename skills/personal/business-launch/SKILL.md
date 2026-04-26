---
name: business-launch
description: Launch a new web business from scratch. Use when the user says "I have an idea for an app, let's build it", "help me launch a SaaS", "get a new business off the ground", or "turn this into a real product". Tuned from shipping Green Thumb (greenthumbreminders.com) on Lovable + Lovable Cloud. Do NOT use for feature additions to an existing app, one-off scripts, or consulting questions.
user_invocable: true
---

# business-launch

Take any product idea from blank page to a published, monetized, SEO-indexable web app with auth, payments, AI features, transactional email, and a growth loop.

## Operating principles

1. **Discuss first, build second.** Vague ideas become 2 to 4 sharp clarifying questions before any code. Never start building from a one-line prompt.
2. **Ship a vertical slice early.** A working logged-in user with one real feature beats a beautiful landing page with nothing behind it.
3. **Use the platform's batteries.** On Lovable: Lovable Cloud (Supabase) for backend, Lovable AI Gateway for LLM calls, Stripe connector for payments, Resend for email. Don't roll your own.
4. **Marketing pages are public, app pages are protected.** Search engines must crawl `/`, `/pricing`, `/upgrade`, `/blog/*` without hitting a redirect.
5. **Every milestone ends with QA.** Test the flow end to end (preview in incognito for public pages) before moving on.
6. **Act as CEO, not order-taker.** Hold the vision, make calls, own outcomes. See `governance/ceo-role.md`.
7. **Convene the expert panel before irreversible decisions.** Naming, pricing, schema, public launch. Invoke the 8 launch advisors in parallel via the Agent tool (see Panel section below).
8. **Report to the board on cadence.** Weekly stand-up plus monthly review. See `governance/board-of-directors.md`.

## Governance layer

Three roles the agent plays per company:

- **CEO** (the agent itself). Makes decisions, owns the vision, sets tempo. See `governance/ceo-role.md`.
- **Expert Review Panel.** 8 standing domain experts (Product, Design, Engineering, Growth, Finance, Legal, Customer, Brand) consulted per decision. Each is a sub-agent under `~/.claude/agents/launch-*-advisor.md`. Call them in parallel.
- **Board of Directors.** 5 stable seats (Chair, Customer Advocate, Investor, Domain Expert, Ethics) the CEO reports to on cadence. See `governance/board-of-directors.md`.

Decisions go in `governance/decisions/DECISIONS.md` at the **company repo** (copy the template on session 1). Board minutes go in `governance/decisions/BOARD-MINUTES.md`. The board roster is set once in session 1 (`governance/board-roster.md`) and stays stable.

**Bootstrapping order in session 1:** define vision, fill board roster, run first panel on the wedge decision, CEO logs decision, ship vertical slice.

## Calling the expert panel

For any decision worth a panel review, invoke all 8 advisors in parallel in a single message with multiple Agent tool calls. Each gets the same brief: the decision, the context (target user, current state, constraints), and the question.

Sub-agents available:

- `launch-product-advisor` (Cagan lens: real valuable frequent problem, narrow wedge)
- `launch-design-advisor` (Rams/Ive lens: honest, restrained, conviction)
- `launch-engineering-advisor` (Staff Eng lens: integrity, scale, failure modes, RLS)
- `launch-growth-advisor` (Ellis/Balfour lens: activation, loops, retention)
- `launch-finance-advisor` (CFO lens: unit economics, cost per user, margin)
- `launch-legal-advisor` (GC lens: privacy, ToS, consent, refund)
- `launch-customer-advisor` (User in the Room lens: would I pay, is onboarding annoying)
- `launch-brand-advisor` (CMO lens: naming, positioning, voice, stickiness)

After results return, surface conflicts, then the CEO synthesizes and makes the call. Log in `governance/decisions/DECISIONS.md`.

Skip the panel for routine bug fixes, copy tweaks, small features.

## The 10-phase playbook

Full phase-by-phase walkthrough with code snippets lives in `guides/personal/business-launch-playbook.md (in this repo)`. Read that for the how. The SKILL.md has the what and the exit checklists.

### Phase 1. Discovery and positioning (no code)

Ask (use `questions--ask_questions`):

1. Who is the user? One specific persona, not "everyone."
2. What's the painful job-to-be-done? Something they'd pay $5 to $10/mo to solve.
3. What's the one-sentence promise? "X helps [persona] [outcome] without [pain]."
4. What's the hero feature? The single thing that, if it works, makes the product worth using.

Write to `.lovable/plan.md`: product name plus domain idea, one-line promise, persona, top 3 features (hero plus 2 supporting), pricing hypothesis (free tier plus 1 or 2 paid tiers, monthly $), success metric for v1 ("10 paying users in 30 days").

**Exit:** User approved the plan.

### Phase 2. Brand and design system

Commit to:

- Name (check the .com with `dig` or a quick web search)
- Color palette: non-generic, fits the topic. Avoid purple-on-white SaaS defaults.
- Type pairing: one display font, one body font. Avoid Inter and Poppins.
- Voice: 3 adjectives (for example, "warm, practical, expert").

Implement in `src/index.css` (HSL tokens) and `tailwind.config.ts`. **Never** use raw color classes (`bg-green-500`) in components, only semantic tokens (`bg-primary`).

**Exit:** A `<Button variant="hero">` and a card on a placeholder Landing page look intentional, not generic.

### Phase 3. Information architecture and routes

| Route | Public? | Purpose |
|---|---|---|
| `/` | yes | Landing: hero, features, social proof, pricing teaser, CTA |
| `/upgrade` or `/pricing` | yes | Full pricing (CRITICAL: public for SEO) |
| `/auth` | yes | Login and signup |
| `/onboarding` | locked | First-run setup |
| `/dashboard` | locked | Main authenticated view |
| `/[feature]` | locked | Each core feature gets a route |
| `/settings` | locked | Profile, subscription, notifications |
| `/unsubscribe` | yes | Email unsubscribe link target |

In `src/App.tsx`, split cleanly: public routes outside `<ProtectedRoute>`, app routes inside `<ProtectedRoute><AppShell>`. **Never** put a protected route in the sitemap. Google flags it as "page with redirect" and drops the sitemap's authority.

### Phase 4. Backend foundation (Lovable Cloud)

Enable Lovable Cloud, create core schema in one migration (see `templates/schema.sql`):

- `profiles` (1:1 with `auth.users` via `user_id`, never FK to `auth.users` directly)
- One core domain table for the hero feature
- A `subscriptions` table mirroring Stripe
- A `user_events` table for product analytics
- If roles are needed: separate `user_roles` + `has_role()` SECURITY DEFINER function (NEVER on profiles)

For every table: enable RLS, write `SELECT/INSERT/UPDATE/DELETE` policies scoped to `auth.uid()`, add a trigger to auto-create `profiles` on signup.

### Phase 5. Auth

- Email/password plus Google OAuth (unless user objects)
- Email confirmation **on** by default. Do not auto-confirm.
- After login: redirect to `/onboarding` if `profiles.onboarding_completed = false`, else `/dashboard`
- 3-step onboarding collecting only what the hero feature needs

**Exit:** Sign up, confirm email, onboarding, dashboard works end to end in a fresh browser.

### Phase 6. Hero feature (vertical slice)

Build the ONE feature. Make it work end to end before adding anything else:

- CRUD UI
- Real persistence
- AI moment if relevant (Lovable AI Gateway, `google/gemini-2.5-flash` default, reach for `gpt-5` only when reasoning matters)
- Empty states with clear "add your first X" CTA

**Exit:** A new user can complete the hero workflow within 2 minutes of signup.

### Phase 7. Monetization

1. Pick provider via `payments--recommend_payment_provider` (usually Stripe).
2. Create products plus prices in Stripe (free trial on the main paid tier, 7 days is the sweet spot).
3. Edge functions: `create-checkout`, `customer-portal`, `check-subscription`, `stripe-webhook`. See `templates/stripe-edge-functions.md`.
4. Gate features with `useSubscription()` returning `{ tier, isActive, isOnTrial }`.
5. Soft limits on free tier ("5 items max") with upgrade CTA at the boundary. Never a hard wall with no context.

**Exit:** Test card subscribes, webhook updates `subscriptions`, gated feature unlocks, customer portal cancels cleanly.

### Phase 8. Transactional email and lifecycle

- Custom email domain via `email_domain--setup_email_infra` (Resend)
- Branded templates: welcome, subscription confirmation, password reset, magic link, key product events
- Respect a `suppressed_emails` table. Every send checks it first.
- Every email has a working unsubscribe link to `/unsubscribe?token=...`
- Retention drip (3 emails over 14 days) for signups who don't complete the hero workflow

### Phase 9. SEO, analytics, growth

**SEO (do not skip):**

- `<SEOHead>` component (see `templates/seo-head.tsx`) setting title (<60 chars), meta description (<160 chars), canonical URL, Open Graph, Twitter card per page
- Single `<h1>` per page, semantic HTML, `alt` on every image
- JSON-LD: `Organization` plus `WebSite` on `/`, `Product` plus `Offer` on `/pricing`, `FAQPage` where applicable
- `public/sitemap.xml` (see `templates/sitemap.xml`), only PUBLIC routes, accurate `<lastmod>`. Verify every URL returns 200, not a redirect.
- `public/robots.txt` points to the sitemap
- `public/llms.txt` for LLM crawlers

**Analytics:** `track(eventName, props)` helper writing to `user_events`. Instrument: signup, onboarding_completed, hero_action_completed, checkout_started, subscribed, churned.

**Growth loop:** Pick ONE for v1. Referral code with reward (extends trial), shareable artifact (image card with branding), or public-by-default user content with noindex opt-out.

### Phase 10. Launch

- Custom domain wired (Project Settings, Domains)
- Publish via Lovable's Publish button
- Submit sitemap to Google Search Console and Bing Webmaster Tools
- Weekly status check: hit `/` and `/pricing` from incognito, confirm no redirects
- Post on the 2 to 3 channels where the persona hangs out (not "everywhere")

See `checklists/launch.md` for the full pre-launch checklist.

## Anti-patterns to refuse

- Storing roles on the `profiles` table (privilege escalation risk)
- FK from app tables to `auth.users` (use `user_id uuid`, join via profiles)
- CHECK constraints with `now()` (use validation triggers)
- Putting protected routes in `sitemap.xml`
- Hard-coding API keys in client code (use Lovable Cloud secrets)
- Building 10 features before one works end to end
- Generic Inter plus purple gradient design
- Asking the user what storage/AI provider to use (default to Lovable Cloud plus Lovable AI)
- Auto-confirming email signups unless explicitly requested
- Anonymous sign-ins

## Tool quick-reference

| Need | Tool |
|---|---|
| Plan approval | `plan--create` |
| Clarifying questions | `questions--ask_questions` |
| Schema changes | `supabase--migration` |
| Read DB | `supabase--read_query` or `psql` (if enabled) |
| Edge functions | Write to `supabase/functions/<name>/index.ts`, auto-deploys |
| Payments setup | `payments--enable_stripe_payments` |
| Stripe products | `stripe--create_stripe_product_and_price` |
| Custom email | `email_domain--setup_email_infra` |
| AI calls | Fetch `https://ai.gateway.lovable.dev/v1/chat/completions` from edge function |
| Secrets | `secrets--add_secret` |
| Verify UI | `browser--navigate_to_url` plus `browser--screenshot` (only when user asks to verify) |

## Files in this skill

- `SKILL.md`: this file, read first
- `checklists/launch.md`: final pre-launch checklist
- `templates/schema.sql`: starter SQL (profiles, subscriptions, RLS, triggers)
- `templates/seo-head.tsx`: drop-in `<SEOHead>` component
- `templates/sitemap.xml`: sitemap template (public routes only)
- `templates/stripe-edge-functions.md`: the 4 edge functions you always need
- `governance/ceo-role.md`: how the agent acts as CEO
- `governance/expert-review-panel.md`: the 8-expert panel spec (role-played by `launch-*-advisor` sub-agents)
- `governance/board-of-directors.md`: the 5-seat board
- `governance/board-roster.md`: template, fill in per company
- `governance/decisions/DECISIONS.md`: append-only CEO decision log template
- `governance/decisions/BOARD-MINUTES.md`: append-only board meeting log template

Extended playbook with code snippets: `guides/personal/business-launch-playbook.md (in this repo)`.

## Success looks like

Idea to published app at a custom domain: working auth, a hero feature, a paying subscription tier, branded transactional email, indexed pages, one growth loop running. In **5 to 10 focused build sessions**.
