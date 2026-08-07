# =============================================================================
# EXAMPLE — STUDY-PREFIXED SCRIPT (exp1_)
# =============================================================================
# This file is an EXAMPLE demonstrating the study-prefix convention. Copy it as
# a starting point for a real experiment-1 script, or delete it — it is not
# sourced by main.R and does nothing on its own.
#
# WHEN TO USE PREFIXES
#   Adopt study prefixes only once this repo holds MORE THAN ONE study or wave.
#   With a single study, keep the plain unprefixed names already in Scripts/
#   (hypotheses.R, ...) — do not prefix prematurely.
#
# THE PREFIX RULE
#   - Analysis scripts take the prefix of the study they belong to:
#       pilot_   exp1_   exp2_   wave1_   ...
#     e.g. exp1_hypotheses.R, exp1_balance_table.R, exp1_descriptives.R.
#   - Cross-study comparisons take the both_ prefix (both_exp1_vs_exp2.R).
#   - Shared config and helper scripts stay UNPREFIXED because every study
#     sources them: config_init.R, config_cleaning.R, config_toolkit.R.
#
# OUTPUT LAYOUT (keep studies from colliding)
#   exp1 writes into its OWN Output subfolder:
#       LaTeX/Output/exp1/figures/   LaTeX/Output/exp1/tables/
#   so its results never overwrite the pilot's. Point this study's
#   save_graph / save_table / save_text calls at its own subfolder.
#
# WHAT BELONGS IN THIS FILE
#   The pre-registered hypothesis tests for EXPERIMENT 1 only, and the figures,
#   tables, and exported scalars backing exp1's results section. Mirror the
#   structure of the unprefixed hypotheses.R.
# =============================================================================
cat("    -> [EXAMPLE] exp1 hypothesis tests (not run by main.R)\n")
