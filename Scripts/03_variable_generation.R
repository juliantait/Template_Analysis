# =============================================================================
# VARIABLE GENERATION
# =============================================================================
# Create derived/computed variables from the cleaned data.
# This script assumes 'data' exists in the environment from 02_cleaning.R.
# =============================================================================
cat("    -> Generating variables\n")

# --- DERIVED VARIABLES -------------------------------------------------------
# Example: create composite scores, indicators, treatment assignments
#
# data$outcome_total <- data$outcome_a + data$outcome_b
# data$treated <- ifelse(data$treatment == "treatment", 1, 0)

# --- TREATMENT ASSIGNMENT FROM ROUND 1 --------------------------------------
# Example: extract treatment from first observation per participant
#
# treatment_r1 <- data %>%
#   filter(round == 1) %>%
#   select(participant_id, treatment_var) %>%
#   rename(treatment_assigned = treatment_var)
#
# data <- data %>%
#   left_join(treatment_r1, by = "participant_id")

# --- MERGE AUXILIARY VARIABLES -----------------------------------------------
# Example: merge in group-level attributes (e.g., leader characteristics)
#
# leader_lookup <- data %>%
#   filter(role == "leader") %>%
#   select(round, group_id, age, gender) %>%
#   rename(leader_age = age, leader_gender = gender) %>%
#   distinct()
#
# data <- data %>%
#   left_join(leader_lookup, by = c("round", "group_id"))
