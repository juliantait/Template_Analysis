# =============================================================================
# EXAMPLE — STUDY-PREFIXED SCRIPT (pilot_)
# =============================================================================
# This file is an EXAMPLE demonstrating the study-prefix convention. Copy it as
# a starting point for a real pilot script, or delete it — it is not sourced by
# main.R and does nothing on its own.
#
# WHEN TO USE PREFIXES
#   Adopt study prefixes only once this repo holds MORE THAN ONE study or wave
#   (a pilot plus a main experiment, exp1 plus exp2, several data-collection
#   waves). With a single study, keep the plain unprefixed names already in
#   Scripts/ (descriptives.R, hypotheses.R, ...) — do not prefix prematurely.
#
# THE PREFIX RULE
#   - Analysis scripts take the prefix of the study they belong to:
#       pilot_   exp1_   exp2_   wave1_   ...
#     e.g. pilot_descriptives.R, exp1_hypotheses.R, exp2_balance_table.R.
#   - Cross-study comparisons take the both_ prefix:
#       both_exp1_vs_exp2.R
#   - Shared config and helper scripts stay UNPREFIXED because every study
#     sources them: config_init.R, config_cleaning.R, config_toolkit.R.
#
# OUTPUT LAYOUT (keep studies from colliding)
#   Each study writes into its OWN Output subfolder so results never overwrite
#   one another:
#       LaTeX/Output/pilot/figures/   LaTeX/Output/pilot/tables/
#       LaTeX/Output/exp1/figures/    LaTeX/Output/exp1/tables/
#   Point the study's save_graph / save_table / save_text calls at its own
#   subfolder. See LaTeX/Output/pilot/*/README.md for that convention.
#
# WHAT BELONGS IN THIS FILE
#   Descriptive statistics and key values for the PILOT study only: sample
#   sizes, summary means and shares, and the OutputValues exports the pilot
#   write-up quotes. Mirror the structure of the unprefixed descriptives.R.
# =============================================================================
cat("    -> [EXAMPLE] pilot descriptive statistics (not run by main.R)\n")
