# Config toolkit: packages, themes, colour palette, save functions, helpers
cat("  -> Toolkit (packages, theme, save functions)\n")

# --- PACKAGES ---------------------------------------------------------------

# Helper: install if missing
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
}

# Core
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)

# Plotting
library(cowplot)
library(patchwork)
install_if_missing("showtext")
library(showtext)

# Statistical tests
library(coin)
install_if_missing("fixest")
library(fixest)
install_if_missing("lmtest")
library(lmtest)
install_if_missing("sandwich")
library(sandwich)

# Tables
library(stargazer)
library(knitr)
library(kableExtra)
library(xtable)

# --- COLOUR PALETTE ----------------------------------------------------------
palette_lots <- c(
  "#4477AA",  # Dark blue
  "#EE6677",  # Pink-red
  "#228833",  # Dark green
  "#AA3377",  # Purple
  "#66CCEE",  # Cyan
  "#D55E00",  # Orange-red
  "#004488"   # Very dark blue
)

# --- GGPLOT THEME ------------------------------------------------------------
common_theme <- theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold",
                              family = "", margin = margin(b = 10)),
    axis.title = element_text(size = 14),
    axis.text  = element_text(size = 14, colour = "black"),
    panel.grid.major   = element_line(colour = "grey95", linewidth = 0.3),
    panel.grid.minor   = element_blank(),
    panel.grid.major.x = element_blank(),
    axis.line  = element_line(colour = "grey30", linewidth = 0.6),
    axis.ticks = element_line(colour = "grey30", linewidth = 0.6),
    legend.position  = "bottom",
    legend.direction = "horizontal",
    legend.box       = "horizontal",
    legend.margin    = margin(t = 5),
    legend.text      = element_text(size = 14),
    legend.title     = element_blank(),
    strip.text       = element_text(size = 14, face = "bold"),
    strip.background = element_blank()
  )

# --- SAVE FUNCTIONS ----------------------------------------------------------
# Each function writes to ALL paths in output_paths (local + sync destinations).
output_paths <- c(OUTPUT_ROOT, SYNC_DESTINATIONS)

save_graph <- function(plot, filename, width = 10, height = 6, dpi = 300) {
  for (path in output_paths) {
    dir.create(file.path(path, "figures"), recursive = TRUE, showWarnings = FALSE)
    ggsave(file.path(path, "figures", paste0(filename, ".png")),
           plot = plot, width = width, height = height, dpi = dpi)
  }
}

save_table <- function(content, filename) {
  for (path in output_paths) {
    dir.create(file.path(path, "tables"), recursive = TRUE, showWarnings = FALSE)
    writeLines(content, file.path(path, "tables", paste0(filename, ".tex")))
  }
}

# --- VALUES FILE (scalars quoted in the paper) --------------------------------
# Every scalar the paper quotes goes into ONE generated file, not one file per
# number: LaTeX/output/values.tex (\setval{name}{value} lines, \input by
# LaTeX/values_macros.tex) plus LaTeX/output/values.json (same map, for humans,
# agents and diffs). Both are sorted by name, so a re-run diff shows exactly
# which numbers changed.
#
#   save_value("h1_p", fmt_p(test$p.value))   # register during the run
#   write_values()                            # write once, at the end
#
# Merge rule: write_values() reads the existing values.json, overlays this
# session's registry, and writes the union. A standalone script (run after
# load_checkpoint()) therefore only updates its own scalars and never drops
# those of scripts that did not run. main.R calls write_values(replace = TRUE)
# after a full run, which writes the registry alone and so prunes scalars that
# were renamed or deleted; until then they linger in the file.
.values_env <- new.env(parent = emptyenv())
.values_env$values <- character(0)

save_value <- function(name, value) {
  if (!is.character(name) || length(name) != 1 || !grepl("^[A-Za-z0-9_]+$", name)) {
    stop(sprintf("save_value(): name '%s' is invalid; use only letters, digits and _ (e.g. 'h1_p_low_high').",
                 paste(name, collapse = " ")), call. = FALSE)
  }
  if (length(value) != 1 || is.na(value)) {
    stop(sprintf("save_value('%s'): value must be a single non-missing value.", name), call. = FALSE)
  }
  if (is.numeric(value)) {
    # Counts pass through; anything with decimals must be formatted first.
    if (value != round(value)) {
      stop(sprintf("save_value('%s'): %s has decimals; format it with fmt_est() or fmt_p() before saving.",
                   name, format(value, digits = 10)), call. = FALSE)
    }
    value <- format(value, scientific = FALSE, trim = TRUE, big.mark = "")
  }
  value <- as.character(value)
  old <- .values_env$values[name]
  if (!is.na(old) && old != value) {
    stop(sprintf("save_value('%s'): already saved this run as '%s', now '%s'. Use a different name.",
                 name, old, value), call. = FALSE)
  }
  .values_env$values[name] <- value
  invisible(value)
}

