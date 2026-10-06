# Decisions

Project and template decisions, **newest first**. Each entry: date, decision, reason. Add new entries at the top.

---

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
