# ADR-005 — Use Local AI Behind a Replaceable Provider Interface

## Document control

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering / AI-data |
| Target review | 3 August 2026 |
| Scope | Structured intake assistance, embeddings and later approved-fact drafting |
| Depends on | Privacy boundaries, ADR-004 and ADR-008 |

## Context

StreetSherlock benefits from language normalization, structured extraction and semantic retrieval, but citizen content is untrusted and may contain personal data or prompt-injection text. Model output is probabilistic and cannot be an official municipal decision. CI and manual review must continue when a model is absent, slow, malformed or unsuitable.

A local provider improves demo control and data minimization, but “local” alone does not make a model accurate, lawful, secure or operationally safe.

## Decision

Define provider-neutral interfaces such as `AiTextProvider` and `EmbeddingProvider`.

Use Ollama as the default local development/demo implementation only after exact model, digest/version and licence review. Use a deterministic provider in CI. A hosted provider may be benchmarked later only through the same boundary and only with separately approved minimized/redacted inputs.

Model requests receive structured task instructions and approved minimized data. Responses must pass strict JSON Schema/Pydantic-style validation and a second Java domain validation. Every run records provider, model, prompt/template version, schema version, input representation reference, latency, outcome, limitations and error class.

AI output creates an `AssessmentRun` and recommendations. It cannot merge Reports, set final priority, transition an Incident, accept work, assign liability, open a warranty claim, publish content or trigger n8n.

## Options considered

| Option | Result | Reason |
|---|---|---|
| Replaceable interface + local Ollama | Selected | Reproducible local story with explicit portability and data minimization |
| Direct Ollama calls throughout code | Rejected | Provider coupling, weak testing and inconsistent safeguards |
| Hosted provider only | Rejected for MVP | Transfer, privacy, availability and cost questions are unresolved |
| Deterministic rules only | Retained fallback | Required for CI and safe manual operation, but less useful for language assistance |
| Autonomous agent workflow | Rejected | Conflicts with human authority and bounded product scope |

## Consequences

### Positive

- Provider can be mocked, replaced and compared.
- Local demo does not depend on external AI availability.
- Inputs/outputs are versioned and auditable.
- Manual/deterministic fallback is first-class.

### Costs and risks

- Local models need memory/CPU/GPU and may perform inconsistently.
- Model/dataset licences and security still require review.
- Prompt/schema maintenance becomes controlled configuration.
- Evaluation work is required before capability claims.

## Mandatory controls

1. Minimize/redact inputs before model access where sufficient.
2. Treat citizen text as data, never instructions.
3. No tool use, database access or workflow credentials for the model.
4. Strict schema and enum/range/coordinate validation in Java.
5. Timeout, refusal, malformed and unavailable outcomes route visibly to human review.
6. Store assessment provenance and preserve prior runs.
7. Apply deterministic filters before vector ranking.
8. Human approval is required for later drafted text.
9. Never send automatically.

## Verification evidence

- Deterministic CI provider contract suite.
- Golden Dutch/English extraction cases.
- Prompt-injection and malformed-output tests.
- Timeout/unavailable resource tests proving the Report persists.
- Schema/domain rejection tests.
- Evaluation report with supported/unsupported claims and model version.
- Audit test linking recommendation to human disposition.

## Reconsider when

- evaluation shows no material product benefit;
- resource cost prevents the agreed demo/SLO;
- privacy/legal review disallows the processing path;
- another provider is measurably safer or more reliable without weakening portability;
- an AI use would require autonomous authority.

## Not authorized by this ADR

No exact model, personal-data use, hosted provider, production inference, automated decision or AI-accuracy claim is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Pending | — | Provider pattern only |
| AI/data, privacy, legal and security reviewers | Unassigned | Pending | — | Required before model/data promotion |
