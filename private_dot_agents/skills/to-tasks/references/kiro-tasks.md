# Kiro Tasks Reference

Use this reference when writing a Kiro-style `tasks.md` artifact. Keep the
actual task plan concise; this file is guidance for the agent, not content to
copy into the output.

## Canonical Location

Kiro feature specs use three files under a feature-specific directory:

```text
.kiro/specs/<feature-slug>/requirements.md
.kiro/specs/<feature-slug>/design.md
.kiro/specs/<feature-slug>/tasks.md
```

This skill only creates or updates `tasks.md`, and only after `requirements.md`
and `design.md` are confirmed.

## Requirements-First Task Intent

In the Requirements-First workflow, tasks follow confirmed requirements and a
confirmed technical design. The tasks document turns the plan into executable
implementation work.

The task phase should capture:

- A short implementation overview
- Discrete, trackable tasks
- Numbered parent tasks with nested numbered subtasks
- Clear implementation notes under the subtask that owns the work
- Dependencies between tasks
- Optional versus required tasks
- Validation or acceptance checks
- Progress checkboxes that can be updated during implementation

## Relationship to TDD

Borrow `$tdd` vertical-slice discipline without publishing issues:

- Prefer tracer-bullet vertical slices that cut through the needed layers
  end-to-end.
- A completed required task should be demoable or verifiable on its own when
  feasible.
- Prefer many thin subtasks over a few broad tasks.
- Use dependency order so blockers appear before blocked work.
- Mark human-decision or review tasks explicitly when implementation cannot
  proceed safely without them.

Do not create issue tracker tickets, apply triage labels, or modify parent
issues.

## Recommended File Structure

Use this exact top-level shape for Kiro IDE compatibility. The H1 must be
exactly `# Implementation Plan`; place the feature name in `## Overview`
instead of writing a title such as `# Tasks` or `# Tasks: <Feature Name>`.

````markdown
# Implementation Plan

## Overview

One to three paragraphs summarizing the feature name, implementation strategy,
key dependency ordering, and validation approach.

## Tasks

- [ ] 1. Set up the core path
  - [ ] 1.1 Create the core implementation path
    - Build the smallest end-to-end behavior behind the intended boundary
    - Follow the interfaces and module ownership defined in `design.md`
    - _Requirements: Requirement 1_

  - [ ] 1.2 Add focused coverage for the core path
    - Test the success path and the primary regression risk
    - Run the focused unit or integration test for this path
    - _Requirements: Requirement 1_

- [ ] 2. Add validation and error handling
  - [ ] 2.1 Implement designed validation behavior
    - Ensure invalid input and expected failures produce the designed behavior
    - Keep the behavior aligned with existing error handling conventions
    - _Requirements: Requirement 2, Requirement 3_

- [ ] 3. Add non-blocking polish
  - [ ]\* 3.1 Improve ergonomics without changing required behavior
    - Keep this safe to skip without violating confirmed requirements
    - Run affected checks if implemented
    - _Requirements: None, or the relevant requirement if it is required_

## Notes

- Capture assumptions, validation commands, coordination risks, or follow-up
  notes that apply to the whole plan.

## Task Dependency Graph

```json
{
  "waves": [
    { "id": 0, "tasks": ["1.1"] },
    { "id": 1, "tasks": ["1.2", "2.1"] },
    { "id": 2, "tasks": ["3.1"] }
  ]
}
```
````

Use this nested subtask style by default. Keep the required Kiro headings exact
even when local task wording or grouping conventions differ.

## Task Writing Rules

Each required task should:

- Start with an imperative verb.
- Group related subtasks under a numbered parent task.
- Keep the parent broad enough to describe a coherent implementation theme or
  vertical slice.

Each required subtask should:

- Start with an imperative verb.
- Name the concrete work and observable outcome, not just the file or layer.
- Include implementation notes as nested bullets.
- End with an italic requirement reference, such as
  `_Requirements: 1.1, 2.3_`.
- Include dependency or validation notes as nested bullets when they are known
  and useful.
- Be small enough for one implementation pass.

Optional tasks should:

- Use an asterisk immediately after the checkbox, such as
  `- [ ]* 3.1 Add optional polish`.
- Be safe to skip without violating confirmed requirements.
- Avoid hiding required behavior behind optional wording.

## Parallel Execution Notes

Kiro can analyze task dependencies and run independent tasks concurrently. Make
this practical by:

- Avoiding fake dependencies between unrelated tasks.
- Grouping setup prerequisites early.
- Naming blockers directly by task number.
- Keeping shared refactors narrow and early when multiple later tasks depend on
  them.
- Keeping the `Task Dependency Graph` section aligned with dependency notes in
  the task list.

Keep the canonical heading order as `Overview`, `Tasks`, `Notes`, then
`Task Dependency Graph`. Do not omit any of these sections, and do not rename
the H1 to include the feature name.

The `Task Dependency Graph` section must contain a fenced `json` code block with
a top-level `waves` array. Each wave object must include an `id` and a `tasks`
array. Do not use Mermaid for this section; Kiro IDE expects JSON wave
definitions.

## Review Checklist

Before finishing, review the task plan for:

- Complete coverage of confirmed requirements and design sections
- Clear required versus optional boundaries
- Coherent dependency order
- Independently verifiable completion states
- Missing setup, migration, documentation, or compatibility work
- Testing tasks that cover behavior, integration, and regressions
- Scope creep that belongs in a later spec or issue

## Source Notes

This guidance follows Kiro's public specs documentation:

- <https://kiro.dev/docs/specs/feature-specs/requirements-first/>
- <https://kiro.dev/docs/specs/>
