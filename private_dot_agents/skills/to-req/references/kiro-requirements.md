# Kiro Requirements Reference

Use this reference when writing a Kiro-style `requirements.md` artifact. Keep
the actual spec concise; this file is guidance for the agent, not content to
copy into the output.

## Canonical Location

Kiro feature specs use three files under a feature-specific directory:

```text
.kiro/specs/<feature-slug>/requirements.md
.kiro/specs/<feature-slug>/design.md
.kiro/specs/<feature-slug>/tasks.md
```

This skill only creates or updates `requirements.md`.

## Requirements-First Intent

Requirements-First starts with what the system should do before deciding how to
build it. Use it when behavior is known, architecture can adapt to the need, or
the work is driven by product/customer outcomes.

The requirements phase should capture:

- User stories with clear actors, goals, and benefits
- Functional behavior
- EARS-style acceptance criteria
- Edge cases and error handling
- Relevant non-functional constraints
- Out-of-scope behavior when it prevents accidental expansion

## Recommended File Structure

Use this exact top-level shape for Kiro IDE compatibility. The H1 must be
exactly `# Requirements Document`; place the feature name in `## Introduction`
instead of writing a title such as `# Requirements: <Feature Name>`.

```markdown
# Requirements Document

## Introduction

One to three paragraphs explaining the feature name, user value, and important
context.

## Glossary

- **<Term>**: Definition of a domain term, actor, state, acronym, or external
  dependency used by this spec.

## Requirements

### Requirement 1

**User Story:** As a <actor>, I want <capability>, so that <benefit>.

#### Acceptance Criteria

1. WHEN <event or condition> THEN the system SHALL <observable response>.
2. IF <precondition or exceptional state> THEN the system SHALL <observable
   response>.
3. WHILE <ongoing state> THE SYSTEM SHALL <maintained behavior>.
```

Use one numbered requirement per coherent user need or system responsibility.
Keep each acceptance criterion independently testable.

Keep the canonical heading order as `Introduction`, `Glossary`, then
`Requirements`. Include `Glossary` even if it starts with only the key terms
needed to make the requirements unambiguous. Do not omit `Introduction`, and do
not rename the H1 to include the feature name.

## EARS Guidance

Prefer EARS-style statements because they are traceable and testable:

- `WHEN <trigger> THEN the system SHALL <response>`
- `IF <condition> THEN the system SHALL <response>`
- `WHILE <state> THE SYSTEM SHALL <response>`
- `WHERE <context> THE SYSTEM SHALL <response>`

Use exact actors, states, and outcomes. Replace vague terms with measurable
thresholds or concrete behavior. If a threshold is unknown and important, mark
it as an open question rather than inventing it.

## Analysis Checklist

Before finishing, review the whole requirements set for:

- Logical inconsistencies across requirements
- Ambiguous language that could lead to different implementations
- Conflicting functional and non-functional constraints
- Undefined concepts, roles, states, or dependencies
- Missing failure modes, empty states, permission cases, boundary cases, and
  concurrent access cases
- Implementation leakage that belongs in `design.md`
- Missing preservation requirements for existing behavior

## Source Notes

This guidance follows Kiro's public specs documentation:

- <https://kiro.dev/docs/specs/feature-specs/requirements-first/>
- <https://kiro.dev/docs/specs/analyze-requirements/>
- <https://kiro.dev/docs/specs/best-practices/>
