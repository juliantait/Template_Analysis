# =============================================================================
# SAMPLE RESTRICTIONS
# =============================================================================
# Apply exclusion criteria, filters, and subsetting.
# This runs AFTER variable generation so derived variables are available.
# =============================================================================
cat("    -> Applying sample restrictions\n")

# --- EXCLUSION CRITERIA ------------------------------------------------------
# Example: drop participants who failed comprehension checks
# data <- data %>% filter(comprehension_passed == TRUE)

# Example: age restriction for robustness
# data <- data %>% filter(age < 40)

# Example: restrict to specific treatment arms
# data <- data %>% filter(matched == 0)

# --- REPORT SAMPLE SIZE -----------------------------------------------------
cat(sprintf("    -> Final sample: %d observations, %d unique participants\n",
            nrow(data),
            length(unique(data$participant_id))))
