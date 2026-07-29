# JEBO Table Style Guidelines

All tables must be publication-ready for the Journal of Economic Behavior & Organization (JEBO). Tables should be interpretable on their own, follow economics conventions, and prioritise clarity over compactness.

---

## Core principles
- Tables must be self-contained: a reader should understand design, contrasts, and tests without the main text.
- Structure matters more than density.
- Use booktabs-style rules only (no vertical lines).
- Consistent terminology with hypotheses and figures.
- Appendix tables should still meet main-text quality.

---

## Division of labour: R versus LaTeX

This is the rule most often broken, so it is stated before the formatting rules rather than left to the Export section.

**R produces content only.** The tabular body and nothing else: rows, columns, numbers, column headers, and the numeric formatting of those numbers.

**LaTeX produces all presentation.** The float wrapper (`\begin{table}` / `\end{table}`), `\centering`, the font size declaration, the caption, the label, the placement specifier, the notes minipage, and every cross-reference.

**Why the rule exists.** Caption and note wording stays editable in LaTeX without an R re-run. Fixing a note is then a one-line text edit rather than a pipeline execution — which is the difference between correcting a note and rebuilding the paper's outputs to correct a note.

**The same split extends to prose.** Running text carries the p-value, plus the test name and sidedness where that is not already obvious. The test is not where the number came from but what the number is doing in the sentence: *is this number doing interpretive work here, or is it a raw estimate quoted as a credential?* Banned — raw model output quoted in brackets as a credential: `\hat{\beta} = 3.091`, `coefficient = 0.018`, `R^2 = 0.224`, standard errors. Those stay in the table; a raw estimate quoted in prose duplicates a table cell and the two drift apart on the next re-run. Kept — a magnitude written out in words, in units that mean something to the reader: `42 percentage points`, `roughly three dots larger`, `virtually unchanged`, `triple`, `about a third`. Those are the finding stated in human terms, and a paper is worse without them. Two exceptions: correlations keep their rho or r inline (`Spearman rho = -0.231, p = .006`), since a correlation usually has no table and the sign and magnitude are the result; and descriptive means, shares and percentages stay in prose (`49% versus 38% (p = .035, one-sided)`), being results rather than model output. Before: `the interaction reaches significance (\hat{\beta}_3 = 3.091, p = .044)`. After: `the interaction reaches significance (p = .044, one-sided)`.

### Red flags that the rule has been broken

Self-check for these before considering a table generator finished:

- A generated `.tex` file that contains `\begin{table}`, `\caption`, `\label`, or `\textit{Notes:}`.
- A `stargazer()` call without `notes = NULL`.
- Any `kableExtra::footnote()` or `add_footnote()` call.
- For figures: a ggplot carrying `ggtitle()` or `labs(title = ...)`.

