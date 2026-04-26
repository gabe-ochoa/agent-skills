---
name: career-coaching
description: Prepare for a quarterly (or ad hoc) career coaching conversation with one of Gabe's direct reports. Produces a forward-looking prep doc grounded in their most recent review, prior career conversations, and observed behavior. Triggers on "career coaching prep for X", "career conversation prep for X", "prep for my 1:1 with X about career", "/career-coaching <name>", or "/career-coaching-prep <name>".
user_invocable: true
---

# career-coaching

Write a career coaching conversation prep doc for one of Gabe's direct reports. Full guide:
`guides/professional/career-coaching-conversations.md (in this repo)`.

## Inputs

Ask Gabe for (or infer):
1. Direct report's name.
2. Date of the meeting (default: the next Friday if not given).
3. Cadence (quarterly, post-review, ad hoc). Default: quarterly.

Then, before writing, gather:
1. Most recent review at `people/team/<name>/reviews/<cycle>/review.md`. Also read `self-review.md` and `peer-feedback.md` if present.
2. Any prior career conversation prep at `people/team/<name>/career-conversations/`. The newest one is the baseline for "what changed."
3. Any other context Gabe offers in the conversation (recent 1:1 observations, skip-level feedback, Slack signals).

If any of these are missing, ask before writing.

## Steps

1. Resolve the meeting date. If Gabe said "Friday" and today isn't Friday, compute the next Friday. Prep filename uses that date.
2. **Detect the meeting type.** Three cases, in order of priority:
   - **First-review case:** no file under `people/team/<name>/reviews/`. This is a brand-new reporting relationship or a first review cycle with this person. Structure: discovery (self-read first) → calibration (2-3 strengths + 1-2 dev areas only if Gabe observed them) → direction → experiment. The brag sheet at `people/team/<name>/brag-sheet/` is the substrate. Read it fully. Flag staleness and offer `/perf-feedback:brag-sheet` refresh.
   - **First-post-review case:** a review exists but no career conversation prep post-dates it (or the most recent prep was drafted but the meeting didn't happen). Ask Gabe explicitly: "Was the review the last career touchpoint, or did you have a conversation about it?" Do not assume. Structure: review debrief (per development area) → direction → experiment. Recommend 75 minutes.
   - **Standard quarterly:** prior career conversation prep exists and the meeting happened. Structure per the default in the guide. 60 minutes.
3. Read the most recent review in full (if one exists). Pull out:
   - Top 2-3 strengths (with one supporting quote each).
   - Top 2-3 development areas.
   - Any named people (directs, peers) referenced in the feedback. They matter for experiment design.
4. For first-review cases: read the brag sheet summary in full, plus 1-2 source files (github.md, jira.md, slack.md) for texture. Note the brag sheet date range and staleness. Do not manufacture development feedback from brag sheet patterns. Flag observation gaps instead.
5. Read any prior career conversation prep. If one was drafted but never used, note that in the new prep's header and treat its content as raw material, not history.
6. Write the prep to `people/team/<name>/career-conversations/<YYYY-MM-DD>-prep.md` following the structure in the guide. Do not skip sections. Do not combine sections.
7. When offering the growth experiment menu, rank options by what the review's development areas (or brag sheet signals, for first-review cases) imply they most need. Tie each option back to concrete evidence in one line.
8. Verbatim questions. Where the guide says "write the opening question verbatim," write the actual words Gabe should use. Short. Direct. Not a speech.
9. Update `people/TOPICS.md` under **Career Conversations**. Add a line: `- [<Name> - <YYYY-MM-DD> (<cadence>)](team/<name>/career-conversations/<YYYY-MM-DD>-prep.md)`.

## Tone

The prep is coach-to-coach. Gabe will read it 30 minutes before the meeting.

- Short sentences.
- Verbatim wording where it matters.
- Name the hard thing directly. If the person needs to hear a hard read from Gabe, the prep says so plainly.
- No emdashes. No corporate softening. No hedging.

## What good looks like

A prep that lets Gabe walk in with: one opening question, one core question, one menu of experiments ranked and tied to feedback, and a four-line commitment template to fill at the end. No more, no less.

If you produce more than ~300 lines of prep, you're doing it wrong. Tighten.
