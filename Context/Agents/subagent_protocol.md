# Subagent Communication Protocol

This document governs how the main agent spawns, coordinates, and integrates work from subagents within this research template. It is read by AI agents, not humans. Follow it literally.

Read `CLAUDE.md` first for project structure. Read `Context/Flow/timeline.md` for current project status.

---

## 1. When to Spawn Subagents

Subagents exist to parallelise independent work and to isolate context when fresh perspective is needed. They are not free -- each one consumes context window and adds coordination overhead. Use them when the benefit is clear.

### Always Parallel

- **Independent file exploration.** Reading and summarising multiple context files, data files, or script files that do not depend on each other. Example: one agent reads the codebook while another reads the research plan.
- **Independent analysis sections.** Analysis scripts (`balance_table.R` through `exploratory.R`) can often run concurrently once data preparation (`config_cleaning.R` through `sample_restrictions.R`) is complete, because they read from the same cleaned dataset and write to separate output files.
- **Independent paper sections.** Introduction and Methods can be drafted concurrently because they draw on different source material. Theory and Experiment Design can be concurrent for the same reason.
- **Referee cycles.** The two referee subagents (Cycle 1: Theory & Framework, Cycle 2: Results & Integration) always run in parallel. See `Context/Roles/profile_referee.md` for their specific spawning rules.

### Never Parallel

- **Sequential data pipeline.** `config_cleaning.R` (cleaning + variable generation) -> `sample_restrictions.R` (exclusion criteria) must run in strict order. Each depends on the output of the previous.
- **Results before writing.** No drafting agent may begin the Results section until all analysis scripts have run and the results review gate is complete (`results_review.md` exists).
- **Discussion before Results.** The Discussion section depends on what the Results section reports. Draft Results first.
- **Referee before revision.** The referee report must be complete before the revise-and-resubmit cycle begins.
- **PAP before Research Plan.** `pre_analysis_plan.md` must be complete before `research_plan.md` is drafted.

### Judgement Calls

- **Robustness checks.** If `robustness.R` tests specifications that depend on the main hypothesis results (`hypotheses.R`), run them sequentially. If the robustness checks are pre-specified in the PAP and independent of the hypothesis results, they can run in parallel.
- **Exploratory analyses.** `exploratory.R` is often informed by what `balance_table.R` through `robustness.R` reveal. If the exploratory analysis is pre-specified, run it in parallel. If it responds to patterns found in the main results, it must wait.
- **Appendix drafting.** Can run in parallel with main paper sections if it covers pre-specified material. Must wait if it documents post-hoc analyses.

---

## 2. Subagent Types

Each subagent is spawned with a defined role. The role determines what context the agent receives, what it produces, and what format it uses. The main agent must specify the role in every task assignment.

### Explorer

**Purpose:** Reads and summarises context files, codebase structure, data files, or output files. Produces structured summaries for the main agent to use in decision-making.

**Required context on spawn:**
- `CLAUDE.md` (always)
- Specific files relevant to the exploration task

**Produces:** A structured summary returned to the main agent. Does not write files unless explicitly instructed.

**Output format:** Free-form summary with section headers. Must include:
- What was read (list of files)
- Key findings (bullet points)
- Anything unexpected or concerning
- Recommended next steps (if applicable)

**When to use:** Beginning of a new session, when picking up an unfamiliar project, when surveying output after analyses complete, when checking what exists before creating something new.

---

### Analyst

**Purpose:** Writes, modifies, or runs R scripts. Produces analysis output (tables, graphs, text files).

**Required context on spawn:**
- `CLAUDE.md`
- `research_plan.md` (for variable definitions, hypotheses, analysis strategy)
- `Context/Flow/codebook.md` (for variable-level documentation)
- `Scripts/config_toolkit.R` (for output functions, palette, theme)
- The active personality profile (`Context/Roles/profile_experimentalist.md` or `Context/Roles/profile_empiricist.md`)
- If modifying an existing script: the current contents of that script
- If the task depends on data structure: `Scripts/config_cleaning.R`, the active adapter in `Helper/`, and any relevant upstream scripts

