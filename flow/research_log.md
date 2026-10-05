# Decision Log

All analytical and design decisions made during the project, with rationale. Append new entries at the bottom. Never delete or modify previous entries.

## Entry Template

Copy this template for each new decision. Prefix the title with the appropriate emoji so entries are scannable at a glance.

| Emoji | Category      |
| ----- | ------------- |
| 🔧    | Code fix      |
| 📊    | New analysis  |
| ✏️     | Writing       |
| 🧹    | Cleanup       |
| 📋    | Documentation |
| ⚙️     | Pipeline      |

```
### YYYY-MM-DD — [emoji] [Short decision title]

**Decision:** What was decided.

**Rationale:** Why this choice was made.

**Alternatives considered:** What other options were on the table and why they were rejected.

**Action:** What changed in the codebase or documentation as a result.
```

---

### 2026-02-21 — 📋 Analysis category definitions and further analyses appendix

**Decision:** Formalised the distinction between robustness, exploratory, and further analysis across the template. Added a "Further Analyses" LaTeX appendix for work that is interesting to the authors but not relevant for the paper.

**Rationale:** The existing documentation conflated robustness (tests of existing findings) with exploratory (new questions beyond hypotheses). Agents entering the project could not reliably distinguish them. Additionally, there was no structured place for analyses that were investigated, found informative, but ultimately dropped — these need a home with a brief paragraph explaining why they didn't make the cut.

**Alternatives considered:** Putting the definitions only in `context.md` without updating the R script headers. Rejected because agents often read only the script they're working in and may never consult the context file. Also considered a single catch-all appendix, but separating standard appendix material (tables/figures referenced in the paper) from further analyses (available upon request) matches journal conventions.

**Action:** Updated `Context/context.md` (analysis category definitions), `scripts/robustness.R`, `scripts/exploratory.R`, and `scripts/further_analysis/further_analysis.R` (header comments). Created `LaTeX/app_further.tex` and wired it into `LaTeX/main.tex` (commented out by default). Added change log enforcement section to `CLAUDE.md` with emoji-prefixed entry format. Updated `Context/flow/research_log.md` entry template.

### 2026-02-23 — 📋 Added Feedback folder for referee reports and external comments

**Decision:** Created a `feedback/` directory for storing all external feedback received during the project. Established a naming convention using `referee_report_` and `comments_` prefixes to distinguish journal referee reports from other feedback sources.

**Rationale:** The template had no structured location for incoming feedback. Referee reports, seminar comments, and committee feedback are key inputs to the revision protocol but had no defined home. A dedicated folder with clear naming conventions ensures feedback is easy to find, consistently organised, and feeds cleanly into `Context/Roles/revision_protocol.md`.

**Alternatives considered:** Storing feedback inside `Context/flow/` alongside the research log. Rejected because feedback is external input, not internally generated documentation. Also considered a flat naming scheme without prefixes, but the `referee_report_` / `comments_` distinction makes the origin immediately scannable.

**Action:** Created `feedback/` with `.gitkeep`. Added Feedback section to `Context/context.md` with naming convention, examples, and rules. Added Feedback section and directory entry to `README.md`. Updated directory tree in `Context/context.md` and `README.md`. Updated `Context/Roles/subagent_protocol.md` document file-writing protocol to reference `feedback/` for external feedback. Updated `Context/Roles/revision_protocol.md` file location summary.

### 2026-02-23 — 🧹 Fixed outdated numbered script references across Context files

**Decision:** Replaced all remaining numbered script references (`00_packages.R`, `01_settings.R`, `02`–`04`, `05`–`09`, etc.) with the current script names (`config_toolkit.R`, `config_cleaning.R`, `sample_restrictions.R`, `balance_table.R`, `descriptives.R`, `hypotheses.R`, `robustness.R`, `exploratory.R`).

**Rationale:** Script names were renamed from numbered prefixes to descriptive names in an earlier restructure, but several Context files still referenced the old names. Agents reading these files would get incorrect script references.

