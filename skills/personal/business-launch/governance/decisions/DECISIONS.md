# Decision Log

> Append-only log of CEO decisions made via the expert panel. Never edit past entries — add new ones that supersede.

Format:

```
## YYYY-MM-DD — [Short title]
DECISION: [the call]
WHY: [paragraph]
TRADEOFFS: [what we gave up]
REVERSIBLE?: yes / no
REVISIT WHEN: [trigger]
PANEL CONFLICTS: [who disagreed and why]
```

---

## YYYY-MM-DD — Example: Free tier plant limit set to 5
DECISION: Free tier capped at 5 plants. Upgrade prompt at plant #6.
WHY: Casual users with 1–4 plants get full value free → become advocates. Power users with yards hit the cap fast and convert. Finance modeled cost-per-free-user at $0.04/mo at 5 plants — sustainable.
TRADEOFFS: Some prosumers will churn at the limit instead of upgrading. We accept that.
REVERSIBLE?: Yes — limit is a config value.
REVISIT WHEN: Free→paid conversion < 2% at 1k signups, OR cost-per-free-user exceeds $0.10.
PANEL CONFLICTS: Growth wanted 10 (more virality). Finance wanted 3 (faster monetization). Customer voted 5–7. CEO chose 5.
