# CLAUDE.md

This is a self-contained template for a single-study empirical analysis paper in economics. Run the analysis from `main.R` in the project root; output goes to `Output/`.

Read `Context/context.md` first. It links to all project context including researcher profile, analysis conventions, output standards, and task-specific guidance (graphs, tables, writing).

Check `Context/Flow/timeline.md` for the current project status — it shows which phases are done, in progress, or pending.

## Starting a New Project

The first step is to **select a research personality** from `Context/Roles/researcher_profile.md`:


| Personality                 | Profile                      | Target journal        |
| --------------------------- | ---------------------------- | --------------------- |
| **Experimentalist**         | `profile_experimentalist.md` | JEBO                  |
| **Empiricist**              | `profile_empiricist.md`      | JEBO                  |
| **Industrial Organisation** | `profile_io.md`              | RAND, JIE, IJIO, JEMS |


Once the personality is set, create the **research basis document** before moving to the research plan. Templates are stored in `Context/Templates/` — they do not exist in the project root until generated or uploaded.

### Experimentalist path

1. Check if the user has a PAP to upload (from AsPredicted, OSF, or similar).
2. **If a PAP exists**: copy the template from `Context/Templates/pre_analysis_plan.md` to the project root as `pre_analysis_plan.md`, then populate it from the uploaded document. Use it as the basis for `research_plan.md`.
3. **If no PAP exists**: copy the template to root and guide the user through creating one using `Context/Agents/researcher_interview.md`. The PAP must be completed before the research plan.

### Empiricist / IO path

1. Ask the user if they have an existing research intention document — a grant proposal, working paper draft, internal planning document, or anything describing the research question, data, and approach.
2. **If a document exists**: copy the template from `Context/Templates/research_intention.md` to the project root as `research_intention.md`, then populate it from the uploaded document. Use it as the basis for `research_plan.md`.
3. **If no document exists**: copy the template to root and guide the user through creating one using `Context/Agents/researcher_interview.md`. The research intention must be completed before the research plan.

### Templates

| Template                                  | For personality | Purpose                                                                                    |
| ----------------------------------------- | --------------- | ------------------------------------------------------------------------------------------ |
| `Context/Templates/pre_analysis_plan.md`  | Experimentalist | Pre-registered commitments: hypotheses, DVs, conditions, analyses, exclusions, sample size |
| `Context/Templates/research_intention.md` | Empiricist / IO | Planned empirical strategy: research question, identification, data, specifications        |


## Agent Strategy

Spare no expense. Spawn as many subagents as necessary to parallelise independent tasks and preserve context in the main conversation. See `Context/Agents/subagent_protocol.md` for the full protocol on when to spawn, output format, handoff rules, and context isolation.

Use agents liberally for:

- Exploring the codebase or context files
- Running independent analyses or searches in parallel
- Drafting separate sections, scripts, or outputs concurrently
- Any work that would bloat the main context window if done inline

Keep the main thread lean. Delegate freely.

## Change Log Enforcement

Every agent **must** update `Context/Flow/research_log.md` after any change — code, LaTeX, data, or documentation. This is a blocking requirement, not a suggestion. No change is complete until it is logged.

Use the emoji-prefixed entry format so entries are scannable at a glance:

| Emoji | Category      |
| ----- | ------------- |
| 🔧    | Code fix      |
| 📊    | New analysis  |
| ✏️     | Writing       |
| 🧹    | Cleanup       |
| 📋    | Documentation |
| ⚙️     | Pipeline      |

Entry format:

```
### YYYY-MM-DD — [emoji] [Short title]

**Decision:** What was decided or changed.

**Rationale:** Why this change was made.

**Alternatives considered:** What other options were on the table and why they were rejected.

**Action:** What changed in the codebase or documentation as a result.
```

## Key Agent Resources


| Resource                    | Location                                     | When to use                                                                      |
| --------------------------- | -------------------------------------------- | -------------------------------------------------------------------------------- |
| Researcher interview script | `Context/Agents/researcher_interview.md`     | When eliciting a PAP or research intention from a user with no existing document |
| Results review checklist    | `Context/Agents/results_review_checklist.md` | At the results review gate, before writing begins                                |
| Subagent protocol           | `Context/Agents/subagent_protocol.md`        | Before spawning any subagent                                                     |
| Revision protocol           | `Context/Agents/revision_protocol.md`        | When a referee report triggers re-analysis                                       |


