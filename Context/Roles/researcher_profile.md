# Researcher Profile (Shared)

## Background

- PhD researcher in behavioural economics.
- Target journal: **Journal of Economic Behavior & Organization (JEBO)**.

## Research Personality

This shared profile contains conventions common to all projects. Choose one of the two personalities below based on the type of study, and load it alongside this file:

| Personality | Profile | When to use |
|---|---|---|
| **Experimentalist** | [`profile_experimentalist.md`](profile_experimentalist.md) | Lab, online, or field experiments with randomised treatment assignment. Causal identification via randomisation. Non-parametric tests are the primary evidence; regressions are robustness. |
| **Empiricist** | [`profile_empiricist.md`](profile_empiricist.md) | Observational, survey, or administrative data. Causal identification via quasi-experimental methods (IV, DiD, RDD, matching). Regressions are the primary evidence; robustness via alternative specifications and placebo tests. |

## Writing Style

- British English spelling throughout (behaviour, organisation, labour, analyse, etc.).
- Concise academic prose. No filler language.
- Results sections lead with the finding and embed core numbers (percentages, means, differences) directly in the prose. Test details follow in parentheses: `(test type, $p=.XX$, sidedness)`. Do not report test statistics (no $z$, $W$, $\chi^2$, etc.) — only the test name and p-value.

## JEBO Conventions

- Figures and tables must be interpretable in isolation (a referee should understand the result without the main text).
- All figures must be greyscale-robust and colorblind-safe.
- Tables use booktabs style (no vertical lines).
- Report exact p-values to two decimal places with no leading zero (`$p=.34$`, not `$p=0.340$`). Use three decimal places only when $p<.01$ (e.g. `$p=.003$`). Use `$p<.001$` as the floor.
- In regression tables, significance stars follow journal convention; in prose and non-parametric results, report only the p-value.
- Always specify: test type, sidedness, and pairing structure. Do **not** report test statistics in prose — only the test name and p-value.

## LaTeX

- Paper compiles with pdflatex + bibtex.
- Modular structure: sections in separate .tex files included via `\input{}`.
- Captions and notes are added in the LaTeX document, not embedded in R-generated .png or .tex output.
- Use `\euro` for Euro symbol where applicable.
- Use a single `\begin{figure}` environment for standalone graphs. Only use `subfigure` when placing multiple panels side by side.
- Notes go in a `minipage` below the graphic, in `\footnotesize` italic.

### Figure template (single panel)

```latex
\begin{figure}[H]
    \centering
    \caption{Descriptive title of the figure.}
    \includegraphics[width=0.9\textwidth]{Output/Graphs/filename.png}
    \label{fig:label}
    \begin{minipage}{0.8\linewidth}
        \footnotesize
        \textit{Notes:} Explanation of the figure content, unit of observation, error bars, etc.
    \end{minipage}
\end{figure}
```

### Figure template (subfigures)

```latex
\begin{figure}[H]
    \centering
    \caption{Overall caption describing both panels.}
    \begin{subfigure}{0.35\textwidth}
        \centering
        \caption{Panel (a) title}
        \includegraphics[width=\textwidth]{Output/Graphs/panel_a.png}
        \label{fig:panel_a}
    \end{subfigure}
    \begin{subfigure}{0.35\textwidth}
        \centering
        \caption{Panel (b) title}
        \includegraphics[width=\textwidth]{Output/Graphs/panel_b.png}
        \label{fig:panel_b}
    \end{subfigure}
    \label{fig:combined_label}
    \begin{minipage}{0.8\linewidth}
        \footnotesize
        \textit{Notes:} Explanation of the figure content, unit of observation, error bars, etc.
    \end{minipage}
\end{figure}
```

## R Coding Preferences

- Tidyverse style (dplyr, ggplot2, tidyr).
- All packages loaded in `Scripts/00_packages.R`, never mid-script.
- Colour palette and theme centralised in `Scripts/01_settings.R`.
- All output saved via `save_graph()`, `save_table()`, `save_text()` — never with hardcoded paths in analysis scripts.
- Use `cat()` messages to track execution progress.
- Commented scaffolding preferred over empty files.
