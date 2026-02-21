# Context

Read this file first. Study the relevant linked context files depending on your task.

## Researcher

See `Context/Roles/researcher_profile.md` for general background on the researcher and universal conventions (writing style, LaTeX, R coding, statistical reporting).

The researcher profile links to three **personality profiles** — one must be selected at project setup:

| Personality | Profile | Field | Target journal |
|---|---|---|---|
| **Experimentalist** | `Context/Roles/profile_experimentalist.md` | Experimental / behavioural economics | JEBO |
| **Empiricist** | `Context/Roles/profile_empiricist.md` | Empirical behavioural economics | JEBO |
| **Industrial Organisation** | `Context/Roles/profile_io.md` | Industrial organisation | RAND, JIE, IJIO, JEMS |

The selected personality determines the target journal, analysis methodology, primary evidence type, and script pipeline conventions. Check `research_plan.md` for which personality is active.

## Project Structure

This is a self-contained empirical analysis project. The entry point is `main.R` in the project root. Output is written to `Output/Graphs/`, `Output/Tables/`, and `Output/Text/` via the `save_graph()`, `save_table()`, and `save_text()` helper functions defined in `Scripts/config_toolkit.R`.

- Settings, palette, and theme: `Scripts/config_toolkit.R`
- Data preparation: `Scripts/config_cleaning.R` (uses a data-source adapter from `Helper/`) → variable generation → `Scripts/sample_restrictions.R`
- Data-source adapters: `Helper/otree.R` (oTree), `Helper/csv.R` (generic CSV)
- Analysis: `Scripts/balance_table.R` through `Scripts/exploratory.R`

## Decision Log

See `Context/Flow/research_log.md` for a chronological record of all design and analytical decisions with rationale.

## Analysis Conventions

- British English spelling throughout all output.
- Statistical methodology, test conventions, and standard-error choices are defined in the active researcher personality profile. See `Context/Roles/researcher_profile.md` and the linked personality file.

### Script separation: main pipeline vs. further analysis

The main analysis scripts (`balance_table.R` through `exploratory.R`) must contain **only analyses that are reported in the paper** — anything the reader will see in the main text or standard appendix tables. If a result is mentioned, cited, or displayed in the manuscript, the code that produces it lives in the main pipeline.

#### Robustness (`robustness.R`)

Robustness analyses exist to **confirm or challenge the primary findings**. Every analysis in this script must be directly tied to a hypothesis or result from `hypotheses.R`. The question robustness asks is: "Does the main result hold (or break) when we change the specification?" This includes:

- Alternative functional forms or control sets
- Different standard-error clustering
- Placebo and falsification tests
- Subsample stability (e.g. dropping outliers, trimming tails)
- Sensitivity to exclusion criteria

If an analysis does not speak to an existing finding, it does not belong in `robustness.R`. It goes in `exploratory.R` or `Further Analysis/`.

#### Exploratory (`exploratory.R`)

Exploratory analyses are **interesting research that goes beyond the hypotheses**. These are not tests of the primary results — they are new questions suggested by the data. They may appear in the main text or appendix, but they are clearly labelled as exploratory and are not pre-registered (for experimentalist projects) or part of the core empirical strategy (for empiricist/IO projects). This includes:

- Subgroup heterogeneity not implied by theory
- Mechanism or mediation analyses
- Learning effects, time dynamics, or additional outcome variables
- Patterns that emerge from the data and are worth documenting

If an exploratory analysis turns out to support or challenge a primary finding, consider moving it to `robustness.R` instead.

#### Further Analysis (`Scripts/Further Analysis/`)

Further Analysis is for work that **does not appear in the paper** but is nonetheless interesting to us as researchers. These are analyses we ran, found informative, but ultimately decided were not relevant for the manuscript. They belong in a separate supplementary appendix (`app_further.tex`) that is available upon request but not included in the main submission.

Each further analysis gets a brief write-up in `app_further.tex` explaining:
- What we looked at and why it seemed interesting on the face of it
- What we found
- Why it turned out not to be relevant for the paper

This includes:

- Extended robustness tests beyond the core set reported in the paper
- Sanity checks and diagnostic analyses that inform the researchers but are not cited
- Supplementary analyses that are "available upon request"
- Exploratory analyses that did not make the final manuscript

The Further Analysis folder is commented out in `main.R` by default and must be explicitly enabled. It uses the same save functions and naming conventions as the main pipeline, but its output is kept separate from paper-critical results.

**Rule of thumb**: if it is in the paper, it is in the main scripts. If it is just for us, it is in Further Analysis.

**Robustness vs. exploratory**: robustness tests the results we already have; exploratory investigates things we didn't hypothesise. Do not confuse the two.

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

## Research Basis Documents

Every project starts with a research basis document before moving to `research_plan.md`. Which document depends on the personality. **These documents do not exist in the project root until generated or uploaded** — templates are stored in `Context/Templates/`.

| Personality | Document | Template location | Purpose |
|---|---|---|---|
| **Experimentalist** | Pre-analysis plan | `Context/Templates/pre_analysis_plan.md` | Pre-registered commitments: hypotheses, DVs, conditions, analyses, exclusions, sample size |
| **Empiricist** | Research intention | `Context/Templates/research_intention.md` | Planned empirical strategy: research question, identification, data, specifications |
| **IO** | Research intention | `Context/Templates/research_intention.md` | Planned empirical strategy: research question, model/identification, data, specifications |

