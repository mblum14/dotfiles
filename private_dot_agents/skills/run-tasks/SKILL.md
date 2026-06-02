---
name: run-tasks
description: Execute approved Kiro-style implementation plans from requirements.md, design.md, and tasks.md with a verification-gated TDD loop. Use after to-req, to-design, and to-tasks when the user asks to run tasks, execute tasks, implement all tasks, continue implementation from a spec, run a Kiro tasks.md plan, or complete incomplete required spec tasks one at a time, sequentially, or in parallel when safe, with red-green-refactor execution, task-state updates, optional subtask parallelism, and commit-granularity judgement.
---

# Run Tasks

Execute the approved `tasks.md` plan against its sibling `requirements.md` and
`design.md`. Treat the spec files as the contract, the task list as the tracker,
and the repo's tests as the proof. Use `$tdd` as the default implementation
discipline for behavior-changing tasks: write one behavior test, make it pass,
then refactor while green.

## Workflow

1. Establish the spec path.
   - Prefer `.kiro/specs/<feature>/requirements.md`,
     `.kiro/specs/<feature>/design.md`, and
     `.kiro/specs/<feature>/tasks.md`.
   - If the repo uses `/specs/<feature>/`, use that path instead.
   - If the user names exact files, use those exact paths.
   - If any required spec file is missing, stop and ask whether to run
     `$to-req`, `$to-design`, or `$to-tasks` first.

2. Confirm implementation entry.
   - Read all three spec files before editing code.
   - Check for unresolved open questions, unapproved drafts, or conflicting
     requirements/design/task instructions.
   - If implementation would require changing requirements or design, update
     the relevant spec and get approval before coding.

3. Inspect current repo state.
   - Read agent instructions, project docs, similar code, tests, and validation
     commands before making changes.
   - Load `$tdd` before implementing behavior changes, bug fixes, or new
     integration paths.
   - Check git status and preserve unrelated user or agent changes.
   - Identify the task checkbox format and preserve it when updating
     `tasks.md`.

4. Sync already-implemented tasks.
   - Before coding, scan incomplete tasks against the current code and tests.
   - If a task is already implemented, verify it with the narrowest useful
     check, mark it complete in `tasks.md`, and record the verification.
   - Do not reimplement completed behavior just because the checkbox is still
     open.
   - If a task appears partially complete, either finish the missing pieces or
     add a short note under the task explaining the remaining gap.

5. Build the execution plan.
   - Execute only incomplete required tasks by default.
   - Skip optional tasks unless the user explicitly asks for optional work or
     they are necessary to satisfy required tasks.
   - Derive dependencies from the task order, dependency graph, requirement
     references, shared files, migrations, APIs, and tests.
   - Choose an execution mode from user instructions and dependency analysis:
     one-at-a-time, sequential, or parallel-capable.
   - For one-at-a-time mode, select the next incomplete required parent task
     and keep it as the active work boundary until it is completed, blocked, or
     explicitly skipped.
   - For sequential mode, order incomplete required parent tasks and waves by
     dependency, then execute them one after another.
   - For parallel-capable mode, group independent parent tasks or subtasks into
     waves. Items in the same wave must be safe to work on without overlapping
     write sets or relying on each other's outputs.
   - Within each active parent task or wave, derive subtask dependencies and
     identify which subtasks must run sequentially versus which can run
     independently.

6. Run tasks with the selected mode and appropriate parallelism.
   - If the user asks for one task at a time, execute the next incomplete
     required parent task only, then stop after updating task state and
     reporting verification.
   - If the user asks for sequential execution, or gives no explicit mode,
     execute parent tasks or waves one after another in dependency order.
   - If the user asks for parallel execution, parallelize only independent items
     within a wave that satisfy the safety rules below and that the current
     agent environment can actually run concurrently.
   - Run read-only exploration, file reads, and independent verification checks
     in parallel when the local tool environment supports it.
   - Use implementation parallelism only when items are truly independent and
     the current agent environment permits concurrent workers or subagents.
   - For Codex specifically, delegate implementation to subagents only when the
     user explicitly authorized parallel agent work; otherwise execute the
     items sequentially while preserving the same dependency reasoning.
   - Do not parallelize items that touch the same files, database migrations,
     public contracts, shared test fixtures, or cross-cutting infrastructure.
   - After each parallel group completes, integrate and verify the parent task
     or wave before moving to the next item.

