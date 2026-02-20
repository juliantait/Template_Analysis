# =============================================================================
# BALANCE TABLE
# =============================================================================
# Check randomisation balance across treatment groups.
# Output: LaTeX table to Tables/
# =============================================================================
cat("    -> Creating balance table\n")

# --- BALANCE TABLE -----------------------------------------------------------
# Example structure:
#
# balance_data <- data %>%
#   filter(round == 1) %>%
#   group_by(treatment_group) %>%
#   summarise(
#     N           = n(),
#     Female_pct  = mean(female, na.rm = TRUE) * 100,
#     Age_mean    = mean(age, na.rm = TRUE),
#     .groups     = "drop"
#   )

# --- STATISTICAL TESTS -------------------------------------------------------
# Example: chi-square for categorical, t-test for continuous
#
# chisq.test(table(data_r1$treatment_group, data_r1$female))
# t.test(age ~ treatment_group, data = data_r1)

# --- EXPORT TABLE ------------------------------------------------------------
# balance_tex <- kable(balance_data, format = "latex", booktabs = TRUE,
#                      caption = "Balance across treatment groups")
# save_table(balance_tex, "balance_table")