**Produces:** Modified or new R script files saved to `Scripts/`. Output files saved to `Output/Graphs/`, `Output/Tables/`, or `Output/Text/` via the helper functions.

**Output format:** Uses the standard subagent report format (Section 3 below). The "Output" field must list every file written or modified, with the full path.

**Constraints:**
- All packages must be loaded in `Scripts/config_toolkit.R`, never mid-script.
- All output must use `save_graph()`, `save_table()`, `save_text()` -- never hardcoded paths.
- File naming follows the `{script}_{analysis}_{descriptor}.{ext}` convention in `CLAUDE.md`.
- Must add `cat()` progress messages.
- Must use tidyverse style.

**When to use:** Data preparation, statistical analysis, generating output. Any task that involves R code.

---

### Drafter

**Purpose:** Writes LaTeX sections, markdown documents, or structured text. Produces paper content.

**Required context on spawn:**
- `CLAUDE.md`
- `Context/Roles/researcher_profile.md` (writing style, JEBO conventions, LaTeX templates)
- `research_plan.md` (study design, hypotheses, framing)
- For Results/Discussion: all relevant output files in `Output/` and `results_review.md`
- For Introduction/Theory: relevant literature and theoretical framework from the research plan
- For Methods/Design: full design details from the research plan and PAP
- The active personality profile (for statistical reporting conventions)

**Produces:** LaTeX `.tex` files saved to `LaTeX/`, or markdown files saved to the specified location.

**Output format:** Uses the standard subagent report format (Section 3 below). The "Output" field must include the full path of every file written. For new files, the Drafter saves directly. For modifications to existing files, the Drafter describes the exact edit and the main agent applies it.

**Constraints:**
- British English spelling throughout.
- Follow all JEBO conventions in `Context/Roles/researcher_profile.md`.
- Results prose must embed core numbers and use the specified test-reporting format.
- Figure and table environments follow the templates in the researcher profile.
- Captions and notes are added in LaTeX, not embedded in R output.

**When to use:** Writing any section of the paper, drafting the abstract, producing response documents, writing `results_review.md`.

---

### Reviewer

**Purpose:** Reads output, manuscripts, or plans and produces critical assessments. Includes the referee role and the results review role.

**Required context on spawn:**
- Depends on the specific review task. See below.

**For Results Review:**
- All output files in `Output/`
- `research_plan.md` (hypotheses, analysis strategy)
- `pre_analysis_plan.md` (pre-registered commitments)
- `Context/Flow/research_log.md` (decision history)

**For Referee Report:**
- Follow the spawning rules in `Context/Roles/profile_referee.md` exactly. Two parallel subagents, each with a clean context window, receiving only the manuscript and PAP. No conversation history from the writing process.

**Produces:** A structured assessment document. For results review: `results_review.md` in the project root. For referee reports: `referee_report.md` (or numbered variant) in the project root.

**Output format:** Follows the specific format defined in the task (see `profile_referee.md` for referee reports, or `research_plan.md` for results review structure).

**Constraints:**
- Reviewer agents must not have access to the drafting agent's reasoning or conversation history. They need fresh eyes.
- Reviewer agents must be genuinely critical. A review that finds nothing wrong is a failed review.
- Reviewer agents must compare everything against the PAP.

**When to use:** Results review gate, referee report gate, any point where an independent assessment is needed.

---

### Researcher

**Purpose:** Interviews the user to elicit information needed for the project. Asks structured questions, records answers, and populates project documents.

**Required context on spawn:**
- `CLAUDE.md`
- The document being populated (e.g., `pre_analysis_plan.md` or `research_plan.md`)
- Any existing content in those documents (to avoid re-asking settled questions)

**Produces:** Populated sections of project documents. Returns a summary of what was learned and what still needs to be filled in.