**Alternatives considered:** None — the old names are simply wrong and must be corrected.

**Action:** Updated references in `Context/Roles/skill_graphs.md`, `Context/Roles/skill_tables.md`, `Context/Roles/researcher_profile.md`, `Context/Roles/subagent_protocol.md`, `Context/Roles/results_review_checklist.md`, `Context/Roles/revision_protocol.md`, and `Context/context.md` (output naming examples table).

### 2026-07-23 — 🧹 Reconciled output folders under LaTeX/output/ and polished front matter

**Decision:** Canonical output location is `LaTeX/output/figures`, `LaTeX/output/tables`, `LaTeX/output/text`. Removed the stray bare `LaTeX/figures`, `LaTeX/tables`, `LaTeX/text` folders (empty placeholders only). Replaced the bold "ABSTRACT." block in `main.tex` with a proper `abstract` environment and aligned the `\thanks` footnote wording with the Honesty Penalty paper structure.

**Rationale:** `OUTPUT_ROOT` in `scripts/config_init.R` already pointed at `LaTeX/output`, and all `.tex` example paths already referenced `output/...`, but bare sibling folders on disk contradicted the canonical layout. The front-matter changes match the target journal-paper conventions.

**Alternatives considered:** Pointing `OUTPUT_ROOT` at the bare folders instead. Rejected — the `output/` wrapper keeps generated artefacts in one syncable subtree (see `SYNC_DESTINATIONS`).

**Action:** Created `LaTeX/output/{figures,tables,text}` each with `.gitkeep`; deleted the bare placeholder folders. Verified `save_graph`/`save_table`/`save_text` in `scripts/config_toolkit.R` already create and write to `OUTPUT_ROOT` subfolders (no code change needed; confirmed with a standalone Rscript test). Edited `LaTeX/main.tex` (abstract environment, `\thanks` wording). Installed `threeparttable` and `babel-english` into the user texmf tree; `latexmk -pdf` now builds cleanly.

### 2026-10-05 — ⚙️ Batch 1: helper folder into the scripts folder, tracked data folder, sensitive-data and agent-scratch folders

**Decision:** Moved the root helper folder into the scripts folder (now `scripts/helper/`). Made the data folder tracked (dropped the ignores on `Data/*.RData` and `Data/*.csv`). Added `Data/raw_SENSITIVE/` as the single, gitignored home for identifiable raw data, and a gitignored root `_ai/` folder for agent scratch, briefs and notes.

**Rationale:** All R code under `scripts/`; the analysis should rebuild from GitHub, so data is tracked, with identifiable files isolated in one folder that can never be committed. Agent working files stay out of the deliverables and out of git.

**Alternatives considered:** Keeping the data folder ignored. Rejected — a clone could not reproduce the results without out-of-band data transfer.

**Action:** moved the helper folder with `git mv` (now `scripts/helper/`); updated `source()` paths in `main.R` and `scripts/config_cleaning.R`, adapter headers, and `README.md`. Created `Data/raw_SENSITIVE/.gitkeep` and `_ai/.gitkeep`; `.gitignore` rules `Data/raw_SENSITIVE/*` + `!Data/raw_SENSITIVE/.gitkeep` and `_ai/*` + `!_ai/.gitkeep`. Documented both in `CLAUDE.md` and `README.md`. Committed as cff93a7.

### 2026-10-05 — ⚙️ Batch 2: lower-case data/, single output folder, DECISIONS.md, pre-commit sensitive-data check

**Decision:** Renamed `Data/` to `data/`, with `data/datasets/` (anonymised raw exports, tracked), `data/raw_SENSITIVE/` (ignored) and one combined cleaned dataset at the root of `data/` as both CSV and RData. Cleaning stays commented out in `main.R`. Outputs go only to `LaTeX/output/{figures,tables,text}` (tracked); the multi-study prefix convention was removed. Added `DECISIONS.md` and a bash pre-commit hook that refuses commits containing identifiers.