# Legacy wrapper: old scripts that call save_text(text, filename) still work.
# The text (lines collapsed with spaces) becomes the value; the filename the name.
save_text <- function(text, filename) {
  name <- gsub("[^A-Za-z0-9_]", "_", filename)
  if (name != filename) message(sprintf("save_text(): saving '%s' as value '%s'.", filename, name))
  save_value(name, paste(text, collapse = " "))
}

# Escape LaTeX special characters one character at a time (single pass, so a
# replacement is never re-escaped).
latex_escape <- function(x) {
  map <- c("\\" = "\\textbackslash{}", "&" = "\\&", "%" = "\\%", "$" = "\\$",
           "#" = "\\#", "_" = "\\_", "{" = "\\{", "}" = "\\}",
           "~" = "\\textasciitilde{}", "^" = "\\textasciicircum{}")
  vapply(strsplit(x, ""), function(chars) {
    hit <- chars %in% names(map)
    chars[hit] <- map[chars[hit]]
    paste(chars, collapse = "")
  }, character(1), USE.NAMES = FALSE)
}

# Write only when the bytes differ, so an unchanged file keeps its timestamp
# (no needless iCloud/Overleaf re-sync).
write_if_changed <- function(lines, file) {
  if (file.exists(file) && identical(readLines(file, warn = FALSE), lines)) return(FALSE)
  writeLines(lines, file)
  TRUE
}

write_values <- function(replace = FALSE) {
  vals <- .values_env$values
  json_file <- file.path(OUTPUT_ROOT, "values.json")
  if (!replace && file.exists(json_file)) {
    existing <- unlist(jsonlite::read_json(json_file))
    existing <- existing[setdiff(names(existing), names(vals))]
    vals <- c(vals, existing)
  }
  if (length(vals) > 0) vals <- vals[order(names(vals), method = "radix")]  # locale-independent order
  tex <- c("% Generated by write_values() in scripts/config_toolkit.R. Do not edit by hand.",
           sprintf("\\setval{%s}{%s}", names(vals), latex_escape(vals)))
  json <- strsplit(as.character(jsonlite::toJSON(as.list(vals), auto_unbox = TRUE,
                                                 pretty = TRUE)), "\n")[[1]]
  if (length(vals) == 0) json <- "{}"
  for (path in output_paths) {
    dir.create(path, recursive = TRUE, showWarnings = FALSE)
    write_if_changed(tex,  file.path(path, "values.tex"))
    write_if_changed(json, file.path(path, "values.json"))
  }
  cat(sprintf("  -> Values file: %d scalars (%d from this run)%s\n", length(vals),
              length(.values_env$values), if (replace) ", replaced" else ", merged"))
  invisible(vals)
}

# --- CHECKPOINT --------------------------------------------------------------
checkpoint_path <- file.path(getwd(), "data", "checkpoint_prepared.RData")

save_checkpoint <- function(envir = parent.frame()) {
  save(list = ls(envir = envir), file = checkpoint_path, envir = envir)
  cat(sprintf("  -> Checkpoint saved: %s\n", checkpoint_path))
}

load_checkpoint <- function(envir = parent.frame()) {
  if (!file.exists(checkpoint_path)) {
    stop("No checkpoint found. Run the full pipeline (main.R) first.")
  }
  load(checkpoint_path, envir = envir)
  cat(sprintf("  -> Checkpoint loaded: %s\n", checkpoint_path))
}

# --- HELPERS -----------------------------------------------------------------
# Number formatting: the ONE place rounding is defined. Tables and values both
# go through these, so table cells and prose cannot drift apart.
# fmt_est(): 3 decimals, plain rounding; |x| < 0.0005 prints 0.000 (never -0.000).
fmt_est <- function(x, digits = 3) {
  x <- round(x, digits)
  x[!is.na(x) & x == 0] <- 0
  ifelse(is.na(x), NA_character_, formatC(x, format = "f", digits = digits))
}

# fmt_p(): 3 decimals, no leading zero, floored at <.001 (never .000).
# with_p = TRUE gives prose form: "p = .044" / "p<.001".
fmt_p <- function(p, with_p = FALSE) {
  out <- ifelse(p < 0.001, "<.001", sub("^0", "", formatC(round(p, 3), format = "f", digits = 3)))
  if (with_p) out <- ifelse(p < 0.001, "p<.001", paste("p =", out))
  ifelse(is.na(p), NA_character_, out)
}

p_to_stars <- function(p) {
  ifelse(p < 0.001, "***", ifelse(p < 0.01, "**", ifelse(p < 0.05, "*", ifelse(p < 0.1, "+", ""))))
}

# --- GLOBAL OPTIONS ----------------------------------------------------------
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE)
se_plot <- 1.0
options(warn = -1)