### Experimentalist flow
1. Check if the user has uploaded a PAP (from AsPredicted, OSF, or elsewhere).
2. Copy the template from `Context/Templates/pre_analysis_plan.md` to the project root as `pre_analysis_plan.md`.
3. If a PAP was uploaded, populate from it. If not, guide the user through creating one using `Context/Agents/researcher_interview.md`.
4. Once the PAP is complete, proceed to `research_plan.md`.

### Empiricist / IO flow
1. Ask the user if they have an existing document (grant proposal, working paper draft, planning document).
2. Copy the template from `Context/Templates/research_intention.md` to the project root as `research_intention.md`.
3. If a document was uploaded, extract into it. If not, guide the user through creating one using `Context/Agents/researcher_interview.md`.
4. Once the research intention is complete, proceed to `research_plan.md`.

## Research Plan

See `research_plan.md` for the full study design. It builds on the research basis document (`pre_analysis_plan.md` or `research_intention.md`), adding theoretical framework, detailed variable definitions, codebook references, timeline, and review gates.

## Agent Guidance

The `Context/Agents/` folder contains operational protocols for AI agents working on this project:

| File | Purpose |
|------|---------|
| `Context/Agents/researcher_interview.md` | Decision-tree questionnaire for eliciting a PAP or research intention from a user with no existing document |
| `Context/Agents/results_review_checklist.md` | Item-by-item checklist for the results review gate (replaces vague "stress-test" instruction) |
| `Context/Agents/subagent_protocol.md` | Rules for when/how to spawn subagents, output format, handoff, and context isolation |
| `Context/Agents/revision_protocol.md` | Multi-cycle revision protocol: when to re-run scripts, output versioning, cascade rules |

## Task-Specific Context

### Graphs
If you are making a graph, study `Context/Tasks/graphs.md`.

### Tables
If you are making a table, study `Context/Tasks/tables.md`.

### Writing
If you are writing paper text or LaTeX, study `Context/Roles/researcher_profile.md` and the active personality profile for journal conventions.

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

**First session on a new project**: Start by selecting the research personality. Then create the research basis document from the template in `Context/Templates/`:
- **Experimentalist**: Ask if the user has a PAP to upload. Copy `Context/Templates/pre_analysis_plan.md` to root as `pre_analysis_plan.md`. If a PAP was uploaded, populate from it. If not, guide the user through creating one. Once complete, proceed to `research_plan.md`.
- **Empiricist / IO**: Ask if the user has a research intention document (grant proposal, working paper, planning doc). Copy `Context/Templates/research_intention.md` to root as `research_intention.md`. If a document was uploaded, extract into it. If not, guide the user through creating one. Once complete, proceed to `research_plan.md` — use the intention plus the bridge questions in the interview script to fill in the additional sections.

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
├── research_plan.md                 # Full study design, built from PAP or research intention
├── README.md
├── Template.Rproj
│
├── Context/
│   ├── context.md                   # This file — index linking everything
│   ├── Templates/
│   │   ├── pre_analysis_plan.md     # Clean PAP template (experimentalist)
│   │   └── research_intention.md    # Clean research intention template (empiricist/IO)
│   ├── Agents/
│   │   ├── researcher_interview.md  # Decision-tree PAP / research intention elicitation script
│   │   ├── results_review_checklist.md # Item-by-item results review gate checklist
│   │   ├── subagent_protocol.md     # Subagent spawning, output, and handoff rules
│   │   └── revision_protocol.md     # Multi-cycle revision and re-analysis protocol
│   ├── Roles/
│   │   ├── researcher_profile.md    # General: background, writing style, LaTeX, R prefs
│   │   ├── profile_experimentalist.md  # Experimental economics — targets JEBO
│   │   ├── profile_empiricist.md    # Observational behavioural economics — targets JEBO
│   │   ├── profile_io.md            # Industrial organisation — targets RAND, JIE, IJIO, JEMS
│   │   ├── profile_referee.md       # Simulated referee persona (orchestration)
│   │   ├── profile_referee_cycle1.md  # Referee Cycle 1: Theory & Framework
│   │   └── profile_referee_cycle2.md  # Referee Cycle 2: Results & Integration
│   ├── Tasks/
│   │   ├── graphs.md                # Graph style guidelines
│   │   └── tables.md                # Table style guidelines
│   └── Flow/
│       ├── timeline.md              # Project progress snapshot
│       ├── codebook.md              # Variable-level data documentation
│       └── research_log.md          # Chronological decision log
│
├── Helper/
│   ├── otree.R                      # oTree adapter: config + load_data()
│   ├── csv.R                        # Generic CSV adapter: config + load_data()
│   └── config_sync_to_folder.R      # Copy Output/ to external destinations
│
├── Scripts/
│   ├── config_init.R                # Clear env, set wd, define paths
│   ├── config_toolkit.R             # Packages, palette, theme, save functions, helpers
│   ├── config_cleaning.R            # Orchestrator: adapter selection + variable generation
│   ├── sample_restrictions.R        # Exclusion criteria and subsetting
│   ├── balance_table.R              # Balance checks / summary statistics
│   ├── descriptives.R               # Summary statistics and key values
│   ├── hypotheses.R                 # Main hypothesis tests / primary regressions
│   ├── robustness.R                 # Robustness checks
│   ├── exploratory.R                # Exploratory analyses / counterfactuals
│   └── Further Analysis/
│       └── further_analysis.R       # Beyond-paper robustness, diagnostics, researcher-only checks
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
    ├── experiment.tex               # Rename for IO: data.tex or institutional_background.tex
    ├── results.tex
    ├── discussion.tex
    ├── app_further.tex              # Further analyses appendix (available upon request)
    ├── appendix.tex
    └── references.bib
```
