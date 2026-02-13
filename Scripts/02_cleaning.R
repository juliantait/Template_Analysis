# =============================================================================
# DATA CLEANING
# =============================================================================
# Load raw/cleaned data and perform basic cleaning:
#   - NA handling
#   - Type coercion
#   - Recoding
# =============================================================================
cat("    -> Cleaning data\n")

# --- LOAD DATA ---------------------------------------------------------------
# Option A: Load .RData
# load("Data/data_cleaned.RData")  # loads object named 'data'

# Option B: Load .csv
# data <- read_csv("Data/data_cleaned.csv")

# --- CLEAN -------------------------------------------------------------------
# Replace NAs, fix types, recode as needed
# Example:
# data$var <- ifelse(is.na(data$var), 0, data$var)
# data$factor_var <- factor(data$factor_var, levels = c("low", "high"))