7. Implement each task to completion with TDD.
   - Use `$tdd` for every behavior-changing task unless the task is purely
     mechanical, documentation-only, generated-code-only, or cannot reasonably
     be exercised by an automated test in the repo.
   - Work in vertical slices: one behavior test, one minimal implementation,
     one verification pass, then the next behavior.
   - Avoid horizontal test batches. Do not write all tests for a parent task
     before implementing the first behavior.
   - Write tests through public interfaces and observable behavior. Avoid tests
     coupled to private functions, internal call order, or mocked collaborators
     unless the repo has no practical public boundary for that behavior.
   - Confirm the RED state for each new or changed test when practical. If the
     repo test harness makes a clean RED run impractical, state the reason and
     still keep the test focused on behavior.
   - Make the smallest code change that satisfies the task and its traced
     requirements.
   - Refactor only after the relevant tests are green, and rerun the affected
     tests after each meaningful refactor.
   - Keep edits scoped to the active parent task and its subtasks.
   - Update `tasks.md` only after code and verification for that task are done.
   - If a task cannot be completed as written, leave it unchecked and add a
     short blocker note.

8. Decide commit granularity.
   - Commit only when the user requested commits or the repo workflow clearly
     expects task-run commits.
   - Prefer one commit per independently revertible parent task when it
     improves traceability, rollback, review, or bisectability.
   - Combine tasks into one commit when they are tightly coupled, touch the same
     files, or cannot pass validation independently.
   - Do not create commits that mix unrelated tasks, optional work, or purely
     mechanical cleanup with behavior changes.
   - If committing, include the task id or requirement id in the commit message
     when useful.

9. Verify and close out.
   - Run focused checks after each parent task.
   - Run the broadest practical validation suite before final response.
   - Re-read `tasks.md` and confirm completed tasks are checked, skipped
     optional tasks remain unchecked, and blockers are documented.
   - End with execution mode used, files changed, tasks completed,
     verification run, commits made if any, and remaining tasks or blockers.

## Task State Rules

- Mark a checkbox complete only when implementation and verification both
  passed.
- For TDD-executed tasks, include the final passing test or check in the task
  completion note when it helps a later agent resume or audit the work.
- Preserve task numbering and requirement traceability.
- Add concise implementation notes under a task only when they help the next
  agent resume work.
- Never mark an optional task complete as a substitute for required work.
- If a validation command cannot run, keep the task status honest and state the
  unverified risk.

## TDD Execution Rules

- Use one RED -> GREEN -> REFACTOR loop per behavior or risk.
- Start with the narrowest behavior that proves the task path works end to end.
- Prefer integration-style tests through public APIs, CLI commands, UI flows,
  service methods, or other stable repo boundaries.
- Keep mocks at system edges such as network, time, filesystem, or external
  services; do not mock internal collaborators just to make the implementation
  shape easier to assert.
- Do not mark a task complete while any test in its active TDD cycle is RED.
- If a task is already implemented, use the narrowest useful existing or new
  behavior check before marking it complete; do not add speculative tests just
  to perform ceremony.
- If automated testing is not feasible for a task, document why and run the
  closest meaningful static, build, manual, or smoke validation before updating
  `tasks.md`.

## Parallelism Heuristics

Safe candidates for the same parallel wave:

- Independent UI polish tasks on different components.
- Separate unit-test additions for already-stable APIs.
- Documentation or examples that do not depend on pending code changes.
- Independent adapters, providers, or feature flags with disjoint files.

Keep sequential:

- Schema, migration, model, or API contract changes.
- Shared utility or framework changes used by later tasks.
- Tasks whose tests require previous behavior to exist.
- Broad refactors, dependency upgrades, generated code, or formatting sweeps.
- Any task where rollback would be difficult if interleaved with another task.

## Quality Bar

The run is complete when every required task is either verified and checked off
or left unchecked with a concrete blocker, the implementation still matches
`requirements.md` and `design.md`, and the final validation result is clear.
