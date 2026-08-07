# Template_Analysis

A self-contained R + LaTeX template for a single-study empirical economics paper. Clone it, point it at your data, run the pipeline, write up the results, and you should be left with a publication-ready manuscript and a set of figures and tables that match journal conventions.

## What you do with it

1. **Clone** this repository to a new project folder.
2. **Drop your raw data** into `Data/` (a `Data/DataSets/` subfolder is provided).
3. **Wire up the data source** by editing one of the adapters in `Helper/` — `otree.R` for oTree experiments, `csv.R` for generic CSVs. The adapter exposes a `load_data()` function that the cleaning pipeline calls.
4. **Run the pipeline** by opening `main.R` and executing it. The scripts in `Scripts/` run in order: init → toolkit → cleaning → sample restrictions → balance → descriptives → hypotheses → robustness → exploratory.
5. **Write the paper** in `LaTeX/`. The analysis scripts save figures, tables, and inline numbers directly into `LaTeX/Output/Figures/`, `LaTeX/Output/Tables/`, and `LaTeX/Output/Text/`, so the manuscript can reference them with simple relative paths.
6. **Compile** `LaTeX/main.tex` to get the PDF.

### Outputs

Analysis outputs are written to `LaTeX/Output/`, split across `Figures/`, `Tables/`, and `Text/` subfolders. The LaTeX paper sources in `LaTeX/` reference them with relative paths like `Output/Figures/foo.png`, so the whole `LaTeX/` folder is self-contained and compiles wherever it lands.

### Scaling to several studies or waves (script prefixes)

The template ships as a **single-study** project: the scripts in `Scripts/` have plain names (`descriptives.R`, `hypotheses.R`, ...) and everything writes into the flat `Output/Figures`, `Output/Tables`, `Output/Text` layout. Keep it that way for one study — do not prefix prematurely.

**Once the same repo grows to hold more than one study or wave** (a pilot plus a main experiment, `exp1` plus `exp2`, several data-collection waves), adopt study prefixes so it stays legible:

- **Analysis scripts take the prefix of the study they belong to** — `pilot_`, `exp1_`, `exp2_`, `wave1_`. So `descriptives.R` becomes `pilot_descriptives.R`, `hypotheses.R` becomes `exp1_hypotheses.R`, and so on.
- **Cross-study comparisons take the `both_` prefix**, naming the studies they span: `both_exp1_vs_exp2.R`.
- **Config and helper scripts stay unprefixed**, because every study sources them: `config_init.R`, `config_cleaning.R`, `config_toolkit.R`.
- **Each study writes into its own `Output/<study>/` subfolder** so results never collide: `Output/pilot/figures/`, `Output/pilot/tables/`, `Output/exp1/figures/`, and so on (with `Output/both/...` for comparison outputs). Point each study's `save_graph` / `save_table` / `save_text` calls at its own subfolder.

Worked placeholders show the pattern in place rather than only describing it: example scripts `Scripts/pilot_descriptives.R`, `Scripts/exp1_hypotheses.R`, and `Scripts/both_exp1_vs_exp2.R` (each a commented header — copy or delete), and the matching output tree under `LaTeX/Output/pilot/figures/` and `LaTeX/Output/pilot/tables/`, each with a short README. These examples are not wired into `main.R`; they exist to be copied or removed.

Need outputs mirrored into _more than one local folder_ — e.g. a separate per-paper bundle, or a sibling Overleaf working tree alongside the canonical `LaTeX/Output`? Add the extra path to `SYNC_DESTINATIONS` in `Scripts/config_init.R` and every `save_graph` / `save_table` / `save_text` call writes to both:

```r
SYNC_DESTINATIONS <- c(
  path.expand("~/Some/Other/Output")
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

## Project documentation

`Flow/personality.md` is where you record what the project is about — research question, theoretical framing, methods snapshot, status, deliverables. Fill it in early; it is the orientation document for anyone (including future-you) coming back to the project.

## Top-level folders

| Folder | What lives there |
|---|---|
| `Scripts/` | The analysis pipeline. Each script corresponds to a section of the paper. With multiple studies, scripts take a study prefix (`pilot_`, `exp1_`, `both_`) — see [Scaling to several studies or waves](#scaling-to-several-studies-or-waves-script-prefixes). |
| `Helper/` | Data-source adapters (`otree.R`, `csv.R`) and an optional output-sync helper. |
| `Data/` | Raw data files. Not under version control by default. |
| `LaTeX/` | Manuscript source. Figures, tables, and text snippets are written here by the analysis scripts. |
| `Flow/` | All AI-facing material, kept behind this one folder at the project root: project tracking — `codebook.md`, `research_log.md`, `timeline.md`, `todo.md`, `personality.md` — plus the skill references `skill_graphs.md` and `skill_tables.md` (graphs and tables conventions) for integrating with Claude or other LLM agents. |
| `Literature/` | Project-relevant papers and reading notes. |
| `Feedback/` | Referee reports, seminar comments, and other external feedback. |

`Flow/` holds the publication-style skill references (`skill_graphs.md`, `skill_tables.md`) intended both as a human style guide and as the place to drop additional skill files when integrating with Claude or other LLM agents. Keeping them in `Flow/` at the project root — not inside `LaTeX/` or `Scripts/` — means a worker with the whole project in view finds them whatever it is working on. The shipped references encode JEBO conventions; reuse them or replace with your own journal's.

## Using Claude Code (optional)

This template is designed for manual use. If you do use Claude Code, the short `CLAUDE.md` at the root points it at the style references in `Flow/` (`skill_graphs.md`, `skill_tables.md`) and the project state in `Flow/`.

If you want a Claude-Code-orchestrated variant of this template (with role profiles, phase walks, structured `Context/`), see [github.com/juliantait/Template_Analysis_Claude](https://github.com/juliantait/Template_Analysis_Claude).
