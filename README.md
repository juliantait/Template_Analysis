# Template_Analysis

A self-contained R + LaTeX template for a single-study empirical economics paper. Clone it, point it at your data, run the pipeline, write up the results, and you should be left with a publication-ready manuscript and a set of figures and tables that match journal conventions.

## What you do with it

1. **Clone** this repository to a new project folder.
2. **Drop your raw data** into `Data/` (a `Data/DataSets/` subfolder is provided).
3. **Wire up the data source** by editing one of the adapters in `Helper/` — `otree.R` for oTree experiments, `csv.R` for generic CSVs. The adapter exposes a `load_data()` function that the cleaning pipeline calls.
4. **Run the pipeline** by opening `main.R` and executing it. The scripts in `Scripts/` run in order: init → toolkit → cleaning → sample restrictions → balance → descriptives → hypotheses → robustness → exploratory.
5. **Write the paper** in `LaTeX/`. The analysis scripts save figures, tables, and inline numbers directly into `LaTeX/Figures/`, `LaTeX/Tables/`, and `LaTeX/Text/`, so the manuscript can reference them with simple relative paths.
6. **Compile** `LaTeX/main.tex` to get the PDF.

## Project documentation

`Flow/personality.md` is where you record what the project is about — research question, theoretical framing, methods snapshot, status, deliverables. Fill it in early; it is the orientation document for anyone (including future-you) coming back to the project.

## Top-level folders

| Folder | What lives there |
|---|---|
| `Scripts/` | The analysis pipeline. Each script corresponds to a section of the paper. |
| `Helper/` | Data-source adapters (`otree.R`, `csv.R`) and an optional output-sync helper. |
| `Data/` | Raw data files. Not under version control by default. |
| `LaTeX/` | Manuscript source. Figures, tables, and text snippets are written here by the analysis scripts. |
| `Flow/` | Project tracking: `personality.md`, `timeline.md`, `todo.md`, `research_log.md`, `codebook.md`. |
| `Tools/` | Reusable style references — currently graph and table conventions. |
| `Literature/` | Project-relevant papers and reading notes. |
| `Feedback/` | Referee reports, seminar comments, and other external feedback. |

`Tools/` contains JEBO journal style conventions for graphs and tables; reuse them or replace with your own journal's conventions.

## Using Claude Code (optional)

This template is designed for manual use. If you do use Claude Code, the short `CLAUDE.md` at the root points it at the style references in `Tools/` and the project state in `Flow/`.

If you want a Claude-Code-orchestrated variant of this template (with role profiles, phase walks, structured `Context/`), see [github.com/juliantait/Template_Analysis_Claude](https://github.com/juliantait/Template_Analysis_Claude).
