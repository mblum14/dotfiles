---
name: to-tasks
description: Convert confirmed Kiro-style requirements.md and design.md specs into a tasks.md implementation plan. Use after to-req and to-design, when the user asks to create tasks.md, generate Kiro implementation tasks, proceed from design to tasks, break a spec into discrete trackable tasks, define dependencies, mark optional versus required work, or prepare task execution; do not create issues, publish tracker tickets, change requirements, or redesign the feature.
---

# To Tasks

Create a focused Kiro Requirements-First `tasks.md` artifact from confirmed
`requirements.md` and `design.md` files. Use the vertical-slice discipline from
`$tdd`, but keep the output as a repo-local task plan instead of publishing
issue tracker tickets.

## Workflow

1. Establish the spec path.
   - Prefer an existing `.kiro/specs/<feature>/requirements.md` and
     `.kiro/specs/<feature>/design.md`, then write the sibling
     `.kiro/specs/<feature>/tasks.md`.
   - If the user names a different source or output path, use that exact path.
   - If confirmed requirements or design artifacts are missing, stop and ask for
     them or run `$to-req` and `$to-design` first.

2. Read the confirmed source artifacts and repo context.
   - Treat `requirements.md` as the product contract and `design.md` as the
     technical contract.
   - Inspect nearby steering docs, existing task files, similar tests,
     implementation conventions, and build/validation commands before drafting.
   - Do not reopen requirements or redesign architecture unless the source
     artifacts conflict.

3. Draft only `tasks.md`.
   - Do not create tracker issues, a PRD, `requirements.md`, or `design.md`
     unless the user explicitly asks.
   - Break work into numbered parent tasks with nested numbered subtasks.
   - Use parent tasks as implementation themes or vertical slices, and use
     subtasks as the concrete execution units.
   - Prefer thin, independently verifiable subtasks over broad layer-only
     chunks.
   - Make dependencies explicit so independent tasks can run in parallel waves.
   - Mark optional tasks clearly and keep required tasks sufficient to satisfy
     the confirmed requirements.

4. Use the Kiro task format.
   - Read `references/kiro-tasks.md` when writing or reviewing the file.
   - Include the canonical headings in order: `# Implementation Plan`,
     `## Overview`, `## Tasks`, `## Notes`, and
     `## Task Dependency Graph`.
   - Keep the top-level heading exactly `# Implementation Plan`; do not use
     `# Tasks`, `# Task List`, or append the feature name to the H1.
   - Put the feature name and context in `## Overview`, not in the document
     title.
   - Use nested checkbox tasks with short imperative titles:
     `- [ ] 1. Parent task` and `- [ ] 1.1 Subtask`.
   - Mark optional tasks or subtasks with an asterisk immediately after the
     checkbox: `- [ ]* 1.3 Optional subtask`.
   - Put concrete implementation notes as bullets under the relevant subtask.
   - Put requirement traceability at the end of each subtask as
     `_Requirements: <ids>_`.
   - Include dependency notes, expected outcomes, and validation as task bullets
     only where they add useful execution context.
   - Under `## Task Dependency Graph`, include a fenced `json` code block with
     a top-level `waves` array. Each wave object should include an `id` and a
     `tasks` array of task or subtask identifiers.
   - Do not use Mermaid for `## Task Dependency Graph`; Kiro IDE expects JSON
     wave definitions there.
   - Keep tasks concrete enough that an implementation agent can start without
     inventing scope.

5. Run a task planning review before finishing.
   - Check every requirement and major design element has an implementation
     path.
   - Check each task has a clear done state.
   - Check dependency order is coherent and independent tasks are not
     accidentally serialized.
   - Split tasks that are too broad; merge tasks that cannot be verified
     independently.
   - Remove speculative optional work unless it is clearly labeled and useful.

6. Report the created or updated path and any open questions.
   - Keep the final response short.
   - Mention that only the task artifact was created or changed.

## Output Shape

Use this structure exactly for Kiro IDE compatibility:

````markdown
# Implementation Plan

## Overview

<Short summary of the feature, implementation strategy, and sequencing. Include the feature name here.>

## Tasks

- [ ] 1. Build the first required vertical slice
  - [ ] 1.1 Create the core implementation path
    - Add the smallest behavior needed to make the slice work end to end
    - Follow the interfaces and boundaries defined in `design.md`
    - _Requirements: <requirement ids or names>_

  - [ ] 1.2 Add focused coverage for the core path
    - Test the success path and the primary regression risk
    - Run the focused unit or integration test for this slice
    - _Requirements: <requirement ids or names>_

- [ ] 2. Add the next required capability
  - [ ] 2.1 Implement the next behavior
    - Build only the behavior required by the confirmed spec
    - Reuse established project conventions and helpers
    - _Requirements: <requirement ids or names>_

  - [ ]\* 2.2 Add non-blocking polish or follow-up
    - Keep this safe to skip without violating confirmed requirements
    - _Requirements: <requirement ids or names, if any>_

## Notes

- <Important assumptions, validation commands, or coordination notes.>

## Task Dependency Graph

```json
{
  "waves": [
    { "id": 0, "tasks": ["1.1"] },
    { "id": 1, "tasks": ["1.2", "2.1"] },
    { "id": 2, "tasks": ["2.2"] }
  ]
}
```
````

## Notes

- Keep generated notes limited to assumptions, validation commands, and
  coordination details that affect implementation.
- Do not use notes to add new requirements, redesign decisions, or speculative
  follow-up work.

## Task Dependency Graph

- Include a fenced `json` code block in the generated `tasks.md` after
  `## Notes`.
- Use a top-level `waves` array. Each wave object must include an `id` and a
  `tasks` array of task or subtask identifiers.
- Put prerequisites in earlier waves and parallelizable work in the same wave.
- Keep the JSON valid: double-quoted strings, no trailing commas, and no
  comments.
- Do not use Mermaid in this section; Kiro IDE expects JSON wave definitions.

## Quality Bar

Tasks are done when an implementation agent can execute them in order,
independent tasks can be identified for parallel execution, and every required
task traces back to confirmed requirements and design decisions. Before
finishing, verify the document does not trigger Kiro IDE diagnostics for a
missing `# Implementation Plan` heading, missing `## Overview`, missing
`## Tasks`, missing `## Notes`, missing `## Task Dependency Graph`, or missing
JSON wave definitions.
