# CLAUDE.md

This is a self-contained template for a single-study empirical analysis paper in economics. Run the analysis from `main.R` in the project root; output goes to `Output/`.

Check `Context/Flow/timeline.md` for the current project status — it shows which phases are done, in progress, or pending.

**Check `Context/Flow/todo.md` for active tasks.** If there are pending tasks, do them. The to-do is the AI's operational work queue — it contains specific, actionable items populated by the researcher. Each part should be completed in a single agent session, with a report written to `Context/Flow/todo_report_<part_label>.md` when done.

## Starting a New Project

The first step is to **select a research personality** from `Context/Roles/researcher_profile.md`:

| Personality                 | Profile                                    | Field                                | Target journal         |
| --------------------------- | ------------------------------------------ | ------------------------------------ | ---------------------- |
| **Experimentalist**         | `Context/Roles/profile_experimentalist.md` | Experimental / behavioural economics | JEBO                   |
| **Empiricist**              | `Context/Roles/profile_empiricist.md`      | Empirical behavioural economics      | JEBO                   |
| **Industrial Organisation** | `Context/Roles/profile_io.md`              | Industrial organisation              | RAND, JIE, IJIO, JEMS |

The selected personality determines the target journal, analysis methodology, primary evidence type, and script pipeline conventions. Check `research_plan.md` for which personality is active.

Once the personality is set, create the **research basis document** before moving to the research plan. Templates are stored in `Context/Templates/` — they do not exist in the project root until generated or uploaded.

### Experimentalist path

1. Check if the user has a PAP to upload (from AsPredicted, OSF, or similar).
2. **If a PAP exists**: copy the template from `Context/Templates/pre_analysis_plan.md` to the project root as `pre_analysis_plan.md`, then populate it from the uploaded document. Use it as the basis for `research_plan.md`.
3. **If no PAP exists**: copy the template to root and guide the user through creating one using `Context/Roles/researcher_interview.md`. The PAP must be completed before the research plan.

### Empiricist / IO path

1. Ask the user if they have an existing research intention document — a grant proposal, working paper draft, internal planning document, or anything describing the research question, data, and approach.
2. **If a document exists**: copy the template from `Context/Templates/research_intention.md` to the project root as `research_intention.md`, then populate it from the uploaded document. Use it as the basis for `research_plan.md`.
3. **If no document exists**: copy the template to root and guide the user through creating one using `Context/Roles/researcher_interview.md`. The research intention must be completed before the research plan.

### Templates

| Template                                  | For personality | Purpose                                                                                    |
| ----------------------------------------- | --------------- | ------------------------------------------------------------------------------------------ |
| `Context/Templates/pre_analysis_plan.md`  | Experimentalist | Pre-registered commitments: hypotheses, DVs, conditions, analyses, exclusions, sample size |
| `Context/Templates/research_intention.md` | Empiricist / IO | Planned empirical strategy: research question, identification, data, specifications        |

## Researcher

See `Context/Roles/researcher_profile.md` for general background on the researcher and universal conventions (writing style, LaTeX, R coding, statistical reporting). The researcher profile links to the three personality profiles above.

## Project Structure

This is a self-contained empirical analysis project. The entry point is `main.R` in the project root. Output is written to `Output/Graphs/`, `Output/Tables/`, and `Output/Text/` via the `save_graph()`, `save_table()`, and `save_text()` helper functions defined in `Scripts/config_toolkit.R`.

- Settings, palette, and theme: `Scripts/config_toolkit.R`
- Data preparation: `Scripts/config_cleaning.R` (uses a data-source adapter from `Helper/`) → variable generation → `Scripts/sample_restrictions.R`
- Data-source adapters: `Helper/otree.R` (oTree), `Helper/csv.R` (generic CSV)
- Analysis: `Scripts/balance_table.R` through `Scripts/exploratory.R`

## Draft Snapshots

At the end of every to-do part or agent session that changes LaTeX content, copy `LaTeX/main.pdf` to the project root as a numbered draft snapshot.

**Naming convention:**

```
{paper_title}_DRAFT_{N}.pdf
```

The paper title is taken from the `\title{}` field in `LaTeX/main.tex`, converted to lowercase with underscores (no spaces, no special characters). `N` is a simple incrementing integer starting at 1.

**Examples:**

```
hiding_in_plain_sight_DRAFT_1.pdf
hiding_in_plain_sight_DRAFT_2.pdf
hiding_in_plain_sight_DRAFT_3.pdf
```

**Procedure:**

