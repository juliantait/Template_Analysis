# Project conventions

This file is here for anyone using Claude Code (or another AI assistant) inside this template. It is short on purpose — the template is designed to be used manually first, with AI as an optional helper.

## Style references

Two reference documents live in `Flow/Tools/`:

- `Flow/Tools/skill_graphs.md` — JEBO publication-ready figure conventions used across this project.
- `Flow/Tools/skill_tables.md` — JEBO publication-ready table conventions.

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

## Reporting conventions

These apply to every script, table, figure note, and line of prose. They are the house style; do not relax them per-analysis.

### Numbers

- **P-values**: 3 decimals, floored at `p<.001`; never printed as `.000`. The same format holds in prose, footnotes, float notes, and script-generated tables. Always state the test name and whether it is one- or two-sided.
- **Estimates**: 3 decimals. An estimate with |value| < 0.0005 prints as `0.000` by plain rounding — never inequality notation such as `<0.001` or `>-0.001`. Coefficients may round to zero; p-values may not.
- **Fix formatting in the generating R script**, never by patching the `.tex` it produced. Route numbers through shared `fmt_p()` and `fmt_est()` helpers in `Scripts/config_toolkit.R` so tables and prose cannot drift apart. These helpers are not yet defined in this template — add them there when first needed, rather than re-implementing rounding in each script.
- **Aggregation unit**: report at the unit of the statistical test. Never mix observation-level and group-level aggregation within one paragraph or one table.
- **Every scalar quoted in the paper is computed by a script** and exported via `save_text()` — the `OutputValues` pattern in `Scripts/descriptives.R` writing to `LaTeX/Output/Text/`. Never hand-derive or eyeball a number, including in the abstract, footnotes, and float notes. Re-check all quoted scalars after any re-run.
- **Inline reporting carries p-values, not raw estimates.** Running text gives the p-value, the test name, and sidedness where that is not already obvious. The test is not where the number came from but what the number is doing in the sentence: *is this number doing interpretive work here, or is it a raw estimate quoted as a credential?* **Banned** — raw model output quoted in brackets as a credential: `\hat{\beta} = 3.091`, `coefficient = 0.018`, `R^2 = 0.224`, standard errors. Those add nothing at the point of the claim and belong in the tables, which is what the tables are for; a raw estimate quoted in prose duplicates a table cell and the two drift apart. **Kept** — a magnitude written out in words, in units that mean something to the reader: `42 percentage points`, `roughly three dots larger`, `virtually unchanged`, `triple`, `about a third`. Those *are* the finding stated in human terms, and a paper is worse without them. Two exceptions: **correlations** keep their statistic inline (`Spearman rho = -0.231, p = .006`), because a correlation usually has no table and the sign and magnitude are the result; and **descriptive means, shares and percentages** stay in prose (`49% versus 38% (p = .035, one-sided)`), because those are results rather than model output. Before: `the interaction reaches significance (\hat{\beta}_3 = 3.091, p = .044)`. After: `the interaction reaches significance (p = .044, one-sided)`.
- **Correlations**: state Pearson or Spearman, and the unit of observation. Use the independent unit (e.g. participant, not participant × block).

### Notation and naming

- **One symbol, one meaning.** Never reuse a symbol across concepts. When notation changes, grep the whole `LaTeX/` tree for stale variants, including function arguments and sub/superscripts.
- **Treatment names are ALL CAPS in running text** (LOW, HIGH, PARTNERS, STRANGERS), at every mention. Inside figures and tables — axis labels, legends, column headers, row stubs — normal case is fine. Captions and notes count as prose: ALL CAPS there.

### Colour

- A binary treatment contrast uses the **same two colours paper-wide**, whatever the dimension: `palette_lots[1]` (dark blue) for the first/left group in the contrast, `palette_lots[2]` (pink-red) for the second/right.
- The mapping is **by position in the contrast, not by treatment name**, so the reader learns one visual code. Fix the factor level order once in cleaning so it cannot drift between scripts.
- **Single-colour fills are reserved for non-treatment x-axes** (scenario categories, belief histograms, pooled distributions).

### Captions and notes

- Captions are **usefully descriptive**: what is estimated or plotted, and for which sample or specification. Not "Treatment effects".
- Notes are as compact as possible while still self-explanatory to a reader who has only read the abstract: unit of observation, sample and conditioning, treatment abbreviations spelled out, what error bars show, test type and sidedness, units.
- State only what the reader cannot already infer — do not restate an axis label or a symbol the facing page defines. **State the fact and stop**; let the reader draw the consequence, spelling one out only where genuinely counter-intuitive.
- Note length scales with the float's **isolation, not its importance**: a float in running text leans on adjacent prose and stays terse; one parked in a figures-only or tables-only appendix earns a fuller note.
- **Notes always sit in a `minipage` below the tabular or graphic**, `\footnotesize`, flowing text — never a `\multicolumn` row inside the tabular.
- Generated `.tex` files hold the **tabular only**. Caption and notes are written in the LaTeX file that `\input`s them.

Full detail lives in `Flow/Tools/skill_graphs.md` and `Flow/Tools/skill_tables.md`; running lessons behind these rules are in `lessons_from_mistakes_paper.md`.
