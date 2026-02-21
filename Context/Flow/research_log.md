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