**Output format:** Uses the standard subagent report format (Section 3 below). The "Output" field must describe what document sections were populated and what remains.

**Constraints:**
- Must follow the structure of the target document. Do not invent new sections.
- Must ask questions in a logical order that follows the document's flow.
- Must not make assumptions about the study design -- ask, do not guess.
- One Researcher agent at a time. User interviews are sequential and interactive. Do not parallelise user-facing questions.

**When to use:** PAP elicitation, research plan completion, any point where user input is needed to fill a document.

---

## 3. Output Format Standard

Every subagent must return its results in this format. No exceptions. The main agent parses this structure to integrate results and track progress.

```
## [Agent Type]: [Task Description]
### Status: [Complete / Partial / Blocked]
### Summary
[2-3 sentences describing what was accomplished.]
### Output
[What was produced. List every file written or modified with full paths. If no files were written, describe what was returned (e.g., a summary, an assessment, a set of recommendations).]
### Decisions Made
[Any judgment calls the agent made, with rationale. If none, write "None -- task was fully specified."]
### Escalation
[Anything that needs main agent or user attention. If none, write "None."]
```

### Rules for this format

- **Status: Complete** means the task is fully done and the output is final.
- **Status: Partial** means the agent completed some of the task but could not finish. The Summary must explain what was done and what remains. The Escalation section must explain why the task is incomplete.
- **Status: Blocked** means the agent could not make progress. The Escalation section must explain the blocker and what is needed to unblock.
- **Decisions Made** is mandatory whenever the agent exercised judgement. Examples: chose one statistical test over another, decided how to handle missing data, chose a framing for a paragraph, excluded observations based on a rule not specified in the task. The main agent reviews all decisions and may override them.
- **Escalation** is the mechanism for flagging problems upward. Use it for: missing data, ambiguous instructions, conflicting information in context files, decisions that should be made by the user rather than the agent, errors encountered during execution.

---

## 4. Handoff Protocol

### How the Main Agent Assigns Work

Every task assignment from the main agent to a subagent must include:

1. **Role.** Which subagent type (Explorer, Analyst, Drafter, Reviewer, Researcher).
2. **Task description.** A clear, specific statement of what the subagent must do. Not "look at the data" but "read `Output/Tables/` and summarise all balance table results, flagging any variable where the treatment-control difference is significant at p < .10."
3. **Required context.** A list of files the subagent must read. For Reviewer agents that need isolation, specify what context is deliberately withheld and why.
4. **Expected output.** What the subagent should produce -- a file (with path), a summary, an assessment, an edited script. Be specific about the deliverable.
5. **Constraints.** Any restrictions beyond the role defaults. Example: "Do not modify any script files -- describe the needed changes and I will apply them."
6. **Priority.** If multiple subagents are running, indicate whether this task is on the critical path.

### How Subagents Signal Completion

Subagents signal completion by returning the standard output format (Section 3). The status field is the signal:
- **Complete**: Main agent can proceed to integrate.
- **Partial**: Main agent must decide whether to reassign, extend, or handle the remainder.
- **Blocked**: Main agent must resolve the blocker before work can continue.

### How the Main Agent Integrates Results

1. **Read all subagent reports** before taking action.
2. **Check for conflicts.** If two subagents modified the same file or made contradictory decisions, resolve before proceeding. The main agent is the single point of coordination -- subagents never resolve conflicts with each other.
3. **Review all decisions.** Every entry in a subagent's "Decisions Made" section must be reviewed. Override if the decision conflicts with the PAP, research plan, or user instructions.
4. **Apply file changes.** If a subagent was instructed to describe edits rather than apply them, the main agent applies the edits now.
5. **Update tracking.** After integrating results, update `Context/Flow/timeline.md` and `Context/Flow/research_log.md` as appropriate.
6. **Report to user.** Summarise what was accomplished, what decisions were made, and what needs user attention. Keep this lean -- the user does not need to see raw subagent reports.

### When a Subagent Gets Stuck

