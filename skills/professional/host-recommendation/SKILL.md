---
name: host-recommendation
description: Write a hiring recommendation after candidate interviews by synthesizing a packet of feedback from multiple interviewers. Used when Gabe is the host leader (not when he's an individual interviewer). Triggers on "host recommendation for X", "write the recommendation", "synthesize interviews for X", or "/host-recommendation".
user_invocable: true
---

# host-recommendation

Synthesize an interview packet into a hiring recommendation. Full guide:
`guides/professional/host-leader-recommendation.md (in this repo)`.

## Inputs

Ask Gabe for:
1. Candidate name.
2. Role and level being considered.
3. Path to the interview packet (PDF, markdown, or list of scorecards).

## Steps

1. Create folder `candidates/<name>/` if it doesn't exist. Save the packet
   there.
2. Read every interviewer's scorecard / feedback in full. Do not skim.
3. Look for:
   - Agreement across interviewers (strong signal, either direction)
   - Disagreement (weak signal — needs investigation or acknowledgement)
   - Evidence gaps (important dimension not probed)
   - Level calibration (do the examples cited match the target level?)
4. Write the recommendation in the format from the guide. Sections typically:
   - Decision (Hire / No Hire / Hire with reservations) + recommended level
   - Where the signal was strong (with supporting quotes/examples)
   - Where the signal was weak or contradictory
   - What to watch for in onboarding / first 90 days if hired
5. Save to `candidates/<name>/recommendation.md`.

## Tone

Plain and direct. No corporate cushioning ("while we have some concerns, we
believe..."). Say Hire or No Hire, then show your work.

If you recommend Hire at a lower level than posted, say so explicitly and
explain. If you recommend No Hire, be clear about why and what specific
evidence led there — these recommendations are often re-examined.

Assume the reader is the recruiting partner and the hiring VP. They want a
decision, not a narrative.
