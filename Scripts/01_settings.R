# =============================================================================
# SETTINGS
# =============================================================================
# Colour palette, ggplot theme, output path functions, and global variables.
# =============================================================================
cat("  -> Loading settings\n")

# --- OUTPUT PATHS ------------------------------------------------------------
# Vector of output destinations. Add paths to write to multiple locations.
# If only one path is specified, output goes there only.
# Example: add an Overleaf sync folder as a second element.
output_paths <- c(
  file.path(getwd(), "Output")
  # "/path/to/Overleaf/project/Output"
)

# --- SAVE FUNCTIONS ----------------------------------------------------------
# Each function writes to ALL paths in output_paths.

save_graph <- function(plot, filename, width = 10, height = 6, dpi = 300) {
  for (path in output_paths) {
    dir.create(file.path(path, "Graphs"), recursive = TRUE, showWarnings = FALSE)
    ggsave(file.path(path, "Graphs", paste0(filename, ".png")),
           plot = plot, width = width, height = height, dpi = dpi)
  }
}

save_table <- function(content, filename) {
  for (path in output_paths) {
    dir.create(file.path(path, "Tables"), recursive = TRUE, showWarnings = FALSE)
    writeLines(content, file.path(path, "Tables", paste0(filename, ".tex")))
  }
}

save_text <- function(text, filename) {
  for (path in output_paths) {
    dir.create(file.path(path, "Text"), recursive = TRUE, showWarnings = FALSE)
    writeLines(text, file.path(path, "Text", paste0(filename, ".txt")))
  }
}

# --- COLOUR PALETTE ----------------------------------------------------------
# High contrast, grayscale-friendly, colorblind-safe
# Based on Paul Tol's bright scheme and ColorBrewer recommendations
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

    # Gridlines
    panel.grid.major   = element_line(colour = "grey95", linewidth = 0.3),
    panel.grid.minor   = element_blank(),
    panel.grid.major.x = element_blank(),

    # Axes
    axis.line  = element_line(colour = "grey30", linewidth = 0.6),
    axis.ticks = element_line(colour = "grey30", linewidth = 0.6),

    # Legend: bottom, centred, horizontal
    legend.position  = "bottom",
    legend.direction = "horizontal",
    legend.box       = "horizontal",
    legend.margin    = margin(t = 5),
    legend.text      = element_text(size = 14),
    legend.title     = element_blank(),

    # Facet strips
    strip.text       = element_text(size = 14, face = "bold"),
    strip.background = element_blank()
  )

# --- KNITR OPTIONS -----------------------------------------------------------
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE)

# --- GLOBAL VARIABLES --------------------------------------------------------
se_plot <- 1.0  # Use +/- 1 SE for plotted intervals

# Suppress warnings (set to 0 or 1 for debugging)
options(warn = -1)