If a subagent returns **Blocked** or **Partial**:

1. **Read the Escalation section** to understand the blocker.
2. **Determine if the blocker is resolvable** by the main agent (e.g., a missing file that the main agent can locate, an ambiguous instruction that the main agent can clarify).
3. **If resolvable**: fix the issue and re-assign the task with the additional context.
4. **If not resolvable** (requires user input, missing data, etc.): report to the user with a specific question. Do not guess.
5. **Do not re-spawn a subagent for the same task more than twice.** If two attempts fail, escalate to the user with a full explanation of what went wrong.

---

## 5. Context Isolation Rules

Context isolation is not optional. Some tasks require a fresh perspective, and leaking context from one agent to another undermines the purpose.

### Full Isolation (clean context window, no conversation history)

Required for:
- **Referee agents.** Both Cycle 1 and Cycle 2 referee subagents must be spawned with no knowledge of the writing process, no access to the drafting agent's reasoning, and no conversation history beyond what is explicitly passed to them. They receive only: the manuscript content, the PAP (`research_plan.md`), and their role instructions (`Context/Roles/profile_referee.md`). This is non-negotiable.
- **Results review agents.** The agent that conducts the results review should not have been the same agent that wrote the analysis scripts, if avoidable. If the main agent must do both, it should approach the review as a distinct phase and explicitly re-read all output fresh rather than relying on memory of what the scripts were supposed to produce.

### Shared Context (agents can see each other's output)

Permitted for:
- **Drafter agents** working on different sections of the same paper. They should share: the research plan, the analysis output, the results review, and the overall paper structure. They should not share each other's drafts until integration, to avoid one section's framing constraining another.
- **Analyst agents** working on independent scripts. They share the codebook, research plan, and data preparation output. They do not need to see each other's scripts.
- **Explorer agents.** No isolation needed. Their purpose is to gather and summarise information.

### Enforcing Isolation

The main agent enforces isolation by controlling what context is passed to each subagent at spawn time. The rules:

1. **Never pass conversation history** to a Reviewer agent unless the task explicitly requires it (which it almost never does).
2. **Never pass one subagent's reasoning or report** to another subagent unless there is a specific integration need.
3. **When in doubt, isolate.** A subagent with too little context will report "Blocked" and you can provide more. A subagent with too much context may produce biased output and you will not know it.

---

## 6. File-Writing Protocol

File conflicts are the most common coordination failure in multi-agent work. These rules prevent them.

### New Files

- The subagent saves the file directly to the location specified in the task assignment.
- The task assignment must include the exact file path. The subagent must not choose its own file path.
- Before writing, the subagent must check whether the file already exists. If it does and the task did not say to overwrite, the subagent must report **Blocked** and escalate.

### Modified Files

- **Default rule:** The subagent describes the exact edit needed (which file, what to find, what to replace it with) and the main agent applies it.
- **Exception:** If the subagent is the only agent working on that file and the main agent explicitly grants write permission in the task assignment, the subagent may edit directly.
- This rule exists because two subagents editing the same file will create conflicts that are difficult to detect and resolve.

### Temporary Working Files

- Prefix with `_tmp_` (e.g., `_tmp_balance_check.txt`).
- Save to the same directory as the final output would go.
- The subagent must note all temporary files in its report.
- The main agent cleans up temporary files after integration. Subagents must not delete files they did not create.

### Output Files

- All R output must go through `save_graph()`, `save_table()`, `save_text()`.
- Follow the naming convention in `CLAUDE.md`: `{script}_{analysis}_{descriptor}.{ext}`.
- Never overwrite existing output files without explicit instruction from the main agent or user.

### Document Files

- Research documents (`results_review.md`, `referee_response.md`, etc.) go in the project root.
- External feedback (referee reports, seminar comments, committee feedback) goes in `Feedback/` using the naming convention in `CLAUDE.md`.
- Feedback files are immutable — never overwrite. New rounds of feedback get new files.
- Context files go in their designated subdirectory under `Context/`.

