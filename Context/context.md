# Context

Read this file first. Study the relevant linked context files depending on your task.

## Researcher

See `Context/Roles/researcher_profile.md` for background on the researcher, field, and target journal.

## Project Structure

This is a self-contained empirical analysis project. All scripts are sourced in numbered order from `Scripts/00_main.R`. Output is written to `Output/Graphs/`, `Output/Tables/`, and `Output/Text/` via the `save_graph()`, `save_table()`, and `save_text()` helper functions defined in `Scripts/01_settings.R`.

- Settings, palette, and theme: `Scripts/01_settings.R`
- Data preparation: `Scripts/02_cleaning.R` → `Scripts/03_variable_generation.R` → `Scripts/04_sample_restrictions.R`
- Analysis: `Scripts/05_balance_table.R` through `Scripts/09_exploratory.R`

## Decision Log

See `Context/Flow/research_log.md` for a chronological record of all design and analytical decisions with rationale.

## Analysis Conventions

- British English spelling throughout all output.
- Statistical methodology, test conventions, and standard-error choices are defined in the active researcher personality profile. See `Context/Roles/researcher_profile.md` and the linked personality file.

## Output Naming Convention

All saved output files follow the pattern:

```
{script}_{analysis}_{descriptor}.{ext}
```

| Component      | Description                                                                 | Source                                                        |
|----------------|-----------------------------------------------------------------------------|---------------------------------------------------------------|
| `{script}`     | The analysis stage that generated the file, matching the script name.       | `balance`, `descriptives`, `hypotheses`, `robustness`, `exploratory` |
| `{analysis}`   | The specific analysis or sub-section within that script.                    | e.g. `learning`, `gender`, `manager_types`, `reporting`       |
| `{descriptor}` | What the output shows. Be specific enough to identify it without opening.   | e.g. `mistake_hiding_rates`, `mean_outcomes_matched`, `by_round` |
| `{ext}`        | File type: `.png` for graphs, `.tex` for tables, `.txt` for text.          |                                                               |

All parts use **lowercase** with **underscores** as separators. No spaces, no camelCase.

### Examples

| File                                                  | Script              | Analysis        | Descriptor              |
|-------------------------------------------------------|----------------------|-----------------|-------------------------|
| `balance_demographics.tex`                            | 05_balance_table     | —               | demographics            |
| `descriptives_values.txt`                             | 06_descriptives      | —               | values                  |
| `hypotheses_h1_hiding_by_stakes.png`                  | 07_hypotheses        | h1              | hiding_by_stakes        |
| `robustness_regression_treatment_with_controls.tex`   | 08_robustness        | regression      | treatment_with_controls |
| `exploratory_learning_mistake_hiding_rates.png`       | 09_exploratory       | learning        | mistake_hiding_rates    |
| `exploratory_manager_types_mean_outcomes_matched.tex` | 09_exploratory       | manager_types   | mean_outcomes_matched   |

### Rules
- If a script has only one output, the `{analysis}` part can be omitted (e.g. `balance_demographics.tex`).
- The `{descriptor}` should be readable enough that you can identify the content from the filename alone.
- Use the same naming in the `save_graph()`, `save_table()`, and `save_text()` calls — the function appends the file extension automatically.

## Codebook

See `Context/Flow/codebook.md` for variable-level documentation of the dataset: raw variables, generated variables, recoding decisions, and exclusions. Populated as needed during data preparation.

## Pre-Analysis Plan

See `pre_analysis_plan.md` for the pre-registered core commitments: main hypotheses, dependent variables, conditions, planned analyses, exclusion rules, and sample size. This is the **starting point** for any new project — it must be completed before the research plan.

## Research Plan

See `research_plan.md` for the full study design. It builds on the pre-analysis plan, adding theoretical framework, detailed variable definitions, codebook references, timeline, and review gates.

## Agent Guidance

The `Context/Agents/` folder contains operational protocols for AI agents working on this project:

| File | Purpose |
|------|---------|
| `Context/Agents/researcher_interview.md` | Decision-tree questionnaire for eliciting the PAP from a researcher with minimal input |
| `Context/Agents/results_review_checklist.md` | Item-by-item checklist for the results review gate (replaces vague "stress-test" instruction) |
| `Context/Agents/subagent_protocol.md` | Rules for when/how to spawn subagents, output format, handoff, and context isolation |
| `Context/Agents/revision_protocol.md` | Multi-cycle revision protocol: when to re-run scripts, output versioning, cascade rules |

## Task-Specific Context

### Graphs
If you are making a graph, study `Context/Tasks/graphs.md`.

### Tables
If you are making a table, study `Context/Tasks/tables.md`.

### Writing
If you are writing paper text or LaTeX, study `Context/Roles/researcher_profile.md` for journal conventions.

### Referee Report
If you are acting as a referee, study `Context/Roles/profile_referee.md` for the persona and report structure.

## What Goes Where

### Design decisions (variable choices, test selection, exclusion rules, coding schemes)
- **Finalised version** goes into `research_plan.md` — this is what someone reads to understand the current design.
- **Rationale and history** goes into `Context/Flow/research_log.md` — this is what someone reads to understand *why* the design looks the way it does, and what alternatives were considered or rejected.

### Project-wide conventions (coding style, output naming, statistical defaults)
- Goes into `Context/context.md`. These are rules that apply across all scripts and don't change between analyses.

### Data quirks and cleaning notes (unexpected codes, missing data patterns, variable gotchas)
- Go into `Context/Flow/research_log.md` under the relevant decision entry.
- Critical data-loading instructions (file format, required packages, special codes) are also noted in `research_plan.md` so they're visible upfront.

