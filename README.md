# Empirical Analysis Template

A self-contained template for single-study empirical analysis papers in economics, designed to be operated by [Claude Code](https://docs.anthropic.com/en/docs/claude-code). It is field-agnostic — the researcher profile and field-specific conventions are set per project.

## What this is

This template provides the full infrastructure for taking a study from pre-registration through to a submission-ready manuscript. It includes R scripts for the analysis pipeline, LaTeX files for the paper, and a set of structured context documents that guide Claude through every phase of the project. Claude reads these documents to understand what to do, in what order, and to what standard.

You do not need to manage the workflow yourself. Open Claude Code in this directory and tell it what stage you are at. It will read the context files, check the project timeline, and pick up where things left off.

## Quick start

1. **Clone or copy this template** into a new project directory.
2. **Open Claude Code** in the project root (the folder containing `CLAUDE.md`).
3. **Tell Claude what you are working on.** If you are starting from scratch, say so. If you have an existing pre-analysis plan (from AsPredicted, OSF, or a PDF), upload it or paste it in.

Claude will read `CLAUDE.md`, which points it to `Context/Flow/timeline.md` and the rest of the project structure. From there, it knows the current status and what to do next.

## How it works

### Phase 1: Research basis document

The first step is selecting a research personality (experimentalist, empiricist, or IO). Claude then creates the appropriate research basis document from a template stored in `Context/Templates/`:

- **Experimentalist** → `pre_analysis_plan.md` — pre-registered commitments (hypotheses, DVs, conditions, analyses, exclusion rules, sample size).
- **Empiricist / IO** → `research_intention.md` — planned empirical strategy (research question, identification, data, specifications).

These files do not exist in the project root until a project begins. Claude copies the template and either populates it from an uploaded document (AsPredicted, OSF, grant proposal, working paper) or guides you through creating one via a structured interview (`Context/Agents/researcher_interview.md`).

The document has a readiness checklist at the bottom. Claude will not move on until every item is ticked.

### Phase 2: Research plan

Once the research basis document is complete, Claude expands it into `research_plan.md` — the full study design. This adds the theoretical framework, detailed variable definitions, control variable justifications, robustness strategy, power calculation details, and the analysis pipeline structure. The research plan is the living document that tracks the current state of the study design throughout the project.

### Phase 3: Data preparation and analysis

Claude writes and runs R scripts from `main.R` in the project root:

| Script | Purpose |
|--------|---------|
| `main.R` | Entry point — run this to execute the full pipeline |
| `Scripts/config_init.R` | Clear environment, set working directory, define output paths and sync destinations |
| `Scripts/config_toolkit.R` | Packages, colour palette, ggplot theme, save functions, checkpoint, helpers |
| `Scripts/config_cleaning.R` | Orchestrator: selects data-source adapter, variable generation, saves cleaned data |
| `Helper/otree.R` | oTree adapter: config + `load_data()` (wide → long reshape) |
| `Helper/csv.R` | Generic CSV adapter: config + `load_data()` (already long format) |
| `Scripts/sample_restrictions.R` | Exclusion criteria and subsetting |
| `Scripts/balance_table.R` | Randomisation balance checks |
| `Scripts/descriptives.R` | Summary statistics and key values |
| `Scripts/hypotheses.R` | Main pre-registered hypothesis tests |
| `Scripts/robustness.R` | Regression robustness checks |
| `Scripts/exploratory.R` | Exploratory analyses |
| `Scripts/Further Analysis/` | Additional analyses beyond the core pipeline |
| `Helper/config_sync_to_folder.R` | Copy Output/ to external destinations (e.g. Overleaf) |

Cleaning runs once to produce `Data/data_cleaned.RData`. Normal analysis loads the pre-cleaned data and runs the analysis scripts sequentially. Claude manages this automatically.

All output goes to `Output/Graphs/` (.png), `Output/Tables/` (.tex), and `Output/Text/` (.txt) via helper functions in `Scripts/config_toolkit.R`. Files follow a consistent naming convention: `{script}_{analysis}_{descriptor}.{ext}`.

### Phase 4: Results review (quality gate)

Before any writing begins, Claude must complete a formal results review using a 50+ item checklist (`Context/Agents/results_review_checklist.md`). This covers:

- Balance and randomisation integrity
- Descriptive coherence (plausible ranges, no floor/ceiling effects)
- Hypothesis verdicts (every pre-registered hypothesis mapped to a test result)
- Robustness (do results survive alternative specifications?)
- Cross-analysis coherence (do descriptives, tests, and regressions agree?)
- Technical quality (correct clustering, multiple-testing corrections)
- Red flags (implausible effect sizes, suspicious p-value clustering)

The review produces `results_review.md` with a Green/Amber/Red verdict. Writing cannot begin until this exists and the verdict is at least Amber.

### Phase 5: Paper drafting

Claude writes the paper in LaTeX, section by section, into the `LaTeX/` folder. Independent sections (Introduction, Theory, Methods) can be drafted in parallel. Results and Discussion are written sequentially after the results review is complete. The Abstract is written last.

All writing follows JEBO conventions defined in `Context/Roles/researcher_profile.md`: British English, concise academic prose, exact p-values with no leading zero, no test statistics in running text, booktabs tables, greyscale-robust figures.

### Phase 6: Simulated referee report (quality gate)

Once the manuscript is complete, Claude spawns two independent referee agents with clean context windows (no memory of the writing process). These agents adopt the persona defined in `Context/Roles/profile_referee.md` — a sceptical senior researcher who evaluates against JEBO standards.

- **Cycle 1** reviews theory, framing, and hypothesis consistency against the research basis document.
- **Cycle 2** reviews results, technical execution, and whether the paper delivers on its promises.

Their reports are merged into a single referee report saved as `referee_report.md`.

### Phase 7: Revise and resubmit

Claude addresses every referee comment through a structured revision protocol (`Context/Agents/revision_protocol.md`). This includes:

- Triaging comments (agree / partially agree / disagree)
- Identifying which scripts need re-running and managing the cascade (e.g., changing a variable definition in script 03 triggers re-runs of scripts 04-09)
- Backing up outputs before re-running (`Output_v1/`, `Output_v2/`, etc.)
- Repeating the results review if the analysis changed
- Rewriting affected paper sections
- Producing a point-by-point response document

After each revision, a fresh referee agent reviews the updated manuscript. The cycle repeats until the referee recommends minor revision or accept. All reports are numbered and immutable — nothing is overwritten.

## Research personalities

The template supports three research personalities, each with its own analysis conventions and target journals:

| Personality | File | Primary evidence | Target journal | When to use |
|-------------|------|-----------------|----------------|-------------|
| **Experimentalist** | `Context/Roles/profile_experimentalist.md` | Non-parametric tests (Wilcoxon, permutation) | JEBO | Lab, online, or field experiments with randomised treatment |
| **Empiricist** | `Context/Roles/profile_empiricist.md` | Regression-based methods (OLS, IV, DiD, RDD) | JEBO | Observational, survey, or administrative data |
| **Industrial Organisation** | `Context/Roles/profile_io.md` | Structural estimation, reduced-form regressions | RAND, JIE, IJIO, JEMS | IO markets, competition, firm behaviour |

Set the personality in the research plan before analysis begins. Claude applies the corresponding conventions throughout.

## Agent system

Claude uses specialised subagents to parallelise work and maintain fresh perspectives where needed. The full protocol is in `Context/Agents/subagent_protocol.md`. Five agent types are defined:

| Agent | Purpose |
|-------|---------|
| **Explorer** | Reads and summarises context, data, or output files |
| **Analyst** | Writes and runs R scripts, generates output |
| **Drafter** | Writes LaTeX sections and markdown documents |
| **Reviewer** | Produces critical assessments (results review, referee reports) |
| **Researcher** | Interviews the user to elicit study design information |

Reviewer agents are always spawned with clean context windows — they never see the writing process. This ensures genuinely independent evaluation.

## Feedback

The `Feedback/` folder stores all external feedback: referee reports, seminar comments, committee feedback, and other external input. Files follow a naming convention with a prefix indicating the source type:

- **`referee_report_`** — formal journal referee reports (e.g., `referee_report_jebo_r1.md`)
- **`comments_`** — everything else: seminars, conferences, committee members, co-authors (e.g., `comments_esa_2026.md`, `comments_committee_smith.md`)

Files are immutable — new rounds of feedback get new files. These feed into the revision protocol when addressing comments.

## Project tracking

Two files track project state:

- **`Context/Flow/timeline.md`** — a phase-by-phase progress table with statuses (Pending / In progress / Done / Blocked), dependencies, and dates. Claude updates this after completing each task.
- **`Context/Flow/research_log.md`** — a chronological record of all design and analytical decisions with rationale. Every judgement call is logged here.

A third file, `Context/Flow/codebook.md`, documents every variable in the dataset: raw variables, generated variables, recoding decisions, and exclusion criteria. This is populated during data preparation.

## Directory structure

```
Template/
├── CLAUDE.md                        # Agent entry point
├── research_plan.md                 # Full study design (built from PAP or research intention)
├── README.md
├── Template.Rproj
│
├── Context/
│   ├── Templates/
│   │   ├── pre_analysis_plan.md     # Clean PAP template (experimentalist)
│   │   └── research_intention.md    # Clean research intention template (empiricist/IO)
│   ├── Agents/
│   │   ├── researcher_interview.md  # Decision-tree PAP / research intention elicitation script
│   │   ├── results_review_checklist.md  # 50+ item results review gate
│   │   ├── subagent_protocol.md     # Agent spawning, output, and handoff rules
│   │   └── revision_protocol.md     # Multi-cycle revision and re-analysis protocol
│   ├── Roles/
│   │   ├── researcher_profile.md    # Background, journal, writing style, R prefs
│   │   ├── profile_experimentalist.md  # Experiment-specific conventions
│   │   ├── profile_empiricist.md    # Observational-data conventions
│   │   ├── profile_io.md            # Industrial organisation conventions
│   │   ├── profile_referee.md       # Simulated referee persona (orchestration)
│   │   ├── profile_referee_cycle1.md  # Referee Cycle 1: Theory & Framework
│   │   └── profile_referee_cycle2.md  # Referee Cycle 2: Results & Integration
│   ├── Tasks/
│   │   ├── graphs.md                # Graph style guidelines
│   │   └── tables.md                # Table style guidelines
│   └── Flow/
│       ├── timeline.md              # Project progress tracker
│       ├── codebook.md              # Variable-level data documentation
│       └── research_log.md          # Chronological decision log
│
├── main.R                              # Entry point — run this
│
├── Scripts/
│   ├── config_init.R                   # Clear env, set wd, define paths
│   ├── config_toolkit.R                # Packages, palette, theme, save functions, helpers
│   ├── config_cleaning.R              # Orchestrator: adapter selection + variable generation
│   ├── sample_restrictions.R           # Exclusion criteria and subsetting
│   ├── balance_table.R                 # Randomisation balance checks
│   ├── descriptives.R                 # Summary statistics and key values
│   ├── hypotheses.R                   # Main hypothesis tests
│   ├── robustness.R                   # Regression robustness checks
│   ├── exploratory.R                  # Exploratory analyses
│   └── Further Analysis/
│       └── further_analysis.R          # Additional analyses beyond core pipeline
│
├── Helper/
│   ├── otree.R                         # oTree adapter: config + load_data()
│   ├── csv.R                           # Generic CSV adapter: config + load_data()
│   └── config_sync_to_folder.R         # Copy Output/ to external destinations
│
├── Feedback/                           # Referee reports, committee comments, external feedback
│   └── .gitkeep
├── Data/
│   ├── DataSets/                       # Raw data storage
│   │   └── .gitkeep
│   ├── [data_cleaned.RData]            # Output of cleaning pipeline
│   └── [checkpoint_prepared.RData]     # Checkpoint after sample restrictions
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

## Output paths

The save functions in `Scripts/config_toolkit.R` write to all paths in the `output_paths` vector. Sync destinations are configured in `Scripts/config_init.R` and applied automatically by `Helper/config_sync_to_folder.R` at the end of each run. To send output to multiple locations (e.g., local + Overleaf), add paths to `SYNC_DESTINATIONS`:

```r
# In Scripts/config_init.R:
SYNC_DESTINATIONS <- c(
  path.expand("/path/to/Overleaf/project/Output")
)
```

## Requirements

- **Claude Code** (Anthropic CLI) — this template is designed to be operated through Claude Code.
- **R** with tidyverse, ggplot2, and any packages required by your analysis (loaded in `Scripts/config_toolkit.R`).
- **RStudio** (optional but recommended for interactive use via `Template.Rproj`).
- **LaTeX** distribution with pdflatex + bibtex for compiling the paper.
