# Project conventions

This file is here for anyone using Claude Code (or another AI assistant) inside this template. It is short on purpose — the template is designed to be used manually first, with AI as an optional helper.

## Style references

Two reference documents live in `Tools/`:

- `Tools/skill_graphs.md` — JEBO publication-ready figure conventions used across this project.
- `Tools/skill_tables.md` — JEBO publication-ready table conventions.

When generating figures or tables, follow these. If the target journal changes, swap them out for that journal's conventions.

## Project state

Project aim and current status are tracked in:

- `Flow/personality.md` — what the project is about, theoretical framing, methods snapshot.
- `Flow/timeline.md` — phase-level progress.
- `Flow/todo.md` — current actionable work.
- `Flow/research_log.md` — chronological decision log.
- `Flow/codebook.md` — variable-level documentation.

Read the relevant `Flow/` files before doing any analysis-touching work, and update `Flow/research_log.md` after meaningful changes.

## Pipeline

The analysis runs from `main.R` in the project root. Output is written to `LaTeX/Output/Figures/`, `LaTeX/Output/Tables/`, and `LaTeX/Output/Text/` via the `save_graph()`, `save_table()`, and `save_text()` helpers defined in `Scripts/config_toolkit.R`. British English throughout.
