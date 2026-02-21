# =============================================================================
# EXPLORATORY ANALYSES
# =============================================================================
# Purpose: Interesting research that goes BEYOND the hypotheses.
#
# These are new questions suggested by the data — not tests of the primary
# results. They may appear in the main text or appendix but are clearly
# labelled as exploratory. This includes subgroup heterogeneity, mechanism
# analyses, learning effects, additional outcomes, and data-driven patterns.
#
# If an exploratory analysis turns out to support or challenge a primary
# finding, consider moving it to robustness.R instead.
#
# If an analysis is interesting but won't appear in the paper, it belongs
# in Further Analysis/ (and gets a write-up in app_further.tex).
#
# Output: Graphs to Graphs/, Tables to Tables/
# =============================================================================
cat("    -> Running exploratory analyses\n")

# --- LEARNING EFFECTS --------------------------------------------------------
# Example: outcome by round
#
# learning_data <- data %>%
#   group_by(round) %>%
#   summarise(
#     mean_outcome = mean(outcome, na.rm = TRUE),
#     se_outcome   = sd(outcome, na.rm = TRUE) / sqrt(n()),
#     .groups = "drop"
#   )

# --- SUBGROUP ANALYSES -------------------------------------------------------
# Example: effects by gender, role, etc.

# --- GRAPHS ------------------------------------------------------------------
# Example:
# p_learning <- ggplot(learning_data, aes(x = round, y = mean_outcome)) +
#   geom_line(colour = palette1, linewidth = 0.8) +
#   geom_errorbar(aes(ymin = mean_outcome - se_plot * se_outcome,
#                     ymax = mean_outcome + se_plot * se_outcome),
#                 width = 0.3) +
#   common_theme +
#   labs(x = "Round", y = "Outcome")
#
# save_graph(p_learning, "exploratory_learning")
