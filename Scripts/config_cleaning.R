# config_cleaning.R
# Orchestrator: loads raw data via Data/DataSets/cleaning.R, generates derived
# variables, and saves cleaned dataset(s) to Data/.
# Run once when starting analysis, then comment out in main.R.

cat("  -> Cleaning: combining and cleaning datasets\n")

if (!exists("OUTPUT_ROOT")) source("Scripts/config_init.R")

library(readr)
library(tidyr)
library(dplyr)
library(stringr)

# Source the cleaning function
source("Data/DataSets/cleaning.R")

# === SESSION CONFIGURATION ===
# List the session files to include (without .csv extension)
# Example: file_names <- c("Session_01", "Session_02", "Session_03")
file_names <- c()

# Auto-detect if no sessions specified
if (length(file_names) == 0) {
  file_names <- sub("\\.csv$", "", list.files("Data/DataSets", pattern = "\\.csv$"))
}
if (length(file_names) == 0) stop("No CSV files found in Data/DataSets/")

# === OTREE VARIABLE MAPPINGS ===
# Map analysis variable names (left) to oTree column names (right)

constant_variables <- c(
  participant_id = "participant.code",
  session        = "participant.session"
  # treatment    = "participant.treatment_group",
  # gender       = "outro.1.player.gender",
  # age          = "outro.1.player.age"
)

variables_to_export <- c(
  # "analysis_name" = "player.otree_column_name"
  # mistake  = "player.mistake",
  # report   = "player.report",
  # payoff   = "group.payoff"
)

main_list <- c("main1")

# === LOAD AND RESHAPE ===
data <- clean_data(
  working_directory    = getwd(),
  subfolder            = "Data/DataSets/",
  file_names           = file_names,
  constant_variables   = constant_variables,
  variables_to_export  = variables_to_export,
  main_list            = main_list,
  output_file          = "Data/compiled.Rdata"
)

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
