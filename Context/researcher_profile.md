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

## Analysis Methodology

- Primary results use non-parametric tests wherever possible (e.g. Wilcoxon rank-sum, Wilcoxon signed-rank, permutation tests).
- Non-parametric tests are conducted at the group level: collapse individual-level data to one observation per independent group before testing.
- Parametric tests (OLS, logit, etc.) serve as robustness checks, replicating the same predictions tested non-parametrically.
- Standard errors in all parametric models are clustered at the group level.
- The hypotheses script reports non-parametric results as the primary evidence; the robustness script re-tests the same predictions with regressions and controls.
- Always report: test type, number of observations/groups, test statistic, and exact p-value (to 3 decimal places).
- Specify sidedness (one-sided or two-sided) consistent with the directional or non-directional nature of each hypothesis.

## R Coding Preferences

- Tidyverse style (dplyr, ggplot2, tidyr).
- All packages loaded in `Scripts/00_packages.R`, never mid-script.
- Colour palette and theme centralised in `Scripts/01_settings.R`.
- All output saved via `save_graph()`, `save_table()`, `save_text()` — never with hardcoded paths in analysis scripts.
- Use `cat()` messages to track execution progress.
- Commented scaffolding preferred over empty files.
