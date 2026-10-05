# data/

Everything the analysis reads. The folder is **tracked in git** so the whole pipeline rebuilds from a fresh GitHub clone — with one exception, `raw_SENSITIVE/`, which never leaves this machine.

| Path | What lives there | Tracked? |
|---|---|---|
| `datasets/` | Anonymised raw exports (e.g. oTree or survey CSVs with identifiers removed). The input to cleaning. | Yes |
| `raw_SENSITIVE/` | Identifiable raw data: anything with Prolific IDs, participant labels, user agents, IPs, emails, free text. The **only** place such files live — never copied elsewhere. | **No** (only `.gitkeep`) |
| `data_cleaned.csv` | The one combined cleaned dataset, plain-text twin. Scanned by the pre-commit check. | Yes |
| `data_cleaned.RData` | The same dataset as an R object named `data`; this is what `main.R` loads. | Yes |
| `checkpoint_prepared.RData` | Workspace snapshot written by `save_checkpoint()` after sample restrictions. | Yes (not ignored) |
| `CODEBOOK.md` | Variable-level documentation of `data_cleaned`. | Yes |

## Rebuilding the cleaned data

1. Put anonymised raw exports in `datasets/`. If a file still carries identifiers, put it in `raw_SENSITIVE/` instead and de-identify it into `datasets/` first.
2. Pick the adapter in `scripts/config_cleaning.R` (`data_source <- "otree"` or `"csv"`; adapters live in `scripts/helper/`).
3. In `main.R`, uncomment the three lines of the **CLEANING** block, run once, and comment them out again. This rewrites `data_cleaned.csv` and `data_cleaned.RData`.

## Before committing

The pre-commit hook in `.githooks/` refuses commits containing Prolific IDs, emails, IPv4 addresses, user-agent strings or identifying CSV column headers (install once with `git config core.hooksPath .githooks`). It scans text files only: `.RData` files are binary and are **not** scanned — their CSV twin is, which is why cleaning always writes both.
