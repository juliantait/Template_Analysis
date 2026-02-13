# =============================================================================
# ROBUSTNESS CHECKS
# =============================================================================
# Regression-based robustness checks with clustered standard errors.
# Output: Tables to Tables/
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
