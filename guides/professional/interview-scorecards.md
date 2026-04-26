# Interview Scorecards Guide

A guide for writing interview scorecards when **you are the interviewer**. Different from `host-leader-recommendation.md`, which is for synthesizing a packet of feedback from multiple interviewers.

Use this guide when Gabe conducts the interview directly and needs to produce a scorecard that will be pasted into Greenhouse or a similar ATS form.

---

## Core Principles

1. **Level is about scope and impact, not headcount.** 14 reports in a lane is not the same as 14 reports across a portfolio. Always separate span of control from strategic scope.
2. **Push for concrete examples, not process descriptions.** "We do t-shirt sizing" is process. "I cut feature X to hit the deadline" is a concrete example.
3. **Name the gaps honestly.** If the candidate's partner-management story resolved itself through an org decision rather than their drive, say so. The scorecard is for a future leader, not a sales pitch.
4. **Use their words when possible.** If they said "own a problem, not a scope," quote it. Do not paraphrase into softer language.
5. **Write like you talk.** No corporate jargon. No hedging. Refer to the style rules in `host-leader-recommendation.md`.
6. **No emdashes.** Use periods, commas, or colons instead.

---

## Style: Impact Mode

Gabe's scorecards are concise, bulleted, and lead with the verdict. Do not default to long prose paragraphs. Rewrite any paragraph that has more than two sentences into bullets.

**Section shape:**

- **Headline verdict in bold at the top of every evaluation section.** Examples: "Hire at EM1 (mid). Not an EM2." / "Strong for EM1. Not EM2." / "Good for EM1. Not EM2." / "Below expectations."
- **Bullets under the verdict.** One idea per bullet. Verb-first or noun-phrase-first, not "The candidate demonstrated that..."
- **Nested bullets for multi-step stories.** A pushback or conflict story has 3-5 steps. Nest them under a parent bullet instead of writing it as a paragraph.
- **Short phrases over full sentences where the meaning is clear.** "No PM in the loop on core model work." not "There was no product manager involved in the core model work."

**Banned patterns:**

- Opening a section with "Candidate described..." or "He said..." or "Fjorilda described..." Start with the verdict.
- Paragraphs longer than 2 sentences. Break them.
- Hedging words: "seems", "might", "probably", "potentially", "appears to."
- Inflated praise: "exceptional", "one of the strongest", "truly outstanding." If they were a clear hire, say why. If they were not, say that.
- Corporate softening: "exhibited behaviors aligned with", "demonstrated capability", "showcased."

**Good vs bad:**

Bad:
> The candidate described a half-by-half planning process that is anchored on revenue impact. Organizational leadership sets revenue targets, and he works with tech leads to align staffing and scope to those targets. He uses historical trends as a lever to push back when goals feel unrealistic.

Good:
> - Half-by-half planning anchored on revenue. Org leads set targets. He walks back to staffing with tech leads.
> - Uses historical trends to push back when goals are unrealistic.

**Length target:** A full EM scorecard should be readable in 3-5 minutes. If yours is longer, it has too much prose.

---

## Workflow

### Step 1: Take raw notes during the interview

Capture what the candidate actually said, not your interpretation. Bullet points are fine. Tag evaluation questions to the competency area (Q2 = Product, Q3 = Execution, Q4 = Partner).

### Step 2: Decide Hire/No Hire and Level first

Before writing the narrative, answer these three questions:

1. Is this a hire?
2. At what level, and with what granularity (low / mid / high)?
3. What is the single sentence that captures why?

If you cannot answer these without re-reading the notes five times, the interview did not produce a clear signal. Name that in Q1.

### Step 3: Ground the level in scope, not headcount

For EM candidates, look for:

| Signal | EM1 | EM2 |
|--------|-----|-----|
| Reports | ICs | Managers or proto-managers (tech leads with real delegation) |
| Scope | One product area in a larger org | Multi-team portfolio, defines the lane |
| Pushback | Within their team's half | Reshapes portfolio across teams |
| Partner conflict | Peer-to-peer resolution | Drives the org-level resolution |
| Market articulation | Bonus | Required |

If the candidate sits between levels, say so. Name what would move them up.

### Step 4: Fill out the scorecard template

Use `people/candidates/_template/scorecard.md` as the starting point. One section per evaluation area. Each section should:

