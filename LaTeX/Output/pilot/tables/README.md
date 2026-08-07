# Per-study output folder — `pilot/tables/`

This folder demonstrates the **per-study output layout**. It exists because,
once a repo holds more than one study or wave, each study writes its outputs
into its **own** `Output/<study>/` subfolder so results never collide.

- Tables for the **pilot** study land here: `LaTeX/Output/pilot/tables/`.
- Figures land in the sibling `LaTeX/Output/pilot/figures/`.
- Experiment 1 would use `LaTeX/Output/exp1/tables/` and `.../exp1/figures/`;
  cross-study (`both_`) outputs would use `LaTeX/Output/both/...`.

A study's prefixed script (`pilot_descriptives.R`, `exp1_hypotheses.R`, ...)
points its `save_graph` / `save_table` / `save_text` calls at its own
subfolder here. Generated `.tex` files hold the **tabular only**; the caption
and notes live in the LaTeX file that `\input`s them.

**Single-study projects don't need this.** The template ships with the flat
`Output/Figures`, `Output/Tables`, `Output/Text` layout, which is correct for
one study. Adopt this nested per-study layout only when a second study or wave
enters the same repo. This `pilot/` tree is an example — copy the pattern for
real studies, or delete it if you stay single-study.
