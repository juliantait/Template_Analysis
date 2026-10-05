# Template_Analysis

A self-contained R + LaTeX template for a single-study empirical economics paper. Clone it, point it at your data, run the pipeline, write up the results, and you should be left with a publication-ready manuscript and a set of figures and tables that match journal conventions.

## What you do with it

1. **Clone** this repository to a new project folder.
2. **Drop your anonymised raw exports** into `data/datasets/`. Any raw file that carries identifiers — Prolific IDs, participant labels, user agents, free text — goes in `data/raw_SENSITIVE/` instead (see [Sensitive raw data](#sensitive-raw-data)). `data/README.md` maps the folder.
3. **Wire up the data source** by editing one of the adapters in `scripts/helper/` — `otree.R` for oTree experiments, `csv.R` for generic CSVs. The adapter exposes a `load_data()` function that the cleaning pipeline calls.
4. **Build the cleaned data once** by uncommenting the CLEANING block in `main.R`, running it, and commenting it out again. This writes one combined dataset to `data/data_cleaned.csv` and `data/data_cleaned.RData`.
5. **Run the pipeline** by opening `main.R` and executing it. The scripts in `scripts/` run in order: init → toolkit → cleaning → sample restrictions → balance → descriptives → hypotheses → robustness → exploratory.
6. **Write the paper** in `LaTeX/`. The analysis scripts save figures, tables, and inline numbers directly into `LaTeX/output/figures/`, `LaTeX/output/tables/`, and `LaTeX/output/text/`, so the manuscript can reference them with simple relative paths.
7. **Compile** `LaTeX/main.tex` to get the PDF.

### Outputs

Analysis outputs are written to `LaTeX/output/`, split across `figures/`, `tables/`, and `text/` subfolders. The LaTeX paper sources in `LaTeX/` reference them with relative paths like `output/figures/foo.png`, so the whole `LaTeX/` folder is self-contained and compiles wherever it lands.

Outputs are generated in this one folder only — there are no per-study subfolders. The optional `SYNC_DESTINATIONS` mirror below is empty by default.

Need outputs mirrored into _more than one local folder_ — e.g. a separate per-paper bundle, or a sibling Overleaf working tree alongside the canonical `LaTeX/output`? Add the extra path to `SYNC_DESTINATIONS` in `scripts/config_init.R` and every `save_graph` / `save_table` / `save_text` call writes to both:

```r
SYNC_DESTINATIONS <- c(
  path.expand("~/Some/Other/output")
)
```

`SYNC_DESTINATIONS` is _not_ required for the standard Overleaf-sync workflow below: in that workflow Overleaf and `LaTeX/` are the same working tree, so there is only one place outputs need to land.

### Sync to Overleaf via git

**Live configuration (recorded 2026-07-28).** This template's `LaTeX/` is already its own git repo wired to Overleaf:

| Repo | Remote (`origin`) | Branch |
|---|---|---|
| `LaTeX/` → **Overleaf** | `https://git.overleaf.com/628642ba67dbbdcff9b2acf7` | `main` |
| project root → **GitHub** | `https://github.com/juliantait/Template_Analysis.git` | `main` |

Push `LaTeX/` edits to **both** remotes (`cd LaTeX && git push origin main`, and push the root separately to GitHub). Compiled PDFs are gitignored. This replaced the retired `Template_Analysis_Claude`, which previously held the Overleaf remote. The setup steps below are kept for reference / for new projects cloned from this template.

The `LaTeX/` folder is the source of truth. Overleaf is just another remote you push it to. Note: Overleaf's git integration is a premium feature — available on paid individual or group subscriptions and to Overleaf Commons participants. On the free plan the Git option does not appear under Integrations.

Setup:

1. Create a new, empty project in Overleaf via the web UI.
2. Inside the local `LaTeX/` folder, initialise a git repo if it is not one already: `cd LaTeX && git init`. `LaTeX/` becomes its own working tree, independent from the outer `Template_Analysis` repo.
3. Get the Overleaf project's git URL: in the project, open the sidebar → **Integrations** → **Git**. The URL has the format `https://git.overleaf.com/<project-id>`.
4. Add it as a remote and push:

   ```sh
   git remote add overleaf <overleaf-git-url>
   git push -u overleaf main:master
   ```

   Push your local `main` to whatever default branch Overleaf reports on first push — historically this has been `master`. If `git push -u overleaf main:master` is rejected, run `git ls-remote overleaf` to see the actual branch name and substitute it for `master`.
5. On subsequent edits, push from inside `LaTeX/`:

   ```sh
   git push overleaf main:master
   ```

   To pull collaborator edits back from Overleaf:

   ```sh
   git pull overleaf master
   ```

See <https://docs.overleaf.com/integrations-and-add-ons/git-integration-and-github-synchronization/git-integration> for the Overleaf-side specifics (auth tokens, branch behaviour, etc.).

## Sensitive raw data

`data/raw_SENSITIVE/` is the **single place identifiable raw data lives**: any raw file carrying identifiers — Prolific IDs, participant labels, user agents, free-text responses. It is kept clearly separate from everything else in the project:

- **Never committed.** `.gitignore` ignores everything in it except `.gitkeep`, so the folder exists in clones but its contents never reach git.
- **Never copied elsewhere.** Do not duplicate these files into `data/datasets/`, `_ai/`, `LaTeX/` or anywhere else. Cleaning code reads identifiable files in place from here and writes only de-identified data to the rest of `data/`, which *is* tracked.

### Pre-commit sensitive-data check

A bash-only git hook, `.githooks/pre-commit`, refuses any commit whose staged files contain identifiers. Install it once per clone, from the project root:

```sh
git config core.hooksPath .githooks
```

It scans every tracked file as staged in the index for Prolific IDs (24 hex characters), email addresses, IPv4 addresses and browser user-agent strings, and checks the header row of every CSV/TSV for identifying column names (`name`, `email`, `ip_address`, `participant.label`, `PROLIFIC_PID`, …, case-insensitive). On a hit it prints file, line and pattern and aborts the commit. The patterns, the column list and an allowlist of files to skip are editable lists at the top of the script. `.RData` files are binary and are **not** scanned; their CSV twin (`data/data_cleaned.csv`) is, which is why cleaning writes both.

## Project documentation

`flow/personality.md` is where you record what the project is about — research question, theoretical framing, methods snapshot, status, deliverables. Fill it in early; it is the orientation document for anyone (including future-you) coming back to the project.

## Top-level folders

| Folder | What lives there |
|---|---|
| `scripts/` | The analysis pipeline. Each script corresponds to a section of the paper. |
| `scripts/helper/` | Data-source adapters (`otree.R`, `csv.R`) and an optional output-sync helper. |
| `data/` | Tracked. One combined cleaned dataset at its root (`data_cleaned.csv` + `data_cleaned.RData`), plus `README.md` (folder map, rebuild steps) and `CODEBOOK.md` (variable template). |
| `data/datasets/` | Anonymised raw exports — the cleaning input. Tracked, so everything rebuilds from GitHub. |
| `data/raw_SENSITIVE/` | The single place identifiable raw data lives. Gitignored (only `.gitkeep` tracked), never copied elsewhere. See [Sensitive raw data](#sensitive-raw-data). |
| `_ai/` | Agent/worker scratch, briefs and intermediate notes. Gitignored (only its `.gitkeep` is tracked). |
| `.githooks/` | The pre-commit sensitive-data check. See [Pre-commit sensitive-data check](#pre-commit-sensitive-data-check). |
| `DECISIONS.md` | Project and template decisions, newest first: date, decision, reason. |
| `LaTeX/` | Manuscript source. Figures, tables, and text snippets are written by the analysis scripts to `LaTeX/output/{figures,tables,text}` (tracked). |
| `flow/` | All AI-facing material, kept behind this one folder at the project root: project tracking — `codebook.md`, `research_log.md`, `timeline.md`, `todo.md`, `personality.md` — plus the skill references `skill_graphs.md` and `skill_tables.md` (graphs and tables conventions) for integrating with Claude or other LLM agents. |
| `literature/` | Project-relevant papers and reading notes. |
| `feedback/` | Referee reports, seminar comments, and other external feedback. Meeting notes are named `meetings_YYYY-MM-DD.md` (optional topic suffix: `meetings_2026-09-03_pilot.md`; transcripts: `meetings_YYYY-MM-DD_transcript.md`) — see the example `feedback/meetings_2026-09-03.md`. |

`flow/` holds the publication-style skill references (`skill_graphs.md`, `skill_tables.md`) intended both as a human style guide and as the place to drop additional skill files when integrating with Claude or other LLM agents. Keeping them in `flow/` at the project root — not inside `LaTeX/` or `scripts/` — means a worker with the whole project in view finds them whatever it is working on. The shipped references encode JEBO conventions; reuse them or replace with your own journal's.

## Using Claude Code (optional)

This template is designed for manual use. If you do use Claude Code, the short `CLAUDE.md` at the root points it at the style references in `flow/` (`skill_graphs.md`, `skill_tables.md`) and the project state in `flow/`.

If you want a Claude-Code-orchestrated variant of this template (with role profiles, phase walks, structured `Context/`), see [github.com/juliantait/Template_Analysis_Claude](https://github.com/juliantait/Template_Analysis_Claude).