### Variable documentation (names, types, valid values, derivations)
- Goes into `Context/Flow/codebook.md`. This is the single source of truth for what every variable means, where it came from, and how it was constructed.
- Before populating the codebook, check `Data/` for any codebook or data documentation that shipped with the dataset. If one exists, use it as the primary source and reproduce the relevant information in `Context/Flow/codebook.md`. If none exists, build the codebook from scratch by examining the data.
- The codebook is populated as needed during data preparation and kept current as variables are created or recoded.

### Implementation details (which R function, which package, specific code patterns)
- Live in the scripts themselves as comments. Not duplicated in documentation files.

## How to Use This System

**Starting a new session**: Read `Context/context.md` first. It will direct you to everything else.

**First session on a new project**: Start with `pre_analysis_plan.md`. If it is still in placeholder form, follow the decision-tree interview script in `Context/Agents/researcher_interview.md` to guide the user through completing it with minimal input. If the user uploads a PAP file, extract the content and populate the template. Only once the PAP readiness checklist (at the bottom of `pre_analysis_plan.md`) is fully ticked should you move on to `research_plan.md` — use the PAP plus the bridge questions in the interview script to fill in the research plan's additional sections (theoretical framework, detailed variable definitions, control variables, robustness strategy, etc.). After the research plan is drafted, check the Timeline checkbox in `Context/Flow/timeline.md` and set up the project phases.

**Before making a decision**: Check `Context/Flow/research_log.md` to see if it's already been decided.

**After making a decision**: Add an entry to `Context/Flow/research_log.md` (date, decision, rationale, action). If it changes the study design, also update `research_plan.md`.

**After completing a task**: Update `Context/Flow/timeline.md` — set Status to `Done`, fill in the Date Done, and add any relevant notes. Update the "Last updated" date at the top. If the completed work revealed new tasks, add them as new rows.

**After all analyses are complete, before writing**: You must complete the Results Review gate described in `research_plan.md`. Read all output, critically evaluate the empirical strategy in light of the actual results, make any necessary adjustments to scripts or the research plan, and log decisions. You must produce a `results_review.md` file in the project root documenting the review (see `research_plan.md` for the required contents). Do not begin writing until this review is done, `results_review.md` exists, and the timeline marks the phase as complete.

**After writing is complete, before submission**: Spawn a dedicated referee agent. It must read `Context/Roles/profile_referee.md`, adopt that persona, read the full manuscript and output, and write a critical referee report. Follow the instructions in the "Referee report" section of `research_plan.md`. Then begin a Revise & Resubmit session to address all comments — this may require changes to analysis, not just prose. See the "Revise and resubmit" section of `research_plan.md` for the full process.

**When you learn something non-obvious**: Add a dated entry to the "Notes for Future Agents" table at the bottom of `research_plan.md`. This includes data quirks, package behaviour, things that nearly went wrong, or context that isn't captured anywhere else. The goal is that a fresh agent reading this section can avoid repeating mistakes and get up to speed quickly.

**If conventions change**: Update `Context/context.md` and note the change in `Context/Flow/research_log.md`.

## Directory Structure

```
Template/
├── CLAUDE.md                        # Agent entry point
├── pre_analysis_plan.md             # Pre-registered commitments (PAP) — complete first
├── research_plan.md                 # Full study design, built from the PAP
├── README.md
├── Template.Rproj
│
├── Context/
│   ├── context.md                   # This file — index linking everything
│   ├── Agents/
│   │   ├── researcher_interview.md  # Decision-tree PAP elicitation script
│   │   ├── results_review_checklist.md # Item-by-item results review gate checklist
│   │   ├── subagent_protocol.md     # Subagent spawning, output, and handoff rules
│   │   └── revision_protocol.md     # Multi-cycle revision and re-analysis protocol
│   ├── Roles/
│   │   ├── researcher_profile.md    # Background, journal, writing style, R prefs
│   │   ├── profile_experimentalist.md  # Experiment-specific conventions
│   │   ├── profile_empiricist.md    # Observational-data conventions
│   │   └── profile_referee.md       # Simulated referee persona
│   ├── Tasks/
│   │   ├── graphs.md                # Graph style guidelines
│   │   └── tables.md                # Table style guidelines
│   └── Flow/
│       ├── timeline.md              # Project progress snapshot
│       ├── codebook.md              # Variable-level data documentation
│       └── research_log.md          # Chronological decision log
│
├── Scripts/
│   ├── 00_main.R                    # Master script — run this
│   ├── 00_packages.R                # Package loading
│   ├── 01_settings.R                # Palette, theme, output paths, save functions
│   ├── 02_cleaning.R                # Data loading and cleaning
│   ├── 03_variable_generation.R     # Derived/computed variables
│   ├── 04_sample_restrictions.R     # Exclusion criteria and subsetting
│   ├── 05_balance_table.R           # Randomisation balance checks
│   ├── 06_descriptives.R            # Summary statistics and key values
│   ├── 07_hypotheses.R              # Main hypothesis tests
│   ├── 08_robustness.R              # Regression robustness checks
│   └── 09_exploratory.R             # Exploratory analyses
│
├── Data/                            # Raw data files (+ any shipped codebook)
├── Output/
│   ├── Graphs/                      # .png files
│   ├── Tables/                      # .tex files
│   └── Text/                        # .txt files
└── LaTeX/
    ├── main.tex                     # Article document
    ├── abstract.tex
    ├── introduction.tex
    ├── theory.tex
    ├── experiment.tex
    ├── results.tex
    ├── discussion.tex
    ├── appendix.tex
    └── references.bib
```
