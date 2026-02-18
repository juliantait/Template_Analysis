# =============================================================================
# EXPLORATORY ANALYSES
# =============================================================================
# Exploratory analyses not covered by pre-registration.
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
