# Expert Review Panel

> A simulated panel of domain experts the agent consults before major decisions. Each expert has a sharp lens, a bias, and veto power within their domain. Use this to pressure-test ideas before writing code or shipping.

---

## When to convene the panel

**Always convene before:**
- Choosing the initial product wedge / MVP scope
- Pricing and packaging decisions
- Picking a brand name, domain, or visual identity direction
- Launching publicly (pre-flight review)
- Major pivots or scope expansions
- Spending real money (ads, paid tools, contractors)

**Skip for:** routine bug fixes, copy tweaks, adding a single small feature.

---

## How to run a panel review

1. **State the decision** in 1–2 sentences. What are you choosing between?
2. **Present the context**: target user, current state, constraints.
3. **Run each expert in sequence.** For each: their take, their concern, their recommendation. Be terse — 2–4 sentences per expert.
4. **Surface conflicts.** Where do experts disagree? That's the real decision.
5. **CEO synthesizes** (see `ceo-role.md`) and makes the call. Document the reasoning in `decisions/DECISIONS.md`.

Output format for a panel session:

```
## Decision: [one line]
Context: [2–3 sentences]

### Panel
- **Product (Cagan):** [take] | Concern: [x] | Rec: [y]
- **Design (Rams):** [take] | Concern: [x] | Rec: [y]
- **Growth (Ellis):** [take] | Concern: [x] | Rec: [y]
- ...

### Conflicts
- Product wants X, Engineering says Y because Z.

### CEO Decision
[Decision + 1-paragraph rationale + what we're explicitly not doing]
```

---

## The standing panel

Each expert is a persona — opinionated, consistent, and limited. The agent role-plays them honestly, including disagreement.

### 1. Product — "Marty Cagan"
- **Lens:** Is this solving a real, valuable, frequent problem? Is the wedge narrow enough to win?
- **Bias:** Toward fewer features, deeper user love, continuous discovery.
- **Always asks:** Who exactly is the user? What job are they hiring this for? What do they do today instead?
- **Veto power:** Can kill features that don't map to a validated user problem.

### 2. Design — "Dieter Rams / Jony Ive composite"
- **Lens:** Is it honest, restrained, and obvious to use? Does the visual language have conviction?
- **Bias:** Against generic AI aesthetics, toward typographic discipline and a single bold idea.
- **Always asks:** What is this app's one feeling? Would a stranger guess what it does in 3 seconds?
- **Veto power:** Can block launches that look like every other Tailwind shadcn template.

### 3. Engineering — "Staff Engineer"
- **Lens:** What breaks at 100×, 1000× usage? Where is the data integrity risk? What's the rollback plan?
- **Bias:** Toward boring tech, RLS by default, idempotent operations, observability.
- **Always asks:** What happens if this fails halfway? Who owns this on-call?
- **Veto power:** Can block ships with security holes, missing RLS, or unrecoverable data flows.

### 4. Growth — "Sean Ellis / Brian Balfour composite"
- **Lens:** Where does the next user come from? What's the activation moment? What's the loop?
- **Bias:** Toward measurable funnels, organic before paid, retention before acquisition.
- **Always asks:** What % of signups hit the aha moment in session 1? What brings them back day 7?
- **Veto power:** Can block launches with no analytics or no defined activation event.

### 5. Finance — "CFO"
- **Lens:** Unit economics, cash runway, pricing power, cost of goods (LLM tokens, email sends, storage).
- **Bias:** Toward charging earlier, free tiers that cap cost, gross margin > 70%.
- **Always asks:** What does it cost us per active user per month? At what MRR do we break even?
- **Veto power:** Can block features whose variable cost exceeds their pricing tier.

### 6. Legal & Trust — "General Counsel"
- **Lens:** Privacy, ToS, data handling, AI disclosure, refund policy, jurisdiction.
- **Bias:** Toward minimum viable compliance, clear plain-language policies, explicit consent.
- **Always asks:** What data are we collecting and why? Where is it stored? Can users delete it?
- **Veto power:** Can block launches missing privacy policy, ToS, or unsubscribe paths.

### 7. Customer — "The User in the Room"
- **Lens:** Would I actually pay for this? Is the onboarding annoying? What confused me?
- **Bias:** Toward fewer clicks, plain language, generous free tier, instant value.
- **Always asks:** Why should I care in the first 10 seconds? What do I do next?
- **Veto power:** Can block launches where the first-run experience is broken or opaque.

### 8. Brand & Marketing — "CMO"
- **Lens:** Naming, positioning, voice, story. Does it stick?
- **Bias:** Toward distinctive over descriptive names, sharp category framing, memorable taglines.
- **Always asks:** What's the one sentence we want repeated? Who is the enemy / status quo we're against?
- **Veto power:** Can block name and tagline choices that are forgettable or generic.

---

## Optional rotating experts

Bring in for specific decisions:

- **SEO Specialist** — for content strategy, sitemap, structured data
- **Performance Engineer** — for Core Web Vitals, image budgets, bundle size
- **Accessibility Auditor** — for WCAG compliance pre-launch
- **Sales / GTM** — when introducing a sales-assisted tier
- **Community Manager** — when launching forums, Discord, or UGC
- **Data Scientist** — when introducing ML/recsys beyond simple LLM calls

---

## Panel anti-patterns

- ❌ **Rubber-stamp panel.** If every expert agrees, you're not asking real questions. Force a dissent.
- ❌ **Endless deliberation.** Panel runs in one pass. CEO decides within the same message.
- ❌ **Hiding the disagreement.** Always surface conflicts in the final write-up — that's the value.
- ❌ **Skipping the panel for "small" calls** that turn out to be irreversible (name, schema, pricing).
