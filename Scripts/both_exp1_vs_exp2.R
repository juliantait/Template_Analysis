# =============================================================================
# EXAMPLE — CROSS-STUDY COMPARISON SCRIPT (both_)
# =============================================================================
# This file is an EXAMPLE demonstrating the cross-study comparison convention.
# Copy it as a starting point, or delete it — it is not sourced by main.R and
# does nothing on its own.
#
# THE both_ PREFIX
#   A script that COMBINES or COMPARES results across studies takes the both_
#   prefix, naming the studies it spans:
#       both_exp1_vs_exp2.R      both_pilot_vs_main.R
#   This keeps cross-study work visually distinct from the single-study
#   analysis scripts (pilot_, exp1_, exp2_) and from the shared, unprefixed
#   config/helper scripts (config_init.R, config_cleaning.R, config_toolkit.R).
#
# WHEN IT EXISTS
#   Only once the repo holds more than one study AND you actually need to put
#   their results side by side (pooled estimates, exp1-vs-exp2 effect
#   comparisons, replication checks). A single-study repo has no both_ script.
#
# OUTPUT LAYOUT
#   Comparison outputs get their own subfolder so they collide with neither
#   study's:
#       LaTeX/Output/both/figures/   LaTeX/Output/both/tables/
#   (create it alongside the per-study folders when this script becomes real).
#
# WHAT BELONGS IN THIS FILE
#   Analysis that reads from more than one study — pooled models, exp1-vs-exp2
#   contrasts, side-by-side figures and tables — and the exported scalars the
#   comparison prose quotes.
# =============================================================================
cat("    -> [EXAMPLE] exp1-vs-exp2 comparison (not run by main.R)\n")
