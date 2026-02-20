# =============================================================================
# HYPOTHESIS TESTS
# =============================================================================
# Main pre-registered hypothesis tests.
# Output: Graphs to Graphs/, Tables to Tables/, Text to Text/
# =============================================================================
cat("    -> Running hypothesis tests\n")

# --- HYPOTHESIS 1 ------------------------------------------------------------
# Description:
# Test:
# Example:
# wilcox_h1 <- wilcox.test(outcome ~ treatment, data = subset_data, paired = TRUE)

# --- HYPOTHESIS 2 ------------------------------------------------------------
# Description:
# Test:

# --- HYPOTHESIS 3 ------------------------------------------------------------
# Description:
# Test:

# --- HYPOTHESIS 4 ------------------------------------------------------------
# Description:
# Test:

# --- GRAPHS ------------------------------------------------------------------
# Example:
# p_h1 <- ggplot(plot_data, aes(x = group, y = outcome, fill = group)) +
#   geom_bar(stat = "identity") +
#   common_theme +
#   scale_fill_manual(values = palette2)
#
# save_graph(p_h1, "hypothesis_1")

# --- EXPORT RESULTS ---------------------------------------------------------
# h_results <- c(
#   sprintf("H1 p-value: %.3f", wilcox_h1$p.value)
# )
# save_text(h_results, "hypothesis_tests")
