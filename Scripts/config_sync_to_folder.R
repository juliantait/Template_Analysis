# Sync outputs to configured destination folders (e.g. Overleaf)
# Copies individual files; overwrites same-named files; preserves destination-only files.
# Edit SYNC_DESTINATIONS in Scripts/config_init.R

if (!exists("SYNC_DESTINATIONS")) source("Scripts/config_init.R")

if (length(SYNC_DESTINATIONS) == 0) {
  cat("  -> No sync destinations configured. Skipping.\n")
} else {
  output_dirs <- c("Graphs", "Tables", "Text")

  for (dest_root in SYNC_DESTINATIONS) {
    dest_root <- path.expand(dest_root)
    if (!nzchar(dest_root)) next

    # Sync root-level files
    root_files <- list.files(OUTPUT_ROOT, full.names = TRUE, recursive = FALSE, no.. = TRUE)
    root_files <- root_files[!file.info(root_files)$isdir]
    if (length(root_files) > 0) file.copy(root_files, dest_root, overwrite = TRUE)

    # Sync Graphs/, Tables/, Text/ subdirectories
    for (od in output_dirs) {
      src_dir  <- file.path(OUTPUT_ROOT, od)
      dest_dir <- file.path(dest_root, od)
      if (!dir.exists(src_dir)) next
      if (!dir.exists(dest_dir)) dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
      files <- list.files(src_dir, full.names = TRUE)
      if (length(files) > 0) file.copy(files, dest_dir, overwrite = TRUE)
    }

    cat("  -> Synced outputs to", dest_root, "\n")
  }
}
