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

1. **State the decision** in 1 to 2 sentences. What are you choosing between?
2. **Present the context**: target user, current state, constraints.
3. **Run all eight advisors in parallel**, one Agent call each in a single message, with the same brief. Each returns a verdict and findings.
4. **Surface conflicts.** Where do experts disagree? That's the real decision.
5. **CEO synthesizes** (see `ceo-role.md`) and makes the call. Document the reasoning in `decisions/DECISIONS.md`.

Output format for a panel session:

```
## Decision: [one line]
Context: [2 to 3 sentences]

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

Each advisor is a sub-agent with its own lens, bias, questions, and domain veto in `agents/launch-*-advisor.md` in the agent-skills repo. Those files are the source of truth.

| Seat | Sub-agent | Can veto |
|---|---|---|
| Product ("Marty Cagan") | `launch-product-advisor` | Features that don't map to a validated user problem |
| Design (Rams / Ive) | `launch-design-advisor` | Launches that look like a stock Tailwind shadcn template |
| Engineering (Staff Engineer) | `launch-engineering-advisor` | Security holes, missing RLS, unrecoverable data flows |
| Growth (Ellis / Balfour) | `launch-growth-advisor` | Launches with no analytics or activation event |
| Finance (CFO) | `launch-finance-advisor` | Features whose variable cost exceeds their tier price |
| Legal & Trust (General Counsel) | `launch-legal-advisor` | Launches missing privacy policy, ToS, or unsubscribe |
| Customer (User in the Room) | `launch-customer-advisor` | Broken or opaque first-run experience |
| Brand (CMO) | `launch-brand-advisor` | Forgettable or generic names and taglines |

---

## Optional rotating experts

Bring in for specific decisions:

- **SEO Specialist**: for content strategy, sitemap, structured data
- **Performance Engineer**: for Core Web Vitals, image budgets, bundle size
- **Accessibility Auditor**: for WCAG compliance pre-launch
- **Sales / GTM**: when introducing a sales-assisted tier
- **Community Manager**: when launching forums, Discord, or UGC
- **Data Scientist**: when introducing ML/recsys beyond simple LLM calls

---

## Panel anti-patterns

- ❌ **Rubber-stamp panel.** If every expert agrees, you're not asking real questions. Force a dissent.
- ❌ **Endless deliberation.** Panel runs in one pass. CEO decides within the same message.
- ❌ **Hiding the disagreement.** Surface conflicts in the final write-up; that's the value.
- ❌ **Skipping the panel for "small" calls** that turn out to be irreversible (name, schema, pricing).
