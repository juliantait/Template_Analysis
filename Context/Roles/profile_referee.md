# Referee Profile — Orchestration

## Overview

The referee report is produced by **two independent subagents** running in parallel, each with a clean context window. Neither agent has access to the conversation history from the writing process. Each receives only the manuscript files, the pre-analysis plan, and its own profile.

The main thread **must not** perform the referee work itself. It orchestrates the two agents, collects their reports, and synthesises the final output. This is the only way to guarantee independence — an agent that helped write the paper cannot referee it honestly.

---

## The Two Cycles

| Cycle | Profile | Focus | Timeline Gate |
|-------|---------|-------|---------------|
| Cycle 1 | `profile_referee_cycle1.md` | Theory & Framework | Referee report — Cycle 1 |
| Cycle 2 | `profile_referee_cycle2.md` | Results & Integration | Referee report — Cycle 2 |

### Execution Order

1. **Spawn Cycle 1 and Cycle 2 in parallel.** Each is a fresh Task subagent with no prior context.
2. **Wait for Cycle 1 to complete first** (or at least extract its "introduction's promise" output). Pass this list to Cycle 2 if Cycle 2 has not yet started, or note any mismatches during synthesis.
3. **Collect both partial reports.**
4. **Synthesise** into the final referee report (see below).

### Spawning Rules

1. Each referee agent is spawned as a **fresh Task subagent** with no prior context.
2. The prompt for each agent must include:
   - The full text of the manuscript sections relevant to their cycle (copy the content in — do not reference files the agent cannot read).
   - The full text of `research_plan.md` (the pre-analysis plan). This is mandatory for both cycles.
   - The full text of their specific profile (`profile_referee_cycle1.md` or `profile_referee_cycle2.md`).
3. The two agents run **in parallel**. They must not see each other's full output.
4. Each agent returns a structured partial report. The main thread merges these into the final referee report.

---

## Synthesis: Producing the Final Report

After both agents return their partial reports, the main thread merges them into a single referee report. The main thread should:

1. **Check for agreement and disagreement.** Where both cycles flag the same issue, this is high-confidence. Where they disagree (e.g., Cycle 1 says the contribution is clear but Cycle 2 says the results don't deliver on it), highlight the tension — this is often where the most important problems live.
2. **Run the promise-delivery check.** Take Cycle 1's list of what the introduction promises and compare it against Cycle 2's audit of what the results deliver. Mismatches are major comments.
3. **Merge the PAP deviation audits.** Combine Cycle 1's hypothesis-level audit and Cycle 2's analysis-level audit into a single PAP compliance summary. Flag:
   - **Undisclosed deviations** — anything that changed from the PAP but is not acknowledged in the paper. These are always major comments.
   - **Deviations that favour the authors** — specification changes, variable redefinitions, or dropped analyses where the deviation conveniently supports the preferred result. These warrant a pointed question even if disclosed.
   - **Missing pre-registered analyses** — tests that were planned but never reported. The authors must either report them or explain why they were dropped.
   - **Exploratory analyses presented as confirmatory** — results not in the PAP that are discussed without labelling them as exploratory.
4. **Deduplicate.** If both cycles raise the same minor point, keep it once.
5. **Assign an overall recommendation.** Based on the combined evidence:
   - **Reject**: Fatal flaws in either the theoretical framework or the empirical execution. No feasible path to publication.
   - **Major revision**: Serious problems exist but a path to a publishable paper is visible with substantial additional work.
   - **Minor revision**: The paper is essentially sound but needs tightening, clarification, or small additional analyses.

### Final Report Structure

1. **Summary** (2-3 sentences) — what the paper does and what it finds, in the referee's own words.
2. **Overall assessment** — recommendation (reject / major revision / minor revision) with a clear, upfront justification.
3. **PAP compliance summary** — a consolidated table of all deviations from the pre-analysis plan (hypotheses, variables, analyses), whether each is disclosed, and whether each favours the authors' preferred result. End with a one-paragraph assessment: does the paper faithfully execute the pre-analysis plan, or has it drifted in ways that undermine the credibility of the confirmatory claims?
4. **Major comments** — numbered, synthesised from both cycles. Each must explain (a) the problem, (b) why it matters, (c) what the authors could do.
5. **Minor comments** — numbered, deduplicated.
6. **Questions for the authors** — things you genuinely want clarified, not rhetorical complaints.

If the two cycles cannot identify at least two substantive major concerns between them, the agents are probably not reading critically enough. Even strong papers have weaknesses — find them.
