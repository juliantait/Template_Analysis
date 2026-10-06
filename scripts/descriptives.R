# =============================================================================
# DESCRIPTIVE STATISTICS & KEY VALUES
# =============================================================================
# Compute summary statistics and key values referenced in the paper.
# Each quoted number is registered with save_value(name, value) and lands in
# the one values file LaTeX/output/values.{tex,json}, written by write_values()
# at the end of main.R. In LaTeX: \val{name}.
# =============================================================================
cat("    -> Computing descriptive statistics\n")

# --- EXAMPLE VALUES ----------------------------------------------------------
# Format through fmt_est() / fmt_p() before saving; counts can be saved as-is.
# save_value("mean_outcome", fmt_est(mean(data$outcome, na.rm = TRUE)))
# save_value("share_female_pct", round(100 * mean(data$female, na.rm = TRUE)))