**Rationale:** See `DECISIONS.md` (2026-10-05 entries). In short: a predictable, rebuildable data layout; one output location; and a mechanical guard now that data is tracked.

**Alternatives considered:** A Python or R based hook. Rejected — bash plus git has no dependency to install. Allowlisting `README.md` for the Overleaf project URL (a 24-hex ObjectID). Rejected in favour of excluding hex runs that follow a `/`, so README stays scanned.

**Action:** Two-step `git mv Data data_tmp && git mv data_tmp data`; updated paths in `main.R`, `scripts/config_cleaning.R`, `scripts/config_toolkit.R`, `.gitignore`, `README.md`, `CLAUDE.md`, `flow/codebook.md`. Added `data/README.md`, `data/CODEBOOK.md`, `DECISIONS.md`, `.githooks/pre-commit`. Removed `scripts/pilot_descriptives.R`, `scripts/exp1_hypotheses.R`, `scripts/both_exp1_vs_exp2.R`, `LaTeX/output/pilot/`, the multi-study sections of `CLAUDE.md`/`README.md`, and the stale `LaTeX/{figures,tables,text}` ignore lines. Hook verified: refuses a staged fake Prolific ID and a `PROLIFIC_PID` header; real tree passes.

### 2026-10-05 — ⚙️ Batch 3: all folder names lower-case

**Decision:** Renamed every folder to start lower-case: `scripts/`, `scripts/helper/`, `scripts/further_analysis/` (lower-case and no space), `data/datasets/`, `LaTeX/`, `LaTeX/output/{figures,tables,text}`, `flow/`, `feedback/`, `literature/`. `data/raw_SENSITIVE/` already starts lower-case and keeps its capitalised suffix as a warning label.

**Rationale:** Case-sensitive Linux/CI and consistency (see `DECISIONS.md`).

**Alternatives considered:** Keeping capitalised names. Rejected — paths that only resolve on case-insensitive macOS disks fail silently on Linux and CI.

**Action:** Two-step `git mv` via a temp name for every case-only rename (the working disk is case-insensitive). Renames inside the nested Overleaf repo (`output/` and its subfolders) were done with `git -C latex mv` so that repo records renames; the root index entries for those files were rewritten to the lower-case paths. Updated paths in `main.R`, all R scripts (incl. `save_graph`/`save_table`/`save_text` subfolder names and `OUTPUT_ROOT`), the `.tex` `\input`/`\includegraphics` paths, root `.gitignore`, `README.md`, `CLAUDE.md`, `flow/*.md`, `data/README.md`, `DECISIONS.md`; historical log entries were updated to the new paths. Added a guard in `scripts/config_init.R` so the RStudio-only `setwd()` is skipped outside RStudio (`Rscript main.R` from the project root). Verified: `latexmk -pdf` builds `LaTeX/main.pdf`; a scratch document resolved `output/{figures,tables,text}` paths from `LaTeX/`; pre-commit hook re-tested.

### 2026-10-05 — ⚙️ Correction to batch 3: `LaTeX/` keeps its capitalisation

**Decision:** `LaTeX/` keeps its capitalisation (brand name); its subfolders stay lower-case (`LaTeX/output/{figures,tables,text}`), and every other folder stays lower-case.

**Rationale:** LaTeX is a brand name, so its spelling is kept.

**Alternatives considered:** Fully lower-case `latex/`. Rejected by Julian.

**Action:** Two-step `git mv latex latex__tmp && git mv latex__tmp LaTeX` in the root repo. Rewrote `latex/` paths back to `LaTeX/` in R scripts (incl. `OUTPUT_ROOT` in `scripts/config_init.R`), root `.gitignore`, `README.md`, `CLAUDE.md`, `flow/*.md`, `literature/README.md`, `DECISIONS.md`. `.tex` paths are relative (`output/...`) and needed no change. Staged the renames and `.tex` edits in the nested Overleaf repo with `git -C LaTeX add -A`.
