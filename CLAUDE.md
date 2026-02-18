# CLAUDE.md

This is a self-contained template for a single-study empirical analysis paper in behavioural economics, targeting the Journal of Economic Behavior & Organization (JEBO). Scripts run in numbered order from `Scripts/00_main.R`; output goes to `Output/`.

Read `Context/context.md` first. It links to all project context including researcher profile, analysis conventions, output standards, and task-specific guidance (graphs, tables, writing).

Check `Context/Flow/timeline.md` for the current project status — it shows which phases are done, in progress, or pending.

## Starting a New Project

The first document to complete is `pre_analysis_plan.md` — the pre-analysis plan (PAP). This captures the core pre-registered commitments (hypotheses, DVs, conditions, analyses, exclusions, sample size). If the user uploads a PAP file, copy its content into the template. If no PAP exists, guide the user through creating one by asking questions that follow the template's structure. Only once the PAP is complete should you move on to `research_plan.md`, which expands the PAP into a full study design.

## Agent Strategy

Spare no expense. Spawn as many subagents as necessary to parallelise independent tasks and preserve context in the main conversation. See `Context/Agents/subagent_protocol.md` for the full protocol on when to spawn, output format, handoff rules, and context isolation.

Use agents liberally for:

- Exploring the codebase or context files
- Running independent analyses or searches in parallel
- Drafting separate sections, scripts, or outputs concurrently
- Any work that would bloat the main context window if done inline

Keep the main thread lean. Delegate freely.

## Key Agent Resources

| Resource | Location | When to use |
|----------|----------|-------------|
| Researcher interview script | `Context/Agents/researcher_interview.md` | When eliciting a PAP from a user with no existing plan |
| Results review checklist | `Context/Agents/results_review_checklist.md` | At the results review gate, before writing begins |
| Subagent protocol | `Context/Agents/subagent_protocol.md` | Before spawning any subagent |
| Revision protocol | `Context/Agents/revision_protocol.md` | When a referee report triggers re-analysis |
