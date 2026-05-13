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

Need outputs in more than one place — e.g. a local Overleaf clone alongside the in-repo copy? Add the extra path to `SYNC_DESTINATIONS` in `Scripts/config_init.R` and every `save_graph` / `save_table` / `save_text` call writes to both:

```r
SYNC_DESTINATIONS <- c(
  path.expand("~/Overleaf/your-project/Output")
)
```

### Sync to Overleaf via git

The `LaTeX/` folder is structured so it can be the working tree of an Overleaf project. Overleaf supports git access on most paid plans — clone the Overleaf project, point `SYNC_DESTINATIONS` at its `Output/` subfolder, and push the `LaTeX/` contents up with git when you want the manuscript to sync. Overleaf has a help page for the git workflow: <https://www.overleaf.com/learn/how-to/Using_Git_to_track_your_work_on_Overleaf>.

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
