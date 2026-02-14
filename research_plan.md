# Research Plan

## Research Idea

[Describe the core research idea. What gap in the literature does this address? Why is it important?]

## Research Question

[State the primary research question(s) clearly and concisely.]

## Theoretical Framework

[Outline the theoretical basis for the study. What existing theories or models inform the hypotheses?]

## Design

[Describe the experimental/study design: between/within-subject, number of treatments, randomisation strategy, etc.]

## Hypotheses

[List pre-registered or planned hypotheses with expected directions.]

- H1:
- H2:
- H3:
- H4:

## Variables

### Independent Variables

[List and define treatment/independent variables.]

### Dependent Variables

[List and define outcome/dependent variables and how they are measured.]

### Controls

[List any control variables or covariates.]

## Sample

[Describe the target population, recruitment strategy, sample size, and any power calculations.]

## Analysis Strategy

[Outline the planned statistical approach: primary tests, robustness checks, exploratory analyses.]

## Timeline

- [ ] **Timeline set up** — The first agent to work on this project must replace the placeholder phases below with the actual phases, milestones, and sub-tasks relevant to this specific study. Delete rows that don't apply, add rows that do, and fill in target dates where known. Once done, tick this checkbox (`- [x]`).

The rows below are defaults. They exist to be **rewritten**, not used as-is.

| Phase                | Target Date | Status    | Date Done  | Notes                        |
|----------------------|-------------|-----------|------------|------------------------------|
| Design finalisation  |             | Pending   |            |                              |
| Pre-registration     |             | Pending   |            |                              |
| Data collection      |             | Pending   |            |                              |
| Data cleaning        |             | Pending   |            |                              |
| Variable generation  |             | Pending   |            |                              |
| Balance table        |             | Pending   |            |                              |
| Descriptives         |             | Pending   |            |                              |
| Hypothesis tests     |             | Pending   |            |                              |
| Robustness checks    |             | Pending   |            |                              |
| Exploratory analyses |             | Pending   |            |                              |
| **Results review**   |             | Pending   |            | Gate before writing — see below |
| Writing              |             | Pending   |            |                              |
| **Referee report**   |             | Pending   |            | Gate before submission — see below |
| **Revise & resubmit**|             | Pending   |            | Address all referee comments        |
| Submission           |             | Pending   |            |                              |

### Results review (gate before writing)

**Do not begin writing until this phase is complete.** Once all analysis scripts have run and results are generated, stop and critically review everything before moving on. This is not a formality — it is a substantive checkpoint.

The agent must:

1. **Read all generated output** — every table, graph, and text file in `Output/`.
2. **Compare results against hypotheses** — which were supported, which were not, and which were ambiguous? Are effect sizes meaningful or trivially small?
3. **Stress-test the empirical strategy** — do the results suggest the identification strategy is sound, or do they raise concerns (e.g. failed balance checks, unexpected patterns in controls, implausible coefficients)? Would a reviewer find the approach credible given these results?
4. **Check for coherence across analyses** — do descriptives, hypothesis tests, robustness checks, and exploratory results tell a consistent story? Flag any contradictions.
5. **Identify necessary adjustments** — if the results call for changes to variable definitions, sample restrictions, additional controls, alternative specifications, or reframing of hypotheses, make those changes now. Update the relevant scripts, re-run, and log the decision in `Context/research_log.md`.
6. **Update the research plan** — revise the Analysis Strategy, Hypotheses, or Variables sections of this file if anything changed.
7. **Record lessons** — add any non-obvious findings to the Notes for Future Agents table below.

Only once this review is done and the results are stable should the timeline move to Writing.

### Referee report (gate before submission)

**Do not submit until this phase is complete.** Once the paper is fully drafted, a separate agent must be spawned to act as an anonymous referee. This is not optional.

The referee agent must:

1. **Adopt the referee persona** described in `Context/profile_referee.md`. Read that file in full before beginning.
2. **Read the entire manuscript** — all LaTeX section files, all figures, all tables. Understand the paper as a whole before commenting.
3. **Read the research plan and analysis output** — the referee should understand what was done, not just what was written up.
4. **Write a full referee report** following the structure in `Context/profile_referee.md` (summary, overall assessment, major comments, minor comments, questions for the authors).
5. **Save the report to the project root** using the following naming convention:
   - First report: `referee_report.md`
   - Subsequent reports (after revisions): `referee_report_2.md`, `referee_report_3.md`, etc.
   - Before writing, check which reports already exist and increment accordingly. Previous reports must never be overwritten — they form a history of how the paper improved.
6. **Be genuinely critical** — the point of this exercise is to catch problems before a real referee does. A friendly report is a useless report.

The referee agent should be spawned as a dedicated subagent with its own context so that it approaches the paper fresh, without the baggage of having written it.

The referee-then-revise cycle is **iterative**. After a Revise & Resubmit round, spawn a new referee agent to write a fresh report on the revised manuscript. Repeat until the referee's overall assessment is that the paper is publishable (minor revision or accept). Each iteration produces a new numbered report file.

### Revise and resubmit

Once the referee report is complete, a new session begins to address every comment. This is a full revise-and-resubmit cycle, not a cosmetic pass.

The revising agent must:

1. **Read the latest referee report** (the highest-numbered `referee_report*.md` in the project root) in full.
2. **Triage comments** — classify each major and minor comment as: (a) agree and will fix, (b) partially agree, or (c) disagree. For (b) and (c), prepare a reasoned response.
3. **Make substantive changes** — if the referee identifies problems with the empirical strategy, variable definitions, sample restrictions, robustness checks, or framing, fix them. This may mean re-running analysis scripts, generating new output, and rewriting sections. Do not treat this as a writing-only task.
4. **Rewrite the paper** — revise every section of the manuscript as needed. The goal is a paper that would satisfy the referee, not a paper with patches.
5. **Write a response document** — save a point-by-point response to the project root, numbered to match the report it responds to (e.g. `referee_response.md` for the first, `referee_response_2.md` for the second, etc.).
6. **Log all decisions** in `Context/research_log.md` and update `research_plan.md` if the design or analysis strategy changed.
7. **Record lessons** in the Notes for Future Agents table below.
8. **Spawn a new referee** — after the revision is complete, spawn a fresh referee agent to write the next numbered report on the revised manuscript. Repeat the cycle until the referee recommends minor revision or accept.

Only once the referee is satisfied and the final revision is complete should the timeline move to Submission.

### How to maintain this timeline

- **First agent**: Set up the timeline (see checkbox above). After setup, update this table as work progresses.
- When a task is **completed**, set its Status to `Done` and fill in the Date Done column.
- When a task is **in progress**, set its Status to `In progress`.
- When a task is **blocked** by something, set its Status to `Blocked` and explain in Notes.
- When new tasks emerge during the work, **add new rows** to the table.
- If a phase needs to be broken into sub-tasks, indent them beneath the parent phase.

## Notes for Future Agents

This section collects hard-won lessons, gotchas, and institutional knowledge that a future agent needs when picking up the next stage of this research. Add to this section whenever you learn something that isn't obvious from the code or context files alone.

Each entry should include a date and a short description of the lesson.

| Date | Lesson |
|------|--------|
|      |        |