---

## 7. Parallelisation Patterns

These are the standard parallelisation patterns for each project phase. The main agent should follow these unless the specific project requires a different approach.

### PAP Elicitation

**Pattern:** Single sequential agent (Researcher type).

**Why:** This is an interactive process with the user. Questions build on previous answers. Cannot be parallelised.

**Agent count:** 1

**Dependencies:** None -- this is the starting point.

---

### Research Plan Drafting

**Pattern:** Single sequential agent (Drafter type).

**Why:** The research plan builds on the PAP and requires coherence across sections. One agent maintains the thread.

**Agent count:** 1

**Dependencies:** PAP must be complete.

---

### Data Exploration

**Pattern:** 2-3 parallel agents (Explorer type).

**Standard split:**
- Agent 1: Data structure and completeness (variables available, types, dimensions, missing data patterns)
- Agent 2: Distributions and summary statistics (means, medians, ranges, outliers, skewness)
- Agent 3: Treatment-related checks (balance, randomisation integrity, attrition)

**Why:** These explorations are independent. Each reads the raw data and produces a summary. No agent needs another's output.

**Agent count:** 2-3

**Dependencies:** Data must be loaded. `Scripts/config_cleaning.R` and the active adapter in `Helper/` should exist at minimum.

**Integration:** Main agent reads all three summaries and decides what to populate in the codebook and what issues to log.

---

### Data Preparation (`config_cleaning.R` -> `sample_restrictions.R`)

**Pattern:** Strictly sequential. Single agent (Analyst type).

**Why:** Each script depends on the output of the previous one. `config_cleaning.R` orchestrates adapter selection, variable generation, and produces the cleaned data. `sample_restrictions.R` applies exclusion criteria and subsetting. No parallelism possible.

**Agent count:** 1

**Dependencies:** Data files in `Data/`, codebook populated (at least partially).

---

### Analysis Scripts (`balance_table.R` through `exploratory.R`)

**Pattern:** Parallel for independent scripts, sequential where dependencies exist.

**Standard approach:**
- `balance_table.R`: Independent. Can run as soon as `sample_restrictions.R` is complete.
- `descriptives.R`: Independent. Can run as soon as `sample_restrictions.R` is complete.
- `hypotheses.R`: Independent. Can run as soon as `sample_restrictions.R` is complete.
- `robustness.R`: May depend on `hypotheses.R` if robustness checks are designed to probe the main results. If robustness specs are pre-registered and independent of hypothesis output, can run in parallel.
- `exploratory.R`: Often depends on what `balance_table.R` through `robustness.R` reveal. If pre-specified, can run in parallel. If responsive, must wait.

**Agent count:** Up to 4 parallel Analyst agents (one per independent script), plus 1 sequential for dependent scripts.

**Dependencies:** Data preparation (`config_cleaning.R` through `sample_restrictions.R`) must be complete. Research plan must define the analyses.

**Integration:** Main agent collects all output, checks for consistency, and prepares for the results review.

---

### Results Review

**Pattern:** Single agent (Reviewer type), ideally not the same agent that wrote the analysis scripts.

**Why:** The review requires reading all output holistically and comparing against the PAP. It is a single coherent assessment, not decomposable.

**Agent count:** 1

**Dependencies:** All analysis scripts complete. All output generated.

**Output:** `results_review.md` in the project root.

---

### Paper Drafting

**Pattern:** Parallel for independent sections, sequential for dependent sections.

**Standard split:**
- **Wave 1 (parallel):** Introduction, Theory, Experiment/Design, Methods -- these draw on the research plan, literature, and design, not on results.
- **Wave 2 (sequential after Wave 1):** Results -- must wait until Wave 1 sections exist (to know what the paper has promised) and until the results review is complete.
- **Wave 3 (sequential after Wave 2):** Discussion, Conclusion -- must wait for Results because they interpret the findings.
- **Abstract (last):** Written after all other sections are complete.

