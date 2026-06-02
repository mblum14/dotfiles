---
name: to-design
description: Convert a confirmed Kiro-style requirements.md into a design.md technical design spec. Use after to-req or a confirmed requirements-first spec, when the user asks to create design.md, generate a Kiro design document, proceed from requirements to design, document architecture, sequence diagrams, implementation considerations, components, interfaces, error handling, or testing strategy; do not create tasks, issues, or a PRD.
---

# To Design

Create a focused Kiro Requirements-First `design.md` artifact from a confirmed
`requirements.md` and the current repo context. Do not reopen product
requirements by default; inspect the codebase, choose a feasible technical
approach, and ask only for missing decisions that would materially change the
architecture.

## Workflow

1. Establish the spec path.
   - Prefer an existing `.kiro/specs/<feature>/requirements.md` and write the
     sibling `.kiro/specs/<feature>/design.md`.
   - If the user names a different requirements file or output path, use that
     exact path.
   - If no confirmed requirements file exists, stop and ask for one or run
     `$to-req` first.

2. Read the confirmed requirements and local context.
   - Treat `requirements.md` as the source of product truth.
   - Read nearby `design.md` only if updating an existing design.
   - Inspect steering docs, ADRs, architecture docs, similar feature code, APIs,
     schemas, tests, and runtime/config boundaries before choosing the design.

3. Draft only `design.md`.
   - Do not create `tasks.md`, an issue, or a PRD unless the user explicitly
     asks.
   - Explain how the system will satisfy each requirement without restating the
     requirements file.
   - Prefer established project patterns over new abstractions.
   - Include implementation detail where it affects architecture, interfaces,
     data flow, errors, observability, security, or testing.

4. Use the Kiro design format.
   - Read `references/kiro-design.md` when writing or reviewing the file.
   - Include the canonical headings in order: `# Design Document`,
     `## Overview`, `## Architecture`, `## Components and Interfaces`,
     `## Data Models`, `## Correctness Properties`, `## Error Handling`, and
     `## Testing Strategy`.
   - Keep the top-level heading exactly `# Design Document`; do not append the
     feature name, slug, or descriptive title to the H1.
   - Put the feature name and context in `## Overview`, not in the document
     title.
   - Under `## Correctness Properties`, include at least one numbered
     `### Property N: <Name>` heading, followed by an exact bold validates line
     in this shape: `**Validates: Requirements X.Y**`.
   - Keep the whole validates marker inside the bold text. Do not bold only the
     `Validates:` label; Kiro IDE flags that shape as invalid.
   - Add Mermaid sequence diagrams when interaction order or service boundaries
     matter.

5. Run a design review pass before finishing.
   - Check that the design satisfies every requirement and acceptance criterion.
   - Check that technology choices are appropriate, non-functional requirements
     are addressed, and the approach is maintainable.
   - Remove speculative scope that is not needed for the confirmed requirements.
   - Leave explicit open questions only when implementation cannot proceed
     safely without a decision.

6. Report the created or updated path and any open questions.
   - Keep the final response short.
   - Mention that only the design artifact was created or changed.

## Output Shape

Use this structure exactly for Kiro IDE compatibility:

```markdown
# Design Document

## Overview

<Technical summary of the feature, approach, and key constraints. Include the feature name here.>

## Architecture

<System shape, boundaries, and major interactions. Include diagrams when useful.>

## Components and Interfaces

<Components, responsibilities, public interfaces, API contracts, and integration points.>

## Data Models

<Schemas, types, persistence shape, or external payloads.>

## Correctness Properties

### Property 1: <Name>

**Validates: Requirements X.Y**

<Invariants, consistency rules, ordering guarantees, and properties the design must preserve.>

## Error Handling

<Failure modes, fallback behavior, validation, retries, and user-visible errors.>

## Testing Strategy

<Unit, integration, contract, e2e, migration, or regression coverage needed.>
```

## Quality Bar

Design is done when an implementation agent can derive tasks without inventing
architecture, and every major design choice traces back to a confirmed
requirement, repo constraint, or explicit user decision. Before finishing,
verify the document does not trigger Kiro IDE diagnostics for a missing
`# Design Document` heading, missing `## Components and Interfaces`, missing
`## Data Models`, missing `## Correctness Properties`, or missing property
`**Validates: Requirements X.Y**` reference.
