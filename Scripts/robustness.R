# =============================================================================
# ROBUSTNESS CHECKS
# =============================================================================
# Purpose: Confirm or challenge the PRIMARY FINDINGS from hypotheses.R.
#
# Every analysis here must be directly tied to a result in hypotheses.R.
# The question is: "Does the main result hold (or break) under a different
# specification?" This includes alternative controls, clustering, placebo
# tests, subsample stability, and sensitivity to exclusion criteria.
#
# If an analysis does not speak to an existing finding, it does NOT belong
# here. New questions suggested by the data go in exploratory.R. Analyses
# that are interesting but won't appear in the paper go in Further Analysis/.
#
# Output: Tables to Tables/, Graphs to Graphs/
# =============================================================================
cat("    -> Running robustness checks\n")

# --- REGRESSIONS -------------------------------------------------------------
# Example: Fixed effects with clustered SE (fixest)
#
# reg1 <- feols(outcome ~ treatment | participant_id,
#               data = data, cluster = ~group_id)
#
# reg2 <- feols(outcome ~ treatment + age + male | participant_id,
#               data = data, cluster = ~group_id)

# --- EXPORT REGRESSION TABLE ------------------------------------------------
# tex_output <- capture.output(
#   etable(reg1, reg2,
#          tex = TRUE,
#          style.tex = style.tex("aer"),
#          fitstat = ~ n + r2)
# )
# save_table(tex_output, "robustness_regressions")
