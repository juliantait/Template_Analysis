# Helper/otree.R — oTree data-source adapter
# Reads oTree session CSVs (wide format, one row per participant) and reshapes
# to long format (one row per participant × app × round).
#
# Called by Scripts/config_cleaning.R when data_source <- "otree".
# Edit the configuration below to match your experiment.

# === oTree APP CONFIGURATION ===
# oTree experiments consist of apps that run in sequence. Each app generates
# columns named:  {app_name}.{round}.{field}   e.g. "main_task.3.player.decision"
#
# Define each app you want to extract data from. Each app specifies:
#   rounds    — number of rounds in that app
#   variables — named vector mapping analysis_name = "field.suffix"
#               (the part after {app}.{round}.)

apps <- list(

  main_task = list(
    rounds = 20,
    variables = c(
      # decision = "player.decision",
      # payoff   = "group.payoff"
    )
  )

  # questionnaire = list(
  #   rounds = 1,
  #   variables = c(
  #     risk = "player.risk_preference"
  #   )
  # ),

  # real_effort = list(
  #   rounds = 5,
  #   variables = c(
  #     correct  = "player.correct_answers",
  #     earnings = "player.task_earnings"
  #   )
  # )

)

# === PARTICIPANT-LEVEL VARIABLES ===
# These do NOT vary across rounds. Includes participant.* and outro.* columns.
# Map: analysis_name = "oTree.column.name"
constant_variables <- c(
  participant_id = "participant.code",
  session        = "participant.session"
  # treatment    = "participant.treatment_group",
  # gender       = "outro.1.player.gender",
  # age          = "outro.1.player.age"
)

# === SESSION FILES ===
# Leave empty to auto-detect all CSVs in the data subfolder.
file_names <- c()

# === COLUMNS TO DROP ===
# Columns to drop from raw oTree output (e.g. bank details, internal config)
columns_to_remove <- c(
  # "session.config.participation_fee",
  # "participant.counter"
)


# =============================================================================
# load_data(subfolder)
# Reads oTree CSVs, stacks sessions, reshapes wide → long.
# Returns a data.frame with one row per participant × app × round.
# =============================================================================

load_data <- function(subfolder) {

  # --- Auto-detect session files if none specified ---
  if (length(file_names) == 0) {
    detected <- sub("\\.csv$", "", list.files(subfolder, pattern = "\\.csv$"))
    if (length(detected) == 0) stop("No CSV files found in ", subfolder)
  } else {
    detected <- file_names
  }

  # --- Read and stack session CSVs ---
  remove_columns <- function(df, cols) df %>% select(-any_of(cols))

  data_list <- list()
  for (file in detected) {
    file_path <- paste0(subfolder, file, ".csv")
    raw <- read_csv(file_path, show_col_types = FALSE)
    raw$participant.session <- file
    raw <- remove_columns(raw, columns_to_remove)
    data_list[[file]] <- raw
  }

  # Align columns across sessions (missing columns → NA)
  all_cols <- Reduce(union, lapply(data_list, names))
  data_list <- lapply(data_list, function(df) {
    missing <- setdiff(all_cols, names(df))
    if (length(missing) > 0) df[missing] <- NA
    df[, all_cols, drop = FALSE]
  })

  data <- do.call(rbind, data_list)

  # --- Reshape: one row per participant × app × round ---
  all_data <- lapply(names(apps), function(app_name) {
    app <- apps[[app_name]]
    lapply(seq_len(app$rounds), function(round_num) {
      round_data <- list(
        app   = rep(app_name, nrow(data)),
        round = rep(round_num, nrow(data))
      )
      # App-specific round variables
      for (var in names(app$variables)) {
        col <- paste0(app_name, ".", round_num, ".", app$variables[var])
        round_data[[var]] <- if (col %in% names(data)) data[[col]] else NA
      }
      # Constant variables (same for all apps/rounds)
      for (var in names(constant_variables)) {
        col <- constant_variables[var]
        round_data[[var]] <- if (col %in% names(data)) data[[col]] else NA
      }
      as.data.frame(round_data, stringsAsFactors = FALSE)
    })
  })

  bind_rows(unlist(all_data, recursive = FALSE))
}
