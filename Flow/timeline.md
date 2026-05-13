# Project Timeline

Last updated: —

This file is the authoritative snapshot of project progress. Update it whenever a task changes status. See `research_plan.md` for full details on each phase, including gate requirements (Results Review, Referee Report).

- [ ] **Timeline set up** — The first agent to work on this project must replace the placeholder phases below with the actual phases, milestones, and sub-tasks relevant to this specific study. Delete rows that don't apply, add rows that do, and fill in target dates where known. Once done, tick this checkbox.

| Phase | Target Date | Status | Blocked By | Date Done | Notes |
|-------|-------------|--------|------------|-----------|-------|
| **Pre-analysis plan** | | Pending | — | | Gate — complete `pre_analysis_plan.md` (all checklist items ticked) before research plan |
| Research plan | | Pending | Pre-analysis plan | | Builds on PAP — complete `research_plan.md` |
| Design finalisation | | Pending | Research plan | | |
| Pre-registration | | Pending | Design finalisation | | |
| Data collection | | Pending | Pre-registration | | |
| Data cleaning | | Pending | Data collection | | |
| Variable generation | | Pending | Data cleaning | | |
|   ↳ Codebook populated | | Pending | Variable generation | | Gate — `Context/Flow/codebook.md` Raw Variables, Generated Variables, and Exclusions must be filled before analysis |
| Balance table | | Pending | Codebook populated | | |
| Descriptives | | Pending | Codebook populated | | |
| Hypothesis tests | | Pending | Balance table, Descriptives | | |
| Robustness checks | | Pending | Hypothesis tests | | |
| Exploratory analyses | | Pending | Hypothesis tests | | |
| **Results review** | | Pending | Robustness checks, Exploratory analyses | | Gate — produce `Context/Flow/results_review.md` using `Context/Roles/results_review_checklist.md` before writing |
| Writing | | Pending | Results review | | |
| **Referee report — Cycle 1** | | Pending | Writing | | Gate — Theory & Framework review; see `Context/Roles/profile_referee_cycle1.md` |
| **Referee report — Cycle 2** | | Pending | Writing | | Gate — Results & Integration review; see `Context/Roles/profile_referee_cycle2.md` |
|   ↳ Referee report synthesised | | Pending | Referee report — Cycle 1, Referee report — Cycle 2 | | Merge into final `referee_report.md`; see `Context/Roles/profile_referee.md` |
| **Revise & resubmit** | | Pending | Referee report synthesised | | Address all referee comments; see `Context/Roles/revision_protocol.md` |
| Submission | | Pending | Revise & resubmit | | |

## How to maintain this timeline

- When a task is **completed**: set Status to `Done`, fill in Date Done, add notes.
- When a task is **in progress**: set Status to `In progress`.
- When a task is **blocked**: set Status to `Blocked` and explain in Notes.
- When new tasks emerge: **add new rows** with their `Blocked By` dependencies.
- If a phase has sub-tasks, indent them beneath the parent phase (prefix with `  ↳`).
- **Before starting a task**: check its `Blocked By` column. If any listed phase is not `Done`, the task cannot begin.
- **After completing a task**: check if any downstream tasks were blocked only by this one — if so, they are now unblocked and can begin.
- During **revision cycles**: add sub-rows for each cycle (e.g., "Revise & resubmit (cycle 2)") following `Context/Roles/revision_protocol.md`.
- **Always update "Last updated"** at the top of this file when making changes.
