# Codebook — `data_cleaned`

One row per variable in `data/data_cleaned.csv` / `data_cleaned.RData`. Fill this in when cleaning is written, and update it whenever `scripts/config_cleaning.R` adds, renames or recodes a variable. The two rows below are examples — replace them.

**Unit of observation:** _e.g. participant × round_
**Rows / unique participants:** _filled from a script run, not by hand_

| Variable | Type | Values / units | Source column | Notes |
|---|---|---|---|---|
| `participant_id` | integer | 1, 2, … (anonymised) | `participant.id_in_session` + `participant.session` | Assigned in cleaning; replaces any Prolific ID. |
| `treatment` | factor | LOW, HIGH (level order fixed: LOW first) | `session.config.name` | Level order sets the paper-wide colour mapping. |
| | | | | |