- Describe what the candidate said (specifics, numbers, names)
- Describe what they did (their approach, their framework)
- Describe the outcome (what happened, what they learned)
- End with an evaluation line: Strong / Meets / Below for the target level, one sentence on why

### Step 5: Save and link

Save to `people/candidates/<firstname-lastname>/scorecard.md`. If you do not know the candidate's name yet (e.g., you are drafting from anonymized notes), use a placeholder folder like `people/candidates/unnamed-<role>-<date>/scorecard.md` and rename later.

### Step 6: Update TOPICS.md

Add the candidate to the `Candidates (Hiring)` section in `people/TOPICS.md`. Do this in the same session; the human will not remember.

---

## Evaluation Areas (EM Product and Delivery Management Interview)

### Q1: Hire/No Hire, Level, Key Takeaways

- Bold headline on line 1: e.g., "Hire at EM1 (mid). Not an EM2." or "No hire."
- 4-5 bullets of key takeaways immediately after. Each one is a specific observation, not a generic praise.
- End with a bolded "To hit EM2" or "To be a hire" line listing 2-3 specific gaps.

### Q2: Product/Portfolio Management

How do they decide what to work on? How do they involve team and business? Can they give a real pushback story with a concrete outcome?

**Look for:**
- A system that connects business goals to team scope to individual work
- A pushback story where they changed a decision, not just defended the status quo
- Evidence they use (data, POCs, trends), not just opinions

**Watch for:**
- Process descriptions without concrete examples
- Pushback stories that are actually just explaining a decision to an engineer
- Over-reliance on top-down planning with no team input

### Q3: Execution Management

How do they ship on time? What do they do when things slip? How has AI changed their execution?

**Look for:**
- A real cadence (milestones, dependency tracking, early detection)
- A failure story with tradeoffs, not just escalation and postponement
- A grounded AI perspective that names both the gains and the failure modes

**Watch for:**
- Only describing process, never describing a concrete tradeoff
- Delivery failures where the only response was "ask for more time"
- Generic AI hype ("AI makes us faster") without domain-specific examples

### Q4: Partner Management

Can they resolve a disagreement with another manager? Do they keep stakeholders informed proactively?

**Look for:**
- A disagreement story with empathy for the other side
- Resolution through shared artifacts, unblocking, or reframing, not just escalation
- Proactive communication patterns (status updates, surfacing progress, preventing surprises)

**Watch for:**
- Blame without empathy ("they just didn't get it")
- Conflicts that resolved themselves via org decisions, not their drive
- Stakeholder communication limited to one mechanism ("product review" and nothing else)

### Q5: Questions Candidate Asked

Asking deep questions is a positive indicator. Capture the questions and note the depth.

### Q6: Additional Comments / Raw Notes

Team composition, background, communication style, yellow flags, green flags, and follow-ups worth probing in later rounds. This section is for the future interviewer, not for the hiring decision.

---

## Level Anchoring

When you hand in a scorecard, someone else will read it and calibrate. Make their job easier:

- State the level explicitly: "EM1 with growth trajectory" is better than "maybe EM1, maybe EM2."
- State the granularity: low, mid, or high inside the level.
- Name the evidence that anchored your level call.
- Name the evidence that would have moved them up or down.

If you are unsure, say so. "This interview did not produce enough signal to separate EM1 from EM2. Here is what a later round should probe" is a legitimate outcome.

---

## Example Scorecards

- `people/candidates/fjorilda-gjermizi/scorecard.md`: EM1 no-hire. Process without concrete examples, delivery failure with no tradeoffs.
- `people/candidates/unnamed-em-pdm-2026-04-21/scorecard.md`: EM1 hire with growth trajectory. Strong within-lane stories, narrower than headcount suggests.

---

## Self-Check Before Submission

- [ ] Hire/No Hire decision is explicit in Q1.
- [ ] Level is explicit with granularity (low / mid / high).
- [ ] Each evaluation question has concrete examples, not just process.
- [ ] Gaps are named honestly, not softened.
- [ ] Strengths are specific, not inflated.
- [ ] No emdashes. No hedging ("seems", "might", "probably").
- [ ] Follow-ups are listed for the next interviewer.
- [ ] Candidate name is in the filename and folder (or placeholder is marked for rename).
