# Decision Log

All analytical and design decisions made during the project, with rationale. Append new entries at the bottom. Never delete or modify previous entries.

## Entry Template

Copy this template for each new decision. Prefix the title with the appropriate emoji so entries are scannable at a glance.

| Emoji | Category      |
| ----- | ------------- |
| 🔧    | Code fix      |
| 📊    | New analysis  |
| ✏️     | Writing       |
| 🧹    | Cleanup       |
| 📋    | Documentation |
| ⚙️     | Pipeline      |

```
### YYYY-MM-DD — [emoji] [Short decision title]

**Decision:** What was decided.

**Rationale:** Why this choice was made.

**Alternatives considered:** What other options were on the table and why they were rejected.

**Action:** What changed in the codebase or documentation as a result.
```

---

### 2026-02-21 — 📋 Analysis category definitions and further analyses appendix

**Decision:** Formalised the distinction between robustness, exploratory, and further analysis across the template. Added a "Further Analyses" LaTeX appendix for work that is interesting to the authors but not relevant for the paper.

**Rationale:** The existing documentation conflated robustness (tests of existing findings) with exploratory (new questions beyond hypotheses). Agents entering the project could not reliably distinguish them. Additionally, there was no structured place for analyses that were investigated, found informative, but ultimately dropped — these need a home with a brief paragraph explaining why they didn't make the cut.

**Alternatives considered:** Putting the definitions only in `context.md` without updating the R script headers. Rejected because agents often read only the script they're working in and may never consult the context file. Also considered a single catch-all appendix, but separating standard appendix material (tables/figures referenced in the paper) from further analyses (available upon request) matches journal conventions.

**Action:** Updated `Context/context.md` (analysis category definitions), `Scripts/robustness.R`, `Scripts/exploratory.R`, and `Scripts/Further Analysis/further_analysis.R` (header comments). Created `LaTeX/app_further.tex` and wired it into `LaTeX/main.tex` (commented out by default). Added change log enforcement section to `CLAUDE.md` with emoji-prefixed entry format. Updated `Context/Flow/research_log.md` entry template.

### 2026-02-23 — 📋 Added Feedback folder for referee reports and external comments

**Decision:** Created a `Feedback/` directory for storing all external feedback received during the project. Established a naming convention using `referee_report_` and `comments_` prefixes to distinguish journal referee reports from other feedback sources.

**Rationale:** The template had no structured location for incoming feedback. Referee reports, seminar comments, and committee feedback are key inputs to the revision protocol but had no defined home. A dedicated folder with clear naming conventions ensures feedback is easy to find, consistently organised, and feeds cleanly into `Context/Roles/revision_protocol.md`.

**Alternatives considered:** Storing feedback inside `Context/Flow/` alongside the research log. Rejected because feedback is external input, not internally generated documentation. Also considered a flat naming scheme without prefixes, but the `referee_report_` / `comments_` distinction makes the origin immediately scannable.

**Action:** Created `Feedback/` with `.gitkeep`. Added Feedback section to `Context/context.md` with naming convention, examples, and rules. Added Feedback section and directory entry to `README.md`. Updated directory tree in `Context/context.md` and `README.md`. Updated `Context/Roles/subagent_protocol.md` document file-writing protocol to reference `Feedback/` for external feedback. Updated `Context/Roles/revision_protocol.md` file location summary.

### 2026-02-23 — 🧹 Fixed outdated numbered script references across Context files

**Decision:** Replaced all remaining numbered script references (`00_packages.R`, `01_settings.R`, `02`–`04`, `05`–`09`, etc.) with the current script names (`config_toolkit.R`, `config_cleaning.R`, `sample_restrictions.R`, `balance_table.R`, `descriptives.R`, `hypotheses.R`, `robustness.R`, `exploratory.R`).

**Rationale:** Script names were renamed from numbered prefixes to descriptive names in an earlier restructure, but several Context files still referenced the old names. Agents reading these files would get incorrect script references.

**Alternatives considered:** None — the old names are simply wrong and must be corrected.

**Action:** Updated references in `Context/Roles/skill_graphs.md`, `Context/Roles/skill_tables.md`, `Context/Roles/researcher_profile.md`, `Context/Roles/subagent_protocol.md`, `Context/Roles/results_review_checklist.md`, `Context/Roles/revision_protocol.md`, and `Context/context.md` (output naming examples table).
