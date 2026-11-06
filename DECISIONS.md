# Decisions

Project and template decisions, **newest first**. Each entry: date, decision, reason. Add new entries at the top.

---

### 2026-11-06: Pre-commit check skips `literature/*.pdf`
**Decision:** `.githooks/pre-commit` allowlists `literature/*.pdf`.
**Reason:** Published papers carry author emails, which the check flagged as identifiers (first seen when a new project committed its literature). They are not participant data. Data files stay scanned.

### 2026-11-05: `otree_session` in the oTree long data; `otree.R` set up for the current oTree template
**Decision:** `scripts/helper/otree.R` carries `session.code` as `otree_session`, right after `lab_session`, as text, NA when an export lacks it. `session` stays the CSV file name. The shipped config now describes the current oTree template instead of the empty `main_task` placeholder: app `main` with `rounds = 5` (its `num_experimental_rounds`) and `payoff` from `player.round_payoff`, plus `treatment_group` from `participant.treatment_group`, `num_failed_attempts` from `participant.comprehension_failed_attempts`, and age, gender, selected_sum, earned and sepa from `outro.1.player`. The public download `otree-wide-to-long.R` on juliantait.eu is this file with its own header and one more column: there `participant_label` is on, here it is commented out.
**Reason:** One CSV can hold several sessions, and the file name cannot tell them apart. The download and this file had drifted, and the download's mappings had gone stale, so this file now holds one config checked against a real export and the download follows it. `num_failed_attempts` uses the participant counter because `intro.<round>.player.num_failed_attempts` counts per pass: on a real walk that failed 3 times, took the re-read and failed once more, intro.1 shows 3, intro.2 shows 1 and the counter 4, the figure the quiz bonus reads. `participant_label` stays off here because cleaning writes the tracked `data/data_cleaned.csv` and the pre-commit check refuses that header. Rounds stays a setting: `otree.R` reads no settings file, and a config that runs fewer rounds still exports every round's columns, so those rows hold NA.

### 2026-11-05: `lab_session` in the oTree long data, as text, always present
**Decision:** `scripts/helper/otree.R` maps `session.config.lab_session` to `lab_session` in `constant_variables`, so it is on every long row. The column is listed in `text_columns`, re-read without type guessing and with only the empty string as missing, and kept character after stacking. An empty cell is NA; an export without the column gives NA on every row.
**Reason:** The lab session number is short text (217b, 007, NA). readr's defaults read a literal NA as missing and can read other values as numbers. A column always present matches how the file already treats missing columns (aligned to NA when stacking, NA for a missing constant variable), so the long data has one shape for old and new exports.

### 2026-10-06 — One values file per document instead of one file per scalar
**Decision:** Every scalar the paper quotes is registered in R with `save_value(name, value)` and written once per run by `write_values()` to a single `LaTeX/output/values.tex` (sorted `\setval{name}{value}` lines) plus `LaTeX/output/values.json` (same map). LaTeX loads it through `LaTeX/values_macros.tex` and prints a number with `\val{name}`, or a bold `[name?]` when it is missing. A full `main.R` run replaces the file; a script run on its own merges into it. `save_text()` is kept as a thin wrapper around `save_value()`; `LaTeX/output/text/` is gone. `fmt_p()` and `fmt_est()` are now defined in `scripts/config_toolkit.R`.
**Reason:** In the Experts project, built from this template, one brief exported 692 separate `.txt` scalars: that hit Overleaf's 2000-file cap, made the output folders unbrowsable, and turned "which numbers changed" into a 700-file diff. One sorted, generated file keeps every number sourced from a script while a re-run diff shows exactly which numbers moved.

### 2026-10-06 — latexmk copies back only the PDF just built
**Decision:** `LaTeX/.latexmkrc` keeps `$success_cmd = q{cp "%D" "./%R.pdf"}`, which copies back only the PDF of the document just built, with quoted paths.
**Reason:** The Experts project replaced this with an `END` block that copied every PDF in `.build/` after any build, so building one document re-timestamped all others (a 7.6 MB PDF among them) and iCloud re-synced them to the laptop. Paths are quoted because the Mac iCloud path contains spaces.

### 2026-10-05 — All folder names lower-case, except `LaTeX/`
**Decision:** Every folder name starts lower-case — `scripts/`, `scripts/helper/`, `scripts/further_analysis/` (previously capitalised and containing a space), `data/datasets/`, `LaTeX/output/{figures,tables,text}`, `flow/`, `feedback/`, `literature/` — **except `LaTeX/`**, which keeps its capitalisation. All paths in code and docs updated.
**Reason:** Case-sensitive Linux and CI break on paths that only work on case-insensitive macOS disks; one consistent convention removes the guesswork for humans and agents. `LaTeX/` is the exception because LaTeX is a brand name; its subfolders are lower-case. (`data/raw_SENSITIVE/` keeps its capitalised suffix on purpose, as a warning label.)

### 2026-10-05 — Pre-commit sensitive-data check
**Decision:** A bash-only hook at `.githooks/pre-commit` (installed with `git config core.hooksPath .githooks`) scans every tracked file as staged for Prolific IDs, emails, IPv4 addresses, user-agent strings, and identifying CSV/TSV column headers, and refuses the commit on a hit.
**Reason:** Now that `data/` is tracked, a mistakenly staged identifiable file would go straight to GitHub. A mechanical check at commit time catches what review misses; bash keeps it dependency-free.

### 2026-10-05 — Single output folder
**Decision:** Outputs go only to `LaTeX/output/{figures,tables,text}`, which is tracked. The per-study prefix/subfolder convention and its example scripts and `LaTeX/output/pilot/` were removed.
**Reason:** One fixed location is simpler for humans and agents and for the LaTeX paths; the multi-study scaffolding added structure the template does not need.

### 2026-10-05 — Cleaning commented out in `main.R`
**Decision:** The cleaning block in `main.R` stays commented out; uncomment it only to rebuild `data/data_cleaned.{csv,RData}` from `data/datasets/`.
**Reason:** The cleaned data is tracked, so a normal run starts from it; rebuilding is a deliberate, occasional step.

### 2026-10-05 — Lower-case `data/`
**Decision:** Renamed `Data/` to `data/` (two-step `git mv` so case-insensitive disks follow).
**Reason:** Lower-case matches common replication-package convention and avoids case mismatches between macOS and Linux.

### 2026-10-05 — `_ai/` ignored
**Decision:** Agent/worker scratch, briefs and intermediate notes go in `_ai/`, gitignored except its `.gitkeep`.
**Reason:** Keeps agent working files out of the deliverables and out of git while the folder still exists in every clone.

### 2026-10-05 — `data/` tracked, only `raw_SENSITIVE/` ignored
**Decision:** `data/` is tracked (anonymised raw exports in `datasets/`, one combined cleaned dataset as CSV + RData). Identifiable raw data lives only in `data/raw_SENSITIVE/`, which is ignored except its `.gitkeep`.
**Reason:** Everything should rebuild from GitHub; the one thing that must never be committed is isolated in a single, clearly named folder.

### 2026-10-05 — `helper/` moved into `scripts/`
**Decision:** Data-source adapters and the sync helper live in `scripts/helper/`.
**Reason:** All R code sits under `scripts/`; the root holds only top-level entry points and folders.
