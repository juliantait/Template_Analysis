# config_cleaning.R
# Orchestrator: loads raw data via a data-source adapter in Helper/,
# generates derived variables, and saves cleaned dataset(s) to Data/.
# Run once when starting analysis, then comment out in main.R.

cat("  -> Cleaning: combining and cleaning datasets\n")

if (!exists("OUTPUT_ROOT")) source("Scripts/config_init.R")

library(readr)
library(tidyr)
library(dplyr)
library(stringr)

# === DATA SOURCE ===
# Set to "otree" or "csv" to select the adapter in Helper/.
data_source <- "otree"

source(paste0("Helper/", data_source, ".R"))

# === LOAD AND RESHAPE ===
data <- load_data(subfolder = "Data/DataSets/")

# === VARIABLE GENERATION ===
# Create derived variables here. Examples:
#
# data$block <- ifelse(data$round <= 10, 1L, 2L)
# data$treated <- ifelse(data$treatment == "treatment", 1, 0)
# data$male <- ifelse(data$gender == "Male", 1, ifelse(data$gender == "Female", 0, NA))

# === SAVE CLEANED DATA ===
save(data, file = "Data/data_cleaned.RData", compress = FALSE)
write.csv(data, "Data/data_cleaned.csv", row.names = FALSE)

cat(sprintf("  -> Saved: data_cleaned (%d observations)\n", nrow(data)))
