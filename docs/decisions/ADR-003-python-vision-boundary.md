# ADR-003 — Isolate Computer Vision in a Stateless Python/FastAPI Service

## Document control

| Field | Value |
|---|---|
| Status | Accepted |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering / AI-data |
| Decision date | 2 August 2026 |
| Scope | Later InfraProof image processing only |
| Depends on | ADR-001 and approved StreetPulse/InfraProof cut line |

## Context

Image decoding, quality analysis, redaction helpers, alignment, overlays and narrow defect evaluation benefit from Python, OpenCV, PyTorch and their evaluation ecosystem. Moving all business logic to Python would split authority and transactions. Putting those libraries into the Java process would complicate packaging and isolate poorly from hostile or resource-heavy media.

Computer vision is not required for the first StreetPulse MVP and must not become a blocker for the manual workflow.

## Decision

Create a separate internal Python service using FastAPI and Pydantic only for stateless, versioned vision assessments.

The Java backend:

- authorizes the business request;
- owns jobs, object references, assessment lifecycle and all durable business state;
- provides short-lived access to approved objects;
- validates the returned schema;
- stores output as advisory assessment evidence;
- records the human disposition.

The vision service:

- validates and safely decodes supported media;
- calculates capture-quality results before analysis;
- returns explicit refusal/failure/limitation states;
- may create derived overlays through an authorized object-storage path;
- never accepts a repair, changes an Incident, opens a warranty claim or contacts a contractor.

## Options considered

| Option | Result | Reason |
|---|---|---|
| Stateless FastAPI service | Selected | Fits Python CV ecosystem while preserving Java business authority |
| Embed Python in Java process | Rejected | Fragile runtime boundary and poor resource/failure isolation |
| Put all backend logic in Python | Rejected | Duplicates or moves transactional domain authority |
| Hosted third-party vision API | Deferred | Privacy, transfer, cost and reproducibility questions are unresolved |
| No vision service | Valid MVP fallback | StreetPulse and manual inspection must still function |

## Consequences

### Positive

- Python-native experimentation and evaluation.
- Clear resource/security boundary for untrusted media.
- Service can be omitted from MVP and scaled separately later.
- Versioned outputs support reproducibility.

### Costs and risks

- Adds an internal network contract and another runtime.
- Object-access and service authentication must be designed.
- Deployment/observability become more complex.
- Model and library supply-chain risks require separate controls.

## Mandatory controls

1. Internal authenticated endpoint namespace, initially `/internal/v1`.
2. Strict request size/type limits and decoded-image safety checks.
3. Timeouts, concurrency/resource limits and cancellation.
4. No direct business-database credentials.
5. No permanent public object URL.
6. Versioned model, preprocessing, schema and output metadata.
7. Human review for every operational interpretation.
8. Manual path remains visible on failure or absence.

## Verification evidence

- Contract tests shared between Java and Python.
- Malformed, oversized, decompression-bomb and unsupported-file tests.
- Golden tests for quality, valid alignment, refusal and unrelated images.
- Timeout/crash test showing the Java assessment becomes failed/timed-out without changing domain state.
- Authorization test proving the service cannot retrieve arbitrary objects.
- Evaluation card with limitations before model promotion.

## Reconsider when

- no approved InfraProof story needs Python-specific capabilities;
- a maintained in-process or portable alternative materially reduces risk;
- isolation, latency or hosting requirements demand job workers/queues;
- real-data rules prohibit the selected processing environment.

## Not authorized by this ADR

No CV model, dataset, hosted provider, repair decision, pilot or production deployment is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Accepted | 2 August 2026 | Engineering direction approved; implementation and external assurance remain gated |
| AI/data, privacy and security reviewers | Unassigned | Pending | — | Required before real images or model claims |