Mechanics of the export itself are in [Export](#export) below.

---

## General formatting rules
- Always use `\begin{table}...\end{table}` (not bare tabulars).
- Use `\centering`; font size typically `\scriptsize` or `\footnotesize`.
- Booktabs single rules (`\toprule` / `\midrule` / `\bottomrule`) for all tables, regression tables included. (Doubled `\midrule \midrule` rules are a legacy Stata esttab default, not journal style.)
- Avoid column numbers unless strictly necessary.
- Align coefficients and SEs vertically; SEs always in parentheses below estimates.
- British English spelling throughout.
- Round **all** estimates, means, differences, and SEs to **3 decimal places**. An estimate with |value| < 0.0005 prints as `0.000` (plain rounding to zero); never inequality notation such as `<0.001` or `>-0.001`.
- P-values to 3 decimals, floored at `p<.001`; never printed as `0.000`. Same convention as the prose — coefficients may round to zero, p-values may not. Always state the test name and sidedness.
- **Formatting is fixed in the generating R script, not in the `.tex` file.** Route every number through shared `fmt_p()` and `fmt_est()` helpers in `Scripts/config_toolkit.R` so tables and prose cannot drift apart. (These helpers are not yet defined in this template — add them to `Scripts/config_toolkit.R` when you first need them, rather than re-implementing rounding in each analysis script.)
- Report figures at the **unit of the statistical test**; state that unit in the notes and do not mix aggregation levels within one table.
- Treatment names in column headers and row stubs need not be ALL CAPS — normal case ("Low stakes", "High stakes") is fine inside the table, even though running text always uses ALL CAPS (LOW, HIGH). Keep whichever form is chosen identical across all tables. Captions and notes are prose: use ALL CAPS there.

---

## Regression tables (parametric)
- Group columns by **design** (e.g. Stakes vs Matching).
- Subdivide by **outcome** (e.g. Hiding, Punishment).
- **Run the table as a single continuous block — no panels.** Coefficients appear in one uninterrupted sequence: treatments first, then interactions, then controls. Separate the groups with `\addlinespace` only; no panel title rows, no "Panel A" / "Panel B" headers.
- Order groups as treatments, then interactions, then controls, each group separated by `\addlinespace`.
- Treatments appear before interactions.
- Interactions explicitly labelled (e.g. `High stakes x Report`).
- Controls grouped and ordered logically (e.g. Male, Age, Order dummy).
- Fixed effects and sample size reported at the bottom.
- Avoid redundant labels like "Dependent variable:" or "Model:".

---

## Descriptive and non-parametric tables
- Report: N, Mean(s), exact p-values.
- Clearly distinguish paired vs unpaired tests.
- Hypothesis direction stated explicitly (e.g. HIGH < LOW).
- Panels reflect treatments or designs, not outcomes.
- Notes must define test statistics and interpretation of means.

---

## Balance and summary tables
- Group by treatment arms.
- Report overall column and joint test p-values.
- Avoid overprecision.
- Do not mix outcomes and covariates without clear separation.
- **Demographic balance does not need a table.** Where balance is unremarkable, report it in a footnote of the design/data section instead of an appendix table; keep the generating script and its `.tex` output either way, so the numbers stay reproducible.
- Describe cell sizes accurately: "approximately equal shares" unless assignment was hard-balanced by the software; verify against actual cell counts.

---

## Titles, notes and interpretation

- The caption is **usefully descriptive**: what is estimated or compared, for which sample, experiment, or specification.
- The caption is **authored LaTeX text, not inherited from the generating script.** Do not carry a script-name prefix into it (`Robustness:`, `Exploratory:`); and never let the script that made a table mislabel its role — a table that is the paper's main parametric evidence is not a "robustness" table just because `robustness.R` produced it. Name it for what it shows and the part it plays in the argument.
- **Notes always go in a `minipage` below the tabular**, in `\footnotesize`, as flowing text. Never as a `\multicolumn` row inside the tabular, and never inside cells. Same rule for figures (minipage below the graphic). This keeps note text from being stretched or wrapped by the column widths, and keeps line breaks under the paragraph's control rather than the table's.
- Do not use `threeparttable` for notes — the minipage form below is the house style, so all floats look identical.
- Always specify: test type, pairing structure, direction of comparison, sidedness, and the unit of observation.
- **A note must not contradict its own table.** Check every sample size, count and column claim in a note against the rows directly above it — a note that says $N = 295$ over an Observations row reading 279 is worse than no note. Notes are written once and rarely re-read against the numbers, so they rot silently while the table stays right.
- **Regression-table stars are two-sided; an inline p-value reports the test as pre-registered and run** (often one-sided for a directional interaction). Where the two collide — a one-sided claim drawn from a cell whose star is two-sided — do not re-star the table and do not change the inline p-value: add a note stating the stars are two-sided and that one-sided p-values for that row are in the main text.
- Keep notes as compact as possible while still self-explanatory to a reader who has only read the abstract: unit of observation, sample and conditioning, treatment abbreviations spelled out, test types, units (currency, percentage points).
- State only what the reader cannot infer — do not restate column headers, or symbols the facing page already defines. Self-explanatory ≠ self-contained.
- **State the fact and stop**; let the reader draw the consequence. Spell one out only where genuinely counter-intuitive.
- Note length scales with the table's **isolation, not its importance**: a table in running text stays terse; one in a tables-only appendix, reached by a bracketed cross-reference, earns a fuller note.
- Symbols in notes obey the paper's notation rules — one symbol, one meaning; never reuse a symbol already defined in the theory.

### Table template

```latex
\begin{table}[H]
    \centering
    \caption{Descriptive title: what is estimated, for which sample.}
    \label{tab:label}
    \footnotesize
    \input{Output/Tables/example_table.tex}  % tabular only -- no caption row, no notes row
    \begin{minipage}{0.8\linewidth}
        \footnotesize
        \textit{Notes:} Unit of observation, sample and conditioning, treatment
        abbreviations spelled out, test type and sidedness, units.
    \end{minipage}
\end{table}
```

---

## Export
- Use `save_table(content, filename)` from `Scripts/config_toolkit.R`.
- Output as `.tex` files to `LaTeX/Output/Tables/`.
- The generated `.tex` contains the **tabular only** — no caption, no notes. Captions and notes are written in the LaTeX file that `\input`s it, so the note is a minipage below the tabular rather than a row inside it.
- Suppress the table-generator's own note rows: `stargazer(..., notes = NULL)` and no `kableExtra::footnote()` / `add_footnote()` calls. These emit `\multicolumn` note rows inside the tabular, which is the form the house style forbids.
- No manual spacing hacks beyond `\addlinespace`.
- Same variable names and ordering across all tables.

---

## Provenance rule: R output → LaTeX

When a table in `LaTeX/` is a direct, unmodified `\input` of an R-generated `.tex` file, keep the `\input` line as-is.

**When you manually reformat or redesign an R-generated table for the paper**, you must:

1. **Inline** the new table content directly in the LaTeX file.
2. **Comment out** the original `\input` line immediately above the inlined table.

Example:
```latex
% \input{Output/Tables/balance_means_by_fee_level.tex}
\begin{table}[htbp]
... (reformatted table content) ...
\end{table}
```

This ensures any future agent or collaborator can trace numbers back to the R source and uncomment the `\input` to restore the raw version.

### Non-compiled sources for prose numbers

When a prose number is backed by a generated table that is **not** compiled into the paper, keep that table's `\input` in the LaTeX, commented out, with a bare `% source` marker on the line directly above:

```latex
% source
% \input{Output/Tables/hypothetical_performance.tex}
```

Un-comment to compile and check the numbers. `% source` is a bare flag, not a descriptive sentence — it only marks the commented line below as a source. It keeps every non-compiled source greppable, so an agent can be pointed on demand at every prose number quoting a non-compiled source. A check run when wanted, not a standing one.

### A cited table must contain the numbers it is cited for

When prose and a table disagree, fix the table — never soften the claim to match whatever the table happens to hold. The usual culprit is a table generated on every run but `\input` nowhere: the numbers exist, so the prose looks sourced, but the reader cannot reach them. Either compile the table or retarget the citation.

---

**Rule of thumb:** if a referee can reconstruct the empirical comparison from the table alone, it is JEBO-ready.
