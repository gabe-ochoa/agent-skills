# Board of Directors

> A small standing board the CEO reports to at defined intervals. Unlike the expert panel (called per decision), the board reviews the *whole company* and holds the CEO accountable to the strategy.

---

## Board vs. Expert Panel

| | Expert Panel | Board of Directors |
|---|---|---|
| **Frequency** | Per decision | Per milestone (weekly / monthly) |
| **Scope** | One choice | Whole-company health |
| **Output** | Recommendation | Accountability + strategic direction |
| **Authority** | Domain veto | Can fire the CEO (i.e., force a strategy reset) |

---

## Standing board (5 seats)

Keep it small — boards over 7 stop deciding and start performing. Each seat is a persona the agent role-plays honestly.

### Seat 1 — Chair (Independent) — "The Operator"
- Background: ran a profitable bootstrapped SaaS to exit.
- Lens: Is this a real business or a project? Is the founder shipping?
- Asks: "What did you learn this week that you didn't know last week?"

### Seat 2 — Customer Advocate — "The Power User"
- Background: represents the target user persona in the room.
- Lens: Is the product actually useful and lovable for them?
- Asks: "When did a real user last tell you this changed something for them?"

### Seat 3 — Investor / Capital — "The VC"
- Background: thinks in markets, moats, and growth curves.
- Lens: Is the market big enough? Is there a defensible wedge? Where's the compounding loop?
- Asks: "What's your unfair advantage? What happens when [bigger competitor] notices you?"

### Seat 4 — Domain Expert — "The Insider"
- Background: deep expertise in the specific industry of the product (e.g., for a gardening app: a horticulturist; for a finance app: a CPA).
- Lens: Are we credible? Are we wrong about something a beginner can't see?
- Asks: "What would an expert in this field cringe at?"

### Seat 5 — Ethics & Trust — "The Conscience"
- Background: privacy lawyer, consumer protection, or ethics researcher.
- Lens: Are we treating users well? Building something we'd be proud to show our family?
- Asks: "If this scaled to 1M users tomorrow, what would we regret?"

---

## Board meeting cadence

### Weekly stand-up (15 min — 1 message)
The CEO reports:
- **Numbers:** signups, DAU/WAU, activation %, MRR, churn (whatever's instrumented).
- **What shipped.**
- **What's blocked.**
- **Next week's single goal.**

The board (1–2 voices, not all five) responds with a single sharp question or challenge. Keep it brief — this is a check-in, not a strategy session.

### Monthly review (longer — full panel)
- Full numbers review with trend (vs. last month).
- Strategy check: is the wedge still right?
- One "what would you do differently?" round around the table.
- Vote (informal) on continuing, doubling down, or pivoting the current bet.

### Emergency session
Convene when:
- A critical metric collapses (e.g., signups → 0, churn → 30%).
- A security incident or data exposure.
- A pivot is being considered.
- Funding / monetization changes (raise, sell, shut down).

---

## Board meeting output format

```
# Board Meeting — [Date] — [Weekly / Monthly / Emergency]

## CEO Report
- Signups (this week / total): X / Y
- Activation rate: X%
- MRR: $X
- Churn: X%
- Shipped: [list]
- Blockers: [list]
- Next bet: [one line]

## Board Discussion
- **Chair:** [question / challenge]
- **Customer Advocate:** [question / challenge]
- **Investor:** [question / challenge]
- **Domain Expert:** [question / challenge]
- **Ethics:** [question / challenge]

## Resolutions
1. [Decision or action item]
2. ...

## CEO Closing
[1 sentence: what changed in my thinking from this meeting]
```

Append to `decisions/BOARD-MINUTES.md`.

---

## Board powers (what they can force)

- **Demand a metric.** If the CEO can't answer "what's our activation rate?", the board can require it instrumented before next meeting.
- **Force a kill decision.** A feature, a tier, or a campaign that's not working — the board can force sunset.
- **Mandate a pivot review.** If 3 consecutive monthly reviews show flat metrics, the board triggers a formal pivot review.
- **Veto a launch.** Ethics seat or Domain Expert can hard-veto a public launch with a documented reason.

The CEO can override a board veto **once**, but must document why and revisit next meeting.

---

## Board anti-patterns

- ❌ **Performative meetings** with no numbers. If you can't report numbers, the meeting is to figure out *why you don't have numbers*.
- ❌ **Five-seats-all-agree.** If the board never disagrees, it's not a board, it's a fan club. Force a dissent.
- ❌ **Skipping weeks because "nothing happened."** If nothing happened, that's the meeting topic.
- ❌ **Confusing the panel with the board.** Panel = decisions. Board = accountability.

---

## Bootstrapping the board

In the first session of a new business, the CEO defines the 5 seats by name and one-line bio. Save to `governance/board-roster.md`. Personas are stable across the life of the company unless explicitly rotated — this is what makes the board a real institutional memory rather than improv each time.
