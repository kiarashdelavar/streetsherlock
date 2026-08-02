# ADR-008 — Reserve Official Decisions for Authorized Humans

## Document control

| Field | Value |
|---|---|
| Status | Accepted |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Product / Domain |
| Decision date | 2 August 2026 |
| Scope | All StreetPulse and InfraProof decisions |
| Depends on | Approved charter, glossary and state machines |

## Context

StreetSherlock uses AI, similarity scoring, deterministic policies and computer vision to assist municipal work. These signals can be wrong, incomplete or biased. Automatically merging citizen Reports, assigning final priority, accepting repairs or implying contractor liability would create operational, legal and trust risks and contradict the approved product boundary.

Human oversight must be an executable domain rule—not a UI disclaimer.

## Decision

Only an authenticated, authorized human role may execute an official decision command.

Human-only decisions include:

- link, unlink or create an Incident from Reports;
- final operational priority and override;
- assignment, status, resolution, reopen and archive;
- inspection acceptance, rejection, rework or monitoring;
- recurrence relationship and warranty-case status;
- contractor/liability/enforcement interpretation;
- publication and approved external communication where policy requires.

AI, CV and deterministic engines create versioned recommendations/evidence. n8n transports an already authorized intent. The backend verifies role, scope, current version, reason and evidence, then records the decision and append-only audit history.

Refusal is first-class: a reviewer may reject, correct, defer or request more evidence without deleting the underlying Report or assessment.

## Options considered

| Option | Result | Reason |
|---|---|---|
| Human command for every official decision | Selected | Accountable, reviewable and consistent with product/legal uncertainty |
| Auto-merge above threshold | Rejected | False merge destroys trust and obscures separate Reports |
| Automatic final priority | Rejected | Policy/context ownership remains municipal and human |
| Automatic repair/warranty decision | Rejected | Could imply acceptance, liability or contractor fault |
| Human reviews only “low confidence” cases | Rejected | Confidence is not authority or legal basis |

## Consequences

### Positive

- Clear accountability and reversible operational choices.
- Model improvement cannot silently change authority.
- Failure paths remain usable without AI.
- Audit and appeal/correction evidence is preserved.

### Costs and risks

- Requires staff review capacity and careful UX.
- Recommendations can create automation bias.
- Role and policy ownership require municipal validation.
- Throughput may be lower than automatic handling.

## Mandatory controls

1. Separate recommendation/assessment state from human decision state.
2. Every decision records actor, role, time, reason, evidence, model/policy version where relevant, previous state and resulting state.
3. Commands enforce authorization and optimistic concurrency server-side.
4. Reports and previous assessment runs remain preserved.
5. UI uses “candidate”, “suggestion”, “possible” and “needs review”—never automatic certainty.
6. Bulk actions require the same authorization, reason and audit controls.
7. No workflow/provider credential can call a hidden bypass endpoint.
8. Overrides and rejections are measurable without punishing reviewers.

## Verification evidence

- Authorization matrix tests for every sensitive transition.
- Test proving recommendation success never changes official state.
- AI/CV/n8n outage tests with manual completion.
- Concurrent-decision conflict test.
- Audit reconstruction test.
- Accessibility/usability test showing recommendation and human decision are distinguishable.
- Negative tests for automatic merge, priority, acceptance and liability.

## Reconsider when

A future low-risk automation may be considered only through a new ADR, validated legal/domain authority, measured error/impact, opt-out/reversal, audit, monitoring and safe rollback. Contractor liability or rights-affecting decisions remain outside automatic scope.

## Not authorized by this ADR

No role assignment, municipal policy, legal basis, staffing model, pilot or automatic decision is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Accepted | 2 August 2026 | Engineering direction approved; implementation and external assurance remain gated |
| Municipal domain/legal/privacy reviewers | Unassigned | Pending | — | Required before operational use |