1. Read the `\title{}` from `LaTeX/main.tex` and convert it to a filename-safe slug (lowercase, underscores, strip punctuation).
2. Check the project root for existing `*_DRAFT_*.pdf` files.
3. Find the highest draft number. If none exist, the next number is `1`.
4. Copy `LaTeX/main.pdf` to `{paper_title}_DRAFT_{N}.pdf` in the project root.
5. Add a sticky note annotation to the draft PDF (see **Sticky Note** below).
6. Log the snapshot in `Context/Flow/research_log.md` alongside the other changes from that session.

Draft snapshots are **immutable** — never overwrite or delete a previous draft. If `LaTeX/main.pdf` does not exist yet (e.g. pre-writing phases), skip the snapshot.

### Sticky Note

Every draft snapshot in the project root **must** have a sticky note annotation added to the first page summarising the changes implemented in that session. This gives the researcher an at-a-glance record of what changed in each draft without opening the log.

**Content:** A concise, bulleted list of the changes made in the session that triggered the snapshot. Write in plain language — no file paths or technical detail. Focus on what changed from the reader's perspective (e.g. "Rewrote introduction framing around identification strategy", "Added robustness table for alternative clustering", "Fixed typo in Proposition 2 proof").

**Implementation:** Use Python with the `pymupdf` (fitz) library to add a sticky note (text annotation) to page 1 of the draft PDF:

```python
import fitz  # pymupdf

doc = fitz.open("path/to/draft.pdf")
page = doc[0]
page.add_text_annot(
    fitz.Point(72, 72),  # top-left area of first page
    "Draft N — YYYY-MM-DD\n\nChanges:\n- First change\n- Second change\n- Third change",
    icon="Note"
)
doc.save("path/to/draft.pdf", incremental=True, encryption=fitz.PDF_ENCRYPT_KEEP)
doc.close()
```

