# Processes

How this project's documentation is structured, what gets recorded where, and why. This file exists so that future agents (or a returning human) can understand the state of the project without needing the original conversation.

## Documentation Files and Their Roles

| File | Purpose | When it gets updated |
|------|---------|---------------------|
| `context.md` (project root) | Entry point for any agent. Points to all other context files, states project-wide conventions. | Updated when conventions change or new context files are added. |
| `research_plan.md` (project root) | The authoritative description of the study: research question, hypotheses, variables, analysis strategy, timeline, and lessons for future agents. | Updated when design decisions are finalised, when tasks are completed (timeline), or when lessons are learned (notes). Reflects the *current* plan, not the history of changes. |
| `Context/research_log.md` | Chronological log of every design and analytical decision, with rationale. | Append-only. A new entry is added every time a decision is made (variable choice, test selection, exclusion criterion, coding rule, etc.). |
| `Context/researcher_profile.md` | Background on the researcher, target journal (JEBO), writing style, LaTeX templates, R coding preferences. | Rarely changes. Reference material for writing and formatting. |
| `Context/graphs.md` | Conventions for producing graphs (colours, themes, labelling). | Reference material. Update if graph style changes. |
| `Context/tables.md` | Conventions for producing tables (booktabs, formatting). | Reference material. Update if table style changes. |
| `Context/processes.md` (this file) | Meta-documentation: explains what each file does and how information flows between them. | Update when the documentation structure itself changes. |

## What Goes Where

### Design decisions (variable choices, test selection, exclusion rules, coding schemes)
- **Finalised version** goes into `research_plan.md` — this is what someone reads to understand the current design.
- **Rationale and history** goes into `Context/research_log.md` — this is what someone reads to understand *why* the design looks the way it does, and what alternatives were considered or rejected.

### Project-wide conventions (coding style, output naming, statistical defaults)
- Goes into `context.md`. These are rules that apply across all scripts and don't change between analyses.

### Data quirks and cleaning notes (unexpected codes, missing data patterns, variable gotchas)
- Go into `Context/research_log.md` under the relevant decision entry.
- Critical data-loading instructions (file format, required packages, special codes) are also noted in `research_plan.md` so they're visible upfront.

### Implementation details (which R function, which package, specific code patterns)
- Live in the scripts themselves as comments. Not duplicated in documentation files.

## How to Use This System

**Starting a new session**: Read `context.md` first. It will direct you to everything else.

**Before making a decision**: Check `Context/research_log.md` to see if it's already been decided.

**After making a decision**: Add an entry to `Context/research_log.md` (date, decision, rationale, action). If it changes the study design, also update `research_plan.md`.

**If conventions change**: Update `context.md` and note the change in `Context/research_log.md`.
