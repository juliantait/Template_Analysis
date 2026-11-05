# Codebook — `data_cleaned`

One row per variable in `data/data_cleaned.csv` / `data_cleaned.RData`. Fill this in when cleaning is written, and update it whenever `scripts/config_cleaning.R` adds, renames or recodes a variable. The two rows below are examples — replace them.

**Unit of observation:** _e.g. participant × round_
**Rows / unique participants:** _filled from a script run, not by hand_

| Variable | Type | Values / units | Source column | Notes |
|---|---|---|---|---|
| `participant_id` | integer | 1, 2, … (anonymised) | `participant.id_in_session` + `participant.session` | Assigned in cleaning; replaces any Prolific ID. |
| `treatment` | factor | LOW, HIGH (level order fixed: LOW first) | `session.config.name` | Level order sets the paper-wide colour mapping. |
| `lab_session` | character | e.g. 217, 217b, 007, test; NA if not set | `session.config.lab_session` | Lab session number from the oTree Lab Launcher. Text, not necessarily numeric. On every row by `scripts/helper/otree.R`; NA on every row for an export without the column. |
| `otree_session` | character | oTree session code, e.g. 4xr51vk1; NA if not in the export | `session.code` | Tells the sessions in one CSV apart. Text. On every row by `scripts/helper/otree.R`. |
| `session` | character | CSV file name without `.csv` | file name | Not the oTree session: one CSV can hold several sessions. See `otree_session`. |
| `payoff` | numeric | oTree currency, per round; NA for a round not played | `main.<round>.player.round_payoff` | Per round. |
| `treatment_group` | character | row, column as shipped; NA if never randomised | `participant.treatment_group` | Empty in the export for a participant who never arrived. |
| `num_failed_attempts` | numeric | wrong quiz submissions, 0, 1, … | `participant.comprehension_failed_attempts` | Total for the participant, re-read pass included. |
| `age`, `gender` | numeric, character | as answered; NA if not collected | `outro.1.player.age`, `outro.1.player.gender` | |
| `selected_sum`, `earned` | numeric | oTree currency | `outro.1.player.selected_sum`, `outro.1.player.earned` | Sum of the rewarded rounds; final amount. |
| `sepa` | numeric | 1, 0; NA if no bank details collected | `outro.1.player.sepa` | Whether the IBAN country is in SEPA. |
| | | | | |