**Rules:**
- The note title line is `Draft N — YYYY-MM-DD` (matching the draft number and today's date).
- Keep the change list short — aim for 3–7 bullet points. Group small related changes into a single bullet.
- The sticky note is added to the **root draft snapshot only** (`{paper_title}_DRAFT_{N}.pdf`), not to `LaTeX/main.pdf`.
- If `pymupdf` is not available, install it (`pip install pymupdf`) before proceeding.

## Decision Log

See `Context/Flow/research_log.md` for a chronological record of all design and analytical decisions with rationale.

## To-Do

See `Context/Flow/todo.md` for the agent's active task queue. The to-do is separate from the timeline: the timeline tracks *where the project is*; the to-do tracks *what the agent should do right now*.

The researcher populates the to-do with specific, actionable work items grouped into numbered parts. Multiple to-do batches can occur within a single timeline phase. When an agent starts a session and finds pending tasks, it should:

1. Find the next pending part (first part not marked `DONE`).
2. Implement each task, ticking off items as they are completed.
3. When a part is finished, mark it `DONE` and write a completion report to `Context/Flow/todo_report_<part_label>.md` listing every file changed, what was changed, and any judgement calls.
4. Log all changes in `Context/Flow/research_log.md`.
5. If `LaTeX/main.pdf` exists, take a draft snapshot (see **Draft Snapshots** above).

When all parts are done, the researcher resets the file for the next batch.

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
| `balance_demographics.tex`                            | balance_table        | —               | demographics            |
| `descriptives_values.txt`                             | descriptives         | —               | values                  |
| `hypotheses_h1_hiding_by_stakes.png`                  | hypotheses           | h1              | hiding_by_stakes        |
| `robustness_regression_treatment_with_controls.tex`   | robustness           | regression      | treatment_with_controls |
| `exploratory_learning_mistake_hiding_rates.png`       | exploratory          | learning        | mistake_hiding_rates    |
| `exploratory_manager_types_mean_outcomes_matched.tex` | exploratory          | manager_types   | mean_outcomes_matched   |

### Rules
- If a script has only one output, the `{analysis}` part can be omitted (e.g. `balance_demographics.tex`).
- The `{descriptor}` should be readable enough that you can identify the content from the filename alone.
- Use the same naming in the `save_graph()`, `save_table()`, and `save_text()` calls — the function appends the file extension automatically.

## Codebook

See `Context/Flow/codebook.md` for variable-level documentation of the dataset: raw variables, generated variables, recoding decisions, and exclusions. Populated as needed during data preparation.

## Feedback

The `Feedback/` folder stores all external feedback received during the project: referee reports from journal submissions, comments from seminar or conference presentations, thesis committee feedback, and any other external input.

### Naming convention

Files use a descriptive prefix indicating the source type, followed by the origin and an optional descriptor. All lowercase with underscores.

```
{source_type}_{origin}_{descriptor}.md
```

| Component | Description | Examples |
|---|---|---|
| `{source_type}` | The kind of feedback | `referee_report`, `comments` |
| `{origin}` | Who provided it or where it came from | `jebo_r1`, `jebo_r2`, `esa_2026`, `committee_smith`, `seminar_lse` |
| `{descriptor}` | Optional further detail | `major_revision`, `poster_session` |

### Examples

| File | Source |
|---|---|
| `referee_report_jebo_r1.md` | First referee, JEBO R&R round 1 |
| `referee_report_jebo_r2.md` | Second referee, JEBO R&R round 1 |
| `referee_report_jebo_r1_round2.md` | First referee, JEBO R&R round 2 |
| `comments_esa_2026.md` | Comments received at ESA 2026 conference |
| `comments_committee_smith.md` | Thesis committee feedback from Smith |
| `comments_seminar_lse.md` | Feedback from LSE seminar presentation |
| `comments_coauthor_jones.md` | Written comments from a co-author |

### Rules

- Use `referee_report_` for formal journal referee reports.
- Use `comments_` for everything else: seminars, conferences, committee members, co-authors, informal reviews.
- Files are **immutable** — never edit a feedback file after it is saved. If a new round of feedback arrives, create a new file.
- Feedback files are inputs to the revision protocol (`Context/Roles/revision_protocol.md`). When starting a revision cycle, read all files in `Feedback/` to identify the full set of comments to address.

## Research Plan

See `research_plan.md` for the full study design. It builds on the research basis document (`pre_analysis_plan.md` or `research_intention.md`), adding theoretical framework, detailed variable definitions, codebook references, timeline, and review gates.

## Task-Specific Context

### Graphs
If you are making a graph, study `Context/Roles/skill_graphs.md`.

### Tables
If you are making a table, study `Context/Roles/skill_tables.md`.

### Writing
If you are writing paper text or LaTeX, study `Context/Roles/researcher_profile.md` and the active personality profile for journal conventions.

### Referee Report
If you are acting as a referee, study `Context/Roles/profile_referee.md` for the persona and report structure.

## What Goes Where

### Design decisions (variable choices, test selection, exclusion rules, coding schemes)
- **Finalised version** goes into `research_plan.md` — this is what someone reads to understand the current design.
- **Rationale and history** goes into `Context/Flow/research_log.md` — this is what someone reads to understand *why* the design looks the way it does, and what alternatives were considered or rejected.

### Project-wide conventions (coding style, output naming, statistical defaults)
- Goes into this file (`CLAUDE.md`). These are rules that apply across all scripts and don't change between analyses.

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

**Starting a new session**: Read this file first. It links to everything else. Then check `Context/Flow/todo.md` — if there are pending tasks, work through them before doing anything else.

**First session on a new project**: Start by selecting the research personality. Then create the research basis document from the template in `Context/Templates/`:
- **Experimentalist**: Ask if the user has a PAP to upload. Copy `Context/Templates/pre_analysis_plan.md` to root as `pre_analysis_plan.md`. If a PAP was uploaded, populate from it. If not, guide the user through creating one. Once complete, proceed to `research_plan.md`.
- **Empiricist / IO**: Ask if the user has a research intention document (grant proposal, working paper, planning doc). Copy `Context/Templates/research_intention.md` to root as `research_intention.md`. If a document was uploaded, extract into it. If not, guide the user through creating one. Once complete, proceed to `research_plan.md` — use the intention plus the bridge questions in the interview script to fill in the additional sections.

**Before making a decision**: Check `Context/Flow/research_log.md` to see if it's already been decided.

**After making a decision**: Add an entry to `Context/Flow/research_log.md` (date, decision, rationale, action). If it changes the study design, also update `research_plan.md`.

**After completing a task**: Update `Context/Flow/timeline.md` — set Status to `Done`, fill in the Date Done, and add any relevant notes. Update the "Last updated" date at the top. If the completed work revealed new tasks, add them as new rows. If the task changed LaTeX content, take a draft snapshot (see **Draft Snapshots**).

**After all analyses are complete, before writing**: You must complete the Results Review gate described in `research_plan.md`. Read all output, critically evaluate the empirical strategy in light of the actual results, make any necessary adjustments to scripts or the research plan, and log decisions. You must produce a `results_review.md` file in the project root documenting the review (see `research_plan.md` for the required contents). Do not begin writing until this review is done, `results_review.md` exists, and the timeline marks the phase as complete.

**After writing is complete, before submission**: Spawn a dedicated referee agent. It must read `Context/Roles/profile_referee.md`, adopt that persona, read the full manuscript and output, and write a critical referee report. Follow the instructions in the "Referee report" section of `research_plan.md`. Then begin a Revise & Resubmit session to address all comments — this may require changes to analysis, not just prose. See the "Revise and resubmit" section of `research_plan.md` for the full process.

**When you learn something non-obvious**: Add a dated entry to the "Notes for Future Agents" table at the bottom of `research_plan.md`. This includes data quirks, package behaviour, things that nearly went wrong, or context that isn't captured anywhere else. The goal is that a fresh agent reading this section can avoid repeating mistakes and get up to speed quickly.

**If conventions change**: Update this file and note the change in `Context/Flow/research_log.md`.

## Agent Strategy

Spare no expense. Spawn as many subagents as necessary to parallelise independent tasks and preserve context in the main conversation. See `Context/Roles/subagent_protocol.md` for the full protocol on when to spawn, output format, handoff rules, and context isolation.

Use agents liberally for:

- Exploring the codebase or context files
- Running independent analyses or searches in parallel
- Drafting separate sections, scripts, or outputs concurrently
- Any work that would bloat the main context window if done inline

Keep the main thread lean. Delegate freely.

## Agent Resources

| Resource                    | Location                                      | When to use                                                                      |
| --------------------------- | --------------------------------------------- | -------------------------------------------------------------------------------- |
| Researcher interview script | `Context/Roles/researcher_interview.md`       | When eliciting a PAP or research intention from a user with no existing document |
| Results review checklist    | `Context/Roles/results_review_checklist.md`   | At the results review gate, before writing begins                                |
| Subagent protocol           | `Context/Roles/subagent_protocol.md`          | Before spawning any subagent                                                     |
| Revision protocol           | `Context/Roles/revision_protocol.md`          | When a referee report triggers re-analysis                                       |

## Change Log Enforcement

Every agent **must** update `Context/Flow/research_log.md` after any change — code, LaTeX, data, or documentation. This is a blocking requirement, not a suggestion. No change is complete until it is logged.

Use the emoji-prefixed entry format so entries are scannable at a glance:

| Emoji | Category      |
| ----- | ------------- |
| 🔧    | Code fix      |
| 📊    | New analysis  |
| ✏️     | Writing       |
| 🧹    | Cleanup       |
| 📋    | Documentation |
| ⚙️     | Pipeline      |

Entry format:

```
### YYYY-MM-DD — [emoji] [Short title]

**Decision:** What was decided or changed.

**Rationale:** Why this change was made.

**Alternatives considered:** What other options were on the table and why they were rejected.

**Action:** What changed in the codebase or documentation as a result.
```

## Directory Structure

```
Template/
├── CLAUDE.md                        # Agent entry point (this file)
├── research_plan.md                 # Full study design, built from PAP or research intention
├── README.md
├── Template.Rproj
│
├── Context/
│   ├── Templates/
│   │   ├── pre_analysis_plan.md     # Clean PAP template (experimentalist)
│   │   └── research_intention.md    # Clean research intention template (empiricist/IO)
│   ├── Roles/
│   │   ├── researcher_profile.md    # General: background, writing style, LaTeX, R prefs
│   │   ├── profile_experimentalist.md  # Experimental economics — targets JEBO
│   │   ├── profile_empiricist.md    # Observational behavioural economics — targets JEBO
│   │   ├── profile_io.md            # Industrial organisation — targets RAND, JIE, IJIO, JEMS
│   │   ├── profile_referee.md       # Simulated referee persona (orchestration)
│   │   ├── profile_referee_cycle1.md  # Referee Cycle 1: Theory & Framework
│   │   ├── profile_referee_cycle2.md  # Referee Cycle 2: Results & Integration
│   │   ├── researcher_interview.md  # Decision-tree PAP / research intention elicitation script
│   │   ├── results_review_checklist.md # Item-by-item results review gate checklist
│   │   ├── subagent_protocol.md     # Subagent spawning, output, and handoff rules
│   │   ├── revision_protocol.md     # Multi-cycle revision and re-analysis protocol
│   │   ├── skill_graphs.md          # Graph style guidelines
│   │   └── skill_tables.md          # Table style guidelines
│   └── Flow/
│       ├── timeline.md              # Project progress snapshot
│       ├── todo.md                  # Agent task queue (actionable work items)
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
├── Feedback/                        # Referee reports, committee comments, external feedback
│   └── .gitkeep
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
