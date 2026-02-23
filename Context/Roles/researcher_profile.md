# Researcher Profile (General)

## Background

- PhD researcher in economics.
- This is the shared profile containing conventions common to all projects regardless of field or methodology.

## Research Personality

Choose one of the personalities below based on the type of study. Load the selected personality file alongside this shared profile — it specifies the target journal, field-specific conventions, and analysis methodology.

| Personality | Profile | When to use |
|---|---|---|
| **Experimentalist** | [`profile_experimentalist.md`](profile_experimentalist.md) | Lab, online, or field experiments with randomised treatment assignment. Causal identification via randomisation. Non-parametric tests are the primary evidence; regressions are robustness. Targets JEBO. |
| **Empiricist** | [`profile_empiricist.md`](profile_empiricist.md) | Observational, survey, or administrative data with behavioural economics focus. Causal identification via quasi-experimental methods (IV, DiD, RDD, matching). Regressions are the primary evidence; robustness via alternative specifications and placebo tests. Targets JEBO. |
| **Industrial Organisation** | [`profile_io.md`](profile_io.md) | Firm-level, market-level, or industry data. Competition, pricing, entry, mergers, regulation. Structural estimation or reduced-form identification. Targets RAND, JIE, IJIO, or JEMS. |

## Writing Style

- British English spelling throughout (behaviour, organisation, labour, analyse, etc.).
- Concise academic prose. No filler language.
- Results sections lead with the finding and embed core numbers (percentages, means, differences) directly in the prose. Test details follow in parentheses. Do not report test statistics in running text — only the test name and p-value, or coefficient and p-value.

## General Statistical Conventions

- Report exact p-values to two decimal places with no leading zero (`$p=.34$`, not `$p=0.340$`). Use three decimal places only when $p<.01$ (e.g. `$p=.003$`). Use `$p<.001$` as the floor.
- Always specify: test type, sidedness, and pairing/clustering structure.
- In regression tables, significance stars follow journal convention; in prose, report only p-values.
- Field-specific test conventions (which tests are primary, what to report in parentheses) are defined in the active personality profile.

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
- All packages loaded in `Scripts/config_toolkit.R`, never mid-script.
- Colour palette and theme centralised in `Scripts/config_toolkit.R`.
- All output saved via `save_graph()`, `save_table()`, `save_text()` — never with hardcoded paths in analysis scripts.
- Use `cat()` messages to track execution progress.
- Commented scaffolding preferred over empty files.
- **Script separation**: the main pipeline (`balance_table.R` through `exploratory.R`) contains only analyses reported in the paper. Anything beyond what is mentioned in the manuscript — extended robustness, diagnostics, researcher-only checks — goes in `Scripts/Further Analysis/`. See the "Script separation" section in `Context/context.md`.
