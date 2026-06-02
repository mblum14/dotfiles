---
name: to-req
description: Convert resolved product or engineering context into a Kiro-style requirements.md spec. Before drafting, prompt the user to either run the grill-me workflow first or bypass grill-me and create requirements.md directly, unless the current conversation already contains a completed grill-me or equivalent planning pass. Use when the user asks to create requirements, generate a requirements spec, write a Kiro requirements-first artifact, produce a .kiro specs requirements file, or explicitly says to use to-req; do not publish to an issue tracker or create a PRD.
---

# To Requirements

Create a focused Kiro Requirements-First `requirements.md` artifact from the
current conversation and repo context. Before drafting requirements, prompt the
user to either run the `$grill-me` workflow first or bypass `$grill-me` and
create `requirements.md` directly, unless the current conversation already
contains a completed `$grill-me` interview or equivalent planning pass. Use the
`$grill-me` philosophy as a requirements analysis discipline: interrogate every
meaningful branch of the plan until the requirements are coherent, answer
codebase-discoverable questions by inspecting the repo, and ask the user only
for a missing decision that would materially change the requirements.

## Workflow

1. Establish the target feature slug and output path.
   - Prefer an existing `.kiro/specs/<feature>/requirements.md` when the repo
     already has one.
   - Otherwise create `.kiro/specs/<feature-slug>/requirements.md`.
   - If the user names a different path, use that exact path.

2. Ground the requirements in the current repo.
   - Read nearby steering docs, existing specs, ADRs, domain glossary, README
     files, and similar feature code when present.
   - Preserve project vocabulary and established boundaries.
   - Treat a prior `$grill-me` conversation as resolved source material, not a
     prompt to restart questioning.

3. Prompt for the grill-me choice before drafting.
   - If the current conversation does not already contain a completed
     `$grill-me` interview or equivalent planning pass, ask the user whether
     they want to run `$grill-me` first or bypass `$grill-me` and create
     `requirements.md` directly.
   - Recommend running `$grill-me` when the feature intent, scope, actors,
     workflows, boundaries, or acceptance criteria are still materially
     under-specified.
   - If the user chooses `$grill-me`, ask the grill-me questions one at a time,
     following unresolved decision branches until the plan is coherent enough
     to write requirements.
   - If the user chooses to bypass `$grill-me`, proceed to draft
     `requirements.md` from the current conversation and repo context.
   - If a grill-me question can be answered by repo inspection or existing
     conversation context, answer it directly instead of asking the user.
   - Treat a completed `$grill-me` conversation as resolved source material,
     not a prompt to restart questioning.

4. Run a grill-me-style requirements interrogation pass.
   - Walk the plan's decision tree: actors, goals, permissions, workflows,
     states, boundaries, dependencies, failure modes, non-functional
     constraints, and out-of-scope behavior.
   - Resolve dependencies between decisions before drafting criteria that rely
     on them.
   - If a question can be answered by repo inspection or existing conversation
     context, answer it directly instead of asking the user.
   - When the intended answer is likely but not explicit, use a recommended
     assumption and make it visible in the requirements or open questions.
   - Ask the user one question at a time only when the answer would materially
     change the requirements.

5. Draft only `requirements.md`.
   - Do not create `design.md`, `tasks.md`, an issue, or a PRD unless the user
     explicitly asks.
   - Focus on externally observable behavior, user outcomes, constraints, edge
     cases, and acceptance criteria.
   - Avoid implementation recipes unless the user has already made a hard
     requirement decision.

6. Use the Kiro requirements format.
   - Read `references/kiro-requirements.md` when writing or reviewing the file.
   - Include the canonical headings in order: `# Requirements Document`,
     `## Introduction`, `## Glossary`, and `## Requirements`.
   - Keep the top-level heading exactly `# Requirements Document`; do not append
     the feature name, slug, or descriptive title to the H1.
   - Put the feature name and context in `## Introduction`, not in the document
     title.
   - Use numbered requirements with user stories and EARS-style acceptance
     criteria.
   - Prefer precise, testable statements over vague qualities such as "fast",
     "simple", or "robust".

7. Run a requirements analysis pass before finishing.
   - Check for logical conflicts, ambiguous terms, missing definitions, unstated
     assumptions, missing edge cases, and non-functional constraints.
   - Fix issues directly when the intended answer is clear from context.
   - Leave explicit open questions only when a decision cannot be inferred
     safely.

8. Report the created or updated path and any open questions.
   - Keep the final response short.
   - Mention that only requirements were created or changed.

## Output Shape

Use this structure exactly for Kiro IDE compatibility:

```markdown
# Requirements Document

## Introduction

<Short feature summary and problem context. Include the feature name here.>

## Glossary

- **<Term>**: <Definition used by this spec.>

## Requirements

### Requirement 1

**User Story:** As a <actor>, I want <capability>, so that <benefit>.

#### Acceptance Criteria

1. WHEN <trigger or condition> THEN the system SHALL <observable behavior>.
2. IF <state or exception> THEN the system SHALL <observable behavior>.
```

## Quality Bar

Requirements are done when a later design agent can derive architecture without
inventing product behavior, and an implementation agent can map tests back to
acceptance criteria without guessing. Before finishing, verify the document
does not trigger Kiro IDE diagnostics for a missing `# Requirements Document`
heading or missing `## Introduction` section.
