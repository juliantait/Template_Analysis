# Empirical Analysis Template

A self-contained template for single-study empirical analysis papers in behavioural economics, designed to be operated by [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Target journal: Journal of Economic Behavior & Organization (JEBO).

## What this is

This template provides the full infrastructure for taking a study from pre-registration through to a submission-ready manuscript. It includes R scripts for the analysis pipeline, LaTeX files for the paper, and a set of structured context documents that guide Claude through every phase of the project. Claude reads these documents to understand what to do, in what order, and to what standard.

You do not need to manage the workflow yourself. Open Claude Code in this directory and tell it what stage you are at. It will read the context files, check the project timeline, and pick up where things left off.

## Quick start

1. **Clone or copy this template** into a new project directory.
2. **Open Claude Code** in the project root (the folder containing `CLAUDE.md`).
3. **Tell Claude what you are working on.** If you are starting from scratch, say so. If you have an existing pre-analysis plan (from AsPredicted, OSF, or a PDF), upload it or paste it in.

Claude will read `CLAUDE.md`, which points it to `Context/context.md` and `Context/Flow/timeline.md`. From there, it knows the full project structure, the current status, and what to do next.

## How it works

### Phase 1: Pre-analysis plan

The first document Claude completes is `pre_analysis_plan.md`. This captures your pre-registered commitments: hypotheses, dependent variables, conditions, analyses, exclusion rules, and sample size.

- **If you have an existing PAP** (AsPredicted, OSF, PDF): Claude extracts the content and populates the template. It flags any gaps and asks targeted follow-up questions.
- **If you have no PAP**: Claude runs a structured interview (defined in `Context/Agents/researcher_interview.md`) to walk you through each section. The interview is collaborative, not interrogative — Claude asks the right questions in the right order to build a complete plan with minimal effort on your part.

The PAP has a readiness checklist at the bottom. Claude will not move on until every item is ticked.

### Phase 2: Research plan

Once the PAP is complete, Claude expands it into `research_plan.md` — the full study design. This adds the theoretical framework, detailed variable definitions, control variable justifications, robustness strategy, power calculation details, and the analysis pipeline structure. The research plan is the living document that tracks the current state of the study design throughout the project.

### Phase 3: Data preparation and analysis

Claude writes and runs R scripts in numbered order from `Scripts/00_main.R`:

| Script | Purpose |
|--------|---------|
| `00_main.R` | Master script — run this to execute the full pipeline |
| `00_packages.R` | Package loading |
| `01_settings.R` | Colour palette, ggplot theme, output paths, save functions |
| `02_cleaning.R` | Data loading and cleaning |
| `03_variable_generation.R` | Derived and computed variables |
| `04_sample_restrictions.R` | Exclusion criteria and subsetting |
| `05_balance_table.R` | Randomisation balance checks |
| `06_descriptives.R` | Summary statistics and key values |
| `07_hypotheses.R` | Main pre-registered hypothesis tests |
| `08_robustness.R` | Regression robustness checks |
| `09_exploratory.R` | Exploratory analyses |

Scripts 02-04 run sequentially (each depends on the previous). Scripts 05-09 can run in parallel where dependencies allow. Claude manages this automatically.

All output goes to `Output/Graphs/` (.png), `Output/Tables/` (.tex), and `Output/Text/` (.txt) via helper functions in `01_settings.R`. Files follow a consistent naming convention: `{script}_{analysis}_{descriptor}.{ext}`.

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

- **Cycle 1** reviews theory, framing, and hypothesis consistency against the PAP.
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

## Two analysis profiles

The template supports two types of studies, each with its own analysis conventions:

| Profile | File | Primary evidence | Robustness | When to use |
|---------|------|-----------------|------------|-------------|
| **Experimentalist** | `Context/Roles/profile_experimentalist.md` | Non-parametric tests (Wilcoxon, permutation) | OLS/logit regressions with controls | Lab, online, or field experiments with randomised treatment |
| **Empiricist** | `Context/Roles/profile_empiricist.md` | Regression-based methods (OLS, IV, DiD, RDD) | Alternative specifications, placebo tests | Observational, survey, or administrative data |

Set the profile in the research plan before analysis begins. Claude applies the corresponding conventions throughout.

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

## Project tracking

Two files track project state:

- **`Context/Flow/timeline.md`** — a phase-by-phase progress table with statuses (Pending / In progress / Done / Blocked), dependencies, and dates. Claude updates this after completing each task.
- **`Context/Flow/research_log.md`** — a chronological record of all design and analytical decisions with rationale. Every judgement call is logged here.

A third file, `Context/Flow/codebook.md`, documents every variable in the dataset: raw variables, generated variables, recoding decisions, and exclusion criteria. This is populated during data preparation.

## Directory structure

```
Template/
├── CLAUDE.md                        # Agent entry point
├── pre_analysis_plan.md             # Pre-registered commitments (complete first)
├── research_plan.md                 # Full study design (built from the PAP)
├── README.md
├── Template.Rproj
│
├── Context/
│   ├── context.md                   # Master index linking all context files
│   ├── Agents/
│   │   ├── researcher_interview.md  # Decision-tree PAP elicitation script
│   │   ├── results_review_checklist.md  # 50+ item results review gate
│   │   ├── subagent_protocol.md     # Agent spawning, output, and handoff rules
│   │   └── revision_protocol.md     # Multi-cycle revision and re-analysis protocol
│   ├── Roles/
│   │   ├── researcher_profile.md    # Background, journal, writing style, R prefs
│   │   ├── profile_experimentalist.md  # Experiment-specific conventions
│   │   ├── profile_empiricist.md    # Observational-data conventions
│   │   └── profile_referee.md       # Simulated referee persona (two-cycle system)
│   ├── Tasks/
│   │   ├── graphs.md                # JEBO graph style guidelines
│   │   └── tables.md                # JEBO table style guidelines
│   └── Flow/
│       ├── timeline.md              # Project progress tracker
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

## Output paths

The save functions in `01_settings.R` write to every path in the `output_paths` vector. To send output to multiple locations (e.g., local + Overleaf), add paths:

```r
output_paths <- c(
  file.path(getwd(), "Output"),
  "/path/to/Overleaf/project/Output"
)
```

## Requirements

- **Claude Code** (Anthropic CLI) — this template is designed to be operated through Claude Code.
- **R** with tidyverse, ggplot2, and any packages required by your analysis (loaded in `Scripts/00_packages.R`).
- **RStudio** (optional but recommended for interactive use via `Template.Rproj`).
- **LaTeX** distribution with pdflatex + bibtex for compiling the paper.
