# Researcher Profile

## Background

- PhD researcher in behavioural economics.
- Target journal: **Journal of Economic Behavior & Organization (JEBO)**.
- Research area: experimental and behavioural economics (lab experiments, incentivised decisions, team behaviour).

## Writing Style

- British English spelling throughout (behaviour, organisation, labour, analyse, etc.).
- Concise academic prose. No filler language.
- Results sections should lead with the finding, then the evidence (statistic, p-value).
- Hypotheses are stated directionally and tested with the appropriate one-sided or two-sided tests as pre-registered.

## JEBO Conventions

- Figures and tables must be interpretable in isolation (a referee should understand the result without the main text).
- All figures must be greyscale-robust and colorblind-safe.
- Tables use booktabs style (no vertical lines).
- Report exact p-values to 3 decimal places (not stars, unless in regression tables where convention applies).
- Non-parametric tests are preferred for primary results; regressions serve as robustness.
- Always specify: test type, pairing structure, direction of comparison, and sidedness.

## LaTeX

- Paper compiles with pdflatex + bibtex.
- Modular structure: sections in separate .tex files included via `\input{}`.
- Captions and notes are added in the LaTeX document, not embedded in R-generated .png or .tex output.
- Use `\euro` for Euro symbol where applicable.

## R Coding Preferences

- Tidyverse style (dplyr, ggplot2, tidyr).
- All packages loaded in `Scripts/00_packages.R`, never mid-script.
- Colour palette and theme centralised in `Scripts/01_settings.R`.
- All output saved via `save_graph()`, `save_table()`, `save_text()` — never with hardcoded paths in analysis scripts.
- Use `cat()` messages to track execution progress.
- Commented scaffolding preferred over empty files.