**Agent count:** Up to 4 parallel Drafter agents in Wave 1. 1 each for Waves 2 and 3. 1 for the Abstract.

**Dependencies:** Research plan complete, results review complete (for Wave 2+), all output available.

**Integration:** Main agent reads all section drafts, checks for consistency in framing, numbering, cross-references, and narrative flow. Resolves any conflicts in how different sections present the same information.

---

### Referee Cycle

**Pattern:** Strictly defined in `Context/Roles/profile_referee.md`. Two parallel Reviewer agents, then sequential synthesis.

**Sequence:**
1. Main agent prepares manuscript content and PAP for the two referee agents.
2. Spawn Cycle 1 (Theory & Framework) and Cycle 2 (Results & Integration) in parallel. Both are fully isolated.
3. Both agents return their partial reports.
4. Main agent synthesises into a single referee report following the merge protocol in `profile_referee.md`.
5. Save the numbered referee report.

**Agent count:** 2 parallel Reviewer agents + main agent for synthesis.

**Dependencies:** Complete manuscript draft. All output available.

---

### Revise & Resubmit

**Pattern:** Sequential. Single coordinating agent (main thread) with targeted subagent spawns as needed.

**Sequence:**
1. Main agent reads the referee report and triages comments.
2. For each comment requiring analysis changes: spawn an Analyst subagent with the specific task.
3. For each comment requiring rewriting: spawn a Drafter subagent (or handle in main thread if the edit is small).
4. Analysis changes must complete before rewriting changes, if the rewriting depends on new results.
5. Main agent integrates all changes.
6. Spawn a new referee agent pair for the next report.

**Agent count:** Variable. 1 main + N subagents as needed.

**Dependencies:** Referee report must exist. Each revision depends on the specific comment being addressed.

---

## 8. Error Handling and Recovery

### Subagent Produces Incorrect Output

If the main agent detects that a subagent's output is wrong (factual error, wrong file modified, contradicts the research plan):
1. Do not use the output.
2. Log the error in the "Decisions Made" section of the main agent's own tracking.
3. Re-assign the task with corrected instructions, noting what went wrong the first time.

### Subagent Exceeds Scope

If a subagent modifies files or makes decisions outside its assignment:
1. Revert any unauthorised file changes.
2. Use only the portions of the output that fall within scope.
3. If the out-of-scope work is actually useful, evaluate it independently before incorporating.

### Conflicting Subagent Outputs

If two subagents produce contradictory results or recommendations:
1. Do not average or compromise. One of them is wrong, or the task was under-specified.
2. Review both outputs against the source material (data, PAP, research plan).
3. Choose the output that is better supported. Log the conflict and the resolution in `Context/Flow/research_log.md`.
4. If the conflict cannot be resolved by the main agent, escalate to the user.

### Context Window Limits

If a subagent's task is too large for a single context window:
1. Decompose the task into smaller subtasks.
2. Ensure each subtask is self-contained (has all the context it needs without depending on another subtask's reasoning).
3. Assign each subtask to a separate subagent.
4. Integrate the results in the main thread.

---

## 9. Checklist for the Main Agent

Before spawning any subagent, verify:

- [ ] The task description is specific and unambiguous.
- [ ] All required context files are listed.
- [ ] The expected output (file path, format, deliverable) is stated.
- [ ] Context isolation rules are respected (especially for Reviewer agents).
- [ ] No two subagents will write to the same file.
- [ ] The task does not violate any sequential dependency.
- [ ] The subagent role is appropriate for the task.

After all subagents return, verify:

- [ ] All reports use the standard output format.
- [ ] All statuses are Complete (or Partial/Blocked are handled).
- [ ] All "Decisions Made" entries have been reviewed.
- [ ] All "Escalation" entries have been addressed.
- [ ] All file changes are consistent with each other and with the project state.
- [ ] Timeline and research log are updated.
- [ ] Temporary files are cleaned up.
