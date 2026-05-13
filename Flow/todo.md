# To-Do

**Last updated:** 2026-02-23

This is the AI agent's active task queue. It is separate from `timeline.md`, which tracks the overall research phases. The to-do contains specific, actionable work items for the current moment — populated by the researcher or a prior agent session, and cleared once all items are complete.

**How this works with the timeline:** The timeline shows *where the project is* (e.g. "Major Revision in progress"). The to-do shows *what the AI should do right now*. The researcher populates the to-do whenever there is work for the AI — revision tasks, new analyses, writing tasks, or anything else. Multiple to-do batches can occur within a single timeline phase.

When an agent starts a session, it should check this file. If there are pending tasks, the agent should:

1. Find the next pending part (the first part where status is not `DONE`).
2. Read the task descriptions and implement them.
3. Tick off each task as it is completed (`[ ]` → `[x]`).
4. When all tasks in the part are done, set the part status to `DONE`.
5. Write a completion report to `Context/Flow/todo_report_<part_label>.md` — list every file changed, what was changed, and any judgement calls made.
6. Update `Context/Flow/research_log.md` with a dated entry covering all changes.

When all parts are done, the researcher resets this file for the next batch of work.

---

*No tasks currently queued.*
