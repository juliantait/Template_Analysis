# CLAUDE.md

Read `context.md` first. It links to all project context including researcher profile, analysis conventions, output standards, and task-specific guidance (graphs, tables, writing).

## Agent Strategy

Spare no expense. Spawn as many subagents as necessary to parallelise independent tasks and preserve context in the main conversation. Use agents liberally for:

- Exploring the codebase or context files
- Running independent analyses or searches in parallel
- Drafting separate sections, scripts, or outputs concurrently
- Any work that would bloat the main context window if done inline

Keep the main thread lean. Delegate freely.
