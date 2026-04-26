# Host Leader Recommendation Guide

A guide for turning interview packets into clear hiring recommendations.

---

## Core Principles

1. **Back it up**: Every claim needs a specific example from the interviews
2. **Be balanced**: Cover both strengths and concerns with equal honesty
3. **Be direct**: No hedging ("seems like", "might be"). Say what you mean
4. **Quote exactly**: Use interviewers' exact words, typos and all
5. **Write plainly**: No corporate jargon. If you wouldn't say it out loud, don't write it

---

## Workflow

### Step 1: Create Candidate Folder

```
/dd/people/candidates/[candidate-name]/
```

### Step 2: Collect Interview Materials

Put these in the candidate folder:

- **interview-packet.pdf** : The full interview packet
- **interviews/** : One summary file per interview (technical-1.md, design.md, etc.)

### Step 3: Process Each Interview

For each interview, create a summary:

```markdown
# [Interview Type]: [Interviewer Name]

**Overall Signal:** Strong Hire / Hire / Lean Hire / Lean No Hire / No Hire / Strong No Hire

## Key Observations
- [What happened, with specifics]
- [What happened, with specifics]

## Strengths
- [Strength]: "[Exact quote from interviewer]"

## Concerns
- [Concern]: "[Exact quote from interviewer]"

## Notable Quotes
> "[Something worth remembering]"
```

### Step 4: Write the Recommendation

Create `recommendation.md` pulling together all interviews.

### Step 5: Update TOPICS.md

Add the candidate to the `Candidates (Hiring)` section in `people/TOPICS.md`. Do this in the same session; the human will not remember.

---

## Required Assessments

### IC Competency Assessments

| # | Competency | What to Assess |
|---|------------|----------------|
| 1 | **Coding** | How they solve problems, code quality, optimization, debugging. Pull from all coding interviews. |
| 2 | **Design** | How they scope problems, weigh tradeoffs, think about scale, explain decisions. |
| 3 | **Experience and Values** | What they've built, how they've led, whether they'll fit the culture, whether they improve things around them. |

Rate each: **Exceeds Bar** / **Meets Bar** / **Below Bar**

### EM Scorecard Assessments

For engineering manager candidates, the scorecard uses a different structure. The interviewer fills out a form with these sections:

| Question | Evaluation Area | What to Assess |
|----------|----------------|----------------|
| Q1 | **Hire/No Hire, Level, Key Takeaways** | Overall decision with specific reasoning. State the core concern or strength clearly. Don't be vague about why. |
| Q2 | **Product/Portfolio Management** | How they decide what to work on, how they involve the team and business, how they push back on bad asks. |
| Q3 | **Execution Management** | How they ship on time, handle delivery failures, make tradeoffs under pressure, and drive process improvements. |
| Q4 | **Partner Management** | How they resolve disagreements with other managers, keep stakeholders informed, and build trust across teams. |
| Q5 | **Questions Candidate Asked** | What questions they asked. Good questions show they're thinking about how they'd operate in the role. |
| Q6 | **Additional Comments/Raw Notes** | Team size, org context, background info, overall patterns from the interview. |
| Q7 | **Market Articulation (bonus for EM1)** | Can they explain where their product sits in the market and company ecosystem? |
| Q8 | **Prioritization Methods** | Do they use effective methods for prioritizing work and involving the right stakeholders? |
| Q9 | **Product Delivery** | How effectively do they manage delivery? Look for concrete examples, not just process descriptions. |
| Q10 | **Partner Communication** | Have they shown proactive communication and negotiation with partners? |

**Key guidance for EM scorecards:**

- Push for concrete examples, not process descriptions. "We do t-shirt sizing" is process. "I cut feature X to hit the deadline" is a concrete example.
- On execution: the critical question is whether they can make tradeoffs to hit deadlines. If they only describe escalating and postponing, that's a gap.
- On pushback: look for examples of changing a decision, not just defending the status quo.
- On partner management: look for resolution details and empathy for the other side, not just identifying the disagreement.
- Q7 (market articulation) is bonus for EM1, required for EM2+.

### Final Decisions

| # | Question | Options |
|---|----------|---------|
| 1 | **Hire?** | Yes / No |
| 2 | **Level** | SE1 / SE2 / Senior / EM1 / EM2 / Staff+, with granularity: low, mid, or high |
| 3 | **Track** | Backend Generalist / Frontend / Distributed Systems / Engineering Management |
| 4 | **Why this level?** | Explain your reasoning. Address any weak areas or unusual background. |

---

## Recommendation Format

```markdown
# Host Leader Recommendation: [Candidate Name]

**Position:** [Role Title]
**Interview Date(s):** [Date Range]

---

## Recommendation Summary

| Field | Assessment |
|-------|------------|
| **Recommend for Hire?** | [Yes / No] |
| **Recommended Level** | [SE1 / SE2 / Senior / EM / Staff+] ([low / mid / high]) |
| **Recommended Track** | [Backend Generalist / Frontend / Distributed Systems] |

---

## Executive Summary

[2-3 sentences. What's this person good at? What's the main concern, if any? Write like you're explaining to a colleague.]

---

## Competency Assessments

### 1. Coding

**Assessment:** [Exceeds Bar / Meets Bar / Below Bar]

[One paragraph covering all coding interviews. What problems did they solve? How did they approach them? Was the code clean? Could they optimize? If one interview went well and another didn't, explain both.]

**Supporting Evidence:**
- "[Exact quote]",[Interviewer], [Interview Type]
- "[Exact quote]",[Interviewer], [Interview Type]
- "[Exact quote]",[Interviewer], [Interview Type]

---

### 2. Design

**Assessment:** [Exceeds Bar / Meets Bar / Below Bar]

[One paragraph. Did they ask good questions? Did they think about scale? Did they make sensible tradeoffs? What did they get right without prompting? What needed a nudge?]

**Supporting Evidence:**
- "[Exact quote]",[Interviewer], [Interview Type]
- "[Exact quote]",[Interviewer], [Interview Type]
- "[Exact quote]",[Interviewer], [Interview Type]

---

### 3. Experience and Values

**Assessment:** [Exceeds Bar / Meets Bar / Below Bar]

[One paragraph. What have they built? How big was their scope? Do they take ownership? Do they admit mistakes? Have they mentored people? Will they fit here?]

**Supporting Evidence:**
- "[Exact quote]",[Interviewer], [Interview Type]
- "[Exact quote]",[Interviewer], [Interview Type]
- "[Exact quote]",[Interviewer], [Interview Type]

---

## Interview Signal Summary

| Interview Type | Interviewer | Signal | Key Takeaway |
|----------------|-------------|--------|--------------|
| Coding 1 | [Name] | [Signal] | [One sentence] |
| Coding 2 | [Name] | [Signal] | [One sentence] |
| Design | [Name] | [Signal] | [One sentence] |
| Values | [Name] | [Signal] | [One sentence] |
| Experience | [Name] | [Signal] | [One sentence] |

---

## Level Justification

**Recommended Level:** [Level] ([low / mid / high])
**Recommended Track:** [Track]

### Why This Level
[What makes them right for this level? Give specific evidence.]

### Weak Areas *(if any)*
[Did they fall short anywhere? Why is it still okay to hire?]

### Unusual Background *(if applicable)*
[If their experience is non-traditional, explain why the level still fits.]

### Debrief Conclusion
[What did the panel decide and why?]

---

## Final Recommendation

**Recommend for Hire:** [Yes / No]
**Level:** [Level] ([low / mid / high])
**Track:** [Track]

### Rationale
[2-3 short paragraphs. Why hire or not hire? Keep it simple.]

### Onboarding Considerations *(if hiring)*

**Strengths to leverage:**
- [Strength]
- [Strength]

**Areas to develop:**
- [Area]
- [Area]

**Team fit:**
- [Consideration]
- [Consideration]
```

---

## Writing Guidelines

### Write Like You Talk

**Bad:** "The candidate demonstrated strong problem-solving capabilities and exhibited ownership behaviors aligned with our cultural values."

**Good:** "She solved the problem quickly and owns her work."

**Bad:** "Divergent signals across coding interviews suggest mixed technical proficiency."

**Good:** "He passed Coding 2 with a Strong Yes but failed Coding 1."

**Bad:** "The concern is bounded and does not undermine the overall assessment."

**Good:** "The gap is real but narrow."

### Words to Avoid

| Don't write | Write instead |
|-------------|---------------|
| demonstrated | showed / did / has |
| exhibited | showed / has |
| leveraged | used |
| utilized | used |
| facilitated | helped / led / ran |
| aligned with | fits / matches |
| divergent signals | mixed results / passed one, failed one |
| bounded | narrow / small / limited |
| actionable | useful / clear |
| holistically | (just remove it) |
| synthesize | pull together / combine |
| surface (as a verb) | find / show / raise |
| emdashes (—) | Use a period, comma, or colon instead. Emdashes muddy sentence structure. |

### Be Specific

**Weak:** "Strong coding skills"

**Strong:** "Completed all 6 steps without a bug, knew React patterns cold"

**Weak:** "Good design thinking"

**Strong:** "Asked about scale upfront, chose SSE over WebSockets and explained why"

### Handle Mixed Results Honestly

If someone passed one interview and failed another, say so directly:

**Bad:** "Exhibited divergent performance across technical assessments with contextual factors potentially impacting outcomes."

**Good:** "He passed Coding 2 with a Strong Yes and failed Coding 1 with a No. In Coding 2, he wrote bug-free code. In Coding 1, he got a working solution but couldn't optimize it without help. The debrief concluded this makes sense given his startup background."

### Don't Soften Concerns

If an interviewer said "struggled significantly," don't write "had some difficulty."

If something was a problem, call it a problem.

### Don't Inflate Strengths

If someone did well, say they did well. You don't need to say they were "exceptional" or "one of the strongest candidates."

### Quote Rules

**Quotes must be exact.** Don't fix typos. Don't clean up grammar. Don't paraphrase and put quotes around it.

You can:
- Use "..." to skip parts
- Add [context] in brackets if needed for clarity
- Add [sic] if a typo might confuse readers

---

## Signal Calibration

| Signal | What it means |
|--------|---------------|
| **Strong Hire** | Exceptional. We'd be making a mistake not to hire them. |
| **Hire** | Meets the bar. Would make the team stronger. |
| **Lean Hire** | Probably meets the bar but some uncertainty. Hire if we need people. |
| **Lean No Hire** | Probably below the bar. Pass unless something changes. |
| **No Hire** | Below the bar. Clear gaps. |
| **Strong No Hire** | Well below the bar or red flags. |

---

## Combining Feedback

When multiple interviewers noticed the same thing, combine it into one narrative:

**Before (scattered):**
- Coding 1: "Good at breaking down problems"
- Coding 2: "Structured approach, no bugs"
- Design: "Clear thinking under pressure"

**After (combined):**

He approached problems methodically across all interviews. In Coding 1, he broke down the problem into subproblems before writing code. In Coding 2, he did the same thing and finished bug-free. In design, he "created a clear framework before diving into components."

**Supporting Evidence:**
- "Good at breaking down problems",[Interviewer A], Coding 1
- "Structured approach, no bugs",[Interviewer B], Coding 2
- "Clear thinking under pressure",[Interviewer C], Design

---

## Pre-Finalization Checklist

Before you submit, check:

- [ ] Each competency has 2-3 exact quotes as evidence
- [ ] Quotes are actually verbatim (no edits)
- [ ] Related feedback is combined by theme
- [ ] Specific examples given (problem names, project names, scenarios)
- [ ] Level includes granularity: low, mid, or high (e.g., "Senior Engineer (mid)")
- [ ] Level justification is clear
- [ ] Interview summary table is complete
- [ ] Recommendation is clear
- [ ] No hedging ("seems", "might", "probably")
- [ ] Concerns aren't softened
- [ ] Strengths aren't inflated
- [ ] No jargon
- [ ] Spell check and grammar pass completed (don't fix verbatim quotes)

---

## Folder Structure

When you're done:

```
/dd/people/candidates/[candidate-name]/
├── interview-packet.pdf
├── interviews/                # IC candidates
│   ├── coding-1.md
│   ├── coding-2.md
│   ├── design.md
│   ├── values.md
│   └── experience.md
├── scorecard.md               # EM candidates (form-based scorecard)
└── recommendation.md
```

---

## Example: Interview Summary

```markdown
# Coding 1: Sarah Chen

**Overall Signal:** Hire

## Key Observations
- Solved binary tree serialization optimally without hints
- Talked through edge cases before coding
- Code was clean on first pass

## Strengths
- **Algorithm design**: "Immediately identified this as a preorder traversal problem and explained the tradeoffs vs level-order"
- **Code quality**: "Production-ready code with clear variable names"

## Concerns
- **Testing**: "Only wrote happy path tests when prompted"

## Notable Quotes
> "This is the cleanest tree serialization I've seen in an interview."
```

---

## Example: Competency Assessment

```markdown
### 1. Coding

**Assessment:** Meets Bar

Jason passed Coding 2 with a Strong Yes and failed Coding 1 with a No. In Coding 2 (Activity Monitor), he completed all 6 steps without a bug. He knew React patterns cold: localeCompare, useEffect cleanup, component decomposition. Neil Taylor called it "fantastic" and noted he "didn't miss a beat."

In Coding 1 (Related Tags), he got a working solution but couldn't optimize it on his own. He had the right instinct (precompute the tag index) but needed help figuring out what to optimize for. He also used lists where sets would have been better.

The debrief concluded this makes sense: he knows how to code, but his startup work didn't require much algorithmic thinking. The Coding 2 result confirms he can ship production code.

**Supporting Evidence:**
- "Fantastic coding 2 interview, Jason didnt miss a beat. He really has a knack for returning solutions, i dont think he had one bug throughout.",Neil Taylor, Frontend Coding 2
- "He has definitely done a lot of react JS, he knew the localeCompare api right away as well as sorting.",Neil Taylor, Frontend Coding 2
- "TC had an inkling that the tag index could be precomputed, but wasn't able to drive that discussion on their own without guidance.",Zach Lite, Frontend Coding 1
```
