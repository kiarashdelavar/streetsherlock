# Hero Acceptance Test Contract

| Field | Value |
|---|---|
| Document ID | QA-HERO-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Approval | Product Owner standing authorization — 3 August 2026 |
| Current execution state | Not Run — implementation pending |
| Source | Master Project Specification v2.0; approved hero flow, requirements, architecture, threat, privacy and UX baselines |

## 1. Purpose

This document freezes the executable acceptance contract for the StreetSherlock hero story. Approval means the scenarios, evidence rules and authority boundaries are accepted. It does not mean the application exists or any scenario has passed.

A scenario becomes **Verified** only when an identified build is executed in a named environment with the declared fixture manifest and retained machine-readable evidence. Screenshots may support UX review but cannot prove authorization, privacy, state integrity, idempotency or recovery.

## 2. Fixed test data boundary

All runs use synthetic Deventer scenarios or separately approved, precisely licensed public fixtures. No real citizen, contractor, municipal or KLIC data is permitted.

The canonical fixture contains:

- one synthetic municipality and approved demo roles;
- one cycle-path work polygon, contractor alias, completion event, accepted repair evidence and active warranty;
- three separate Dutch/English reports near the same location after synthetic rainfall;
- one deliberately sensitive test image derived for redaction testing, never a real person or plate;
- one accepted post-repair image and one comparable current image;
- deterministic weather, map, embedding, AI, CV, mail and workflow-provider fixtures;
- a provenance manifest with source ID, licence decision, SHA-256, capture/generation date and expected use.

Every source report remains a separate authoritative record even after a human links it to an incident.

## 3. Result vocabulary

| Result | Meaning |
|---|---|
| Not Run | no execution evidence exists |
| Blocked | prerequisite or approved fixture is unavailable |
| Pass | expected result and required evidence are present |
| Fail | behavior or evidence differs from this contract |
| Invalid | run used wrong build, environment, data or configuration |

A partial happy path is not a pass. An outage scenario that fails visibly and preserves authority may pass its safe-degradation expectation.

## 4. Hero scenario matrix

| ID | Hero step and observable outcome | Authority / safety assertion | Required evidence |
|---|---|---|---|
| HAT-001 | Seed a completed street work, footprint, repair, evidence and warranty | PostgreSQL owns business state; synthetic provenance visible | fixture manifest, row/API assertions, audit events |
| HAT-002 | Submit three distinct reports after rainfall | reports remain distinct; language and event time retained | request/response records, database assertions |
| HAT-003 | Validate upload, separate restricted original, redact derivative and create structured facts | unsafe media cannot publish; raw personal data does not reach advisory provider | object-zone assertions, transformation/audit records, negative telemetry scan |
| HAT-004 | Produce duplicate candidates from spatial, time, category, semantic and repair evidence | candidate is advisory; score breakdown and uncertainty visible | deterministic score assertions, provider/model/version provenance |
| HAT-005 | Intake employee confirms one incident from three reports | human decision required; no report deleted; link reversible and audited | authorization test, before/after state, audit and link history |
| HAT-006 | Explain deterministic priority from verified facts | LLM cannot set final priority; policy/version visible | calculation trace, policy version, UI/API assertion |
| HAT-007 | Detect possible active-warranty recurrence | flag is advisory and does not punish contractor or approve payment | overlap/window evidence, human-review state |
| HAT-008 | Inspector captures comparable current evidence | quality guidance is advisory; unsuitable evidence can be refused | capture metadata, quality checks, accessible instructions |
| HAT-009 | Align accepted and current images and show suspicious regions | limitations and confidence visible; no structural/legal claim | CV input/output hashes, model version, limitation state |
| HAT-010 | Inspector accepts, monitors or requests rework | authenticated human decision is authoritative and audited | role/authorization evidence, decision/audit record |
| HAT-011 | Draft factual report from validated structured data | draft cannot mutate state or bypass human edit/approval | redacted provider input, schema validation, draft/approved diff |
| HAT-012 | Create PDF package and transactional outbox event | package is immutable/versioned; outbox commit is atomic with state | PDF hash, package manifest, transaction/outbox assertions |
| HAT-013 | Deliver signed idempotent event through n8n/Mailpit and callback | duplicate delivery causes one final effect; n8n is not source of truth | signature, replay test, attempt log, callback/state assertions |
| HAT-014 | Display complete timeline | facts, advisory outputs, human decisions, privacy actions and failures are distinguishable | ordered audit/timeline export, correlation IDs, UI assertions |

## 5. Mandatory negative and recovery scenarios

| ID | Trigger | Expected safe behavior |
|---|---|---|
| HAT-N01 | invalid MIME/signature, oversized image or decompression risk | reject before processing; no unsafe object or provider call |
| HAT-N02 | unauthorized role or changed object ID | deny by default; no content leak; audited correlation |
| HAT-N03 | tracking token guessed, expired, revoked or rate-limited | deny generically; no existence or identity disclosure |
| HAT-N04 | redaction uncertain or fails | block publication and route to human privacy review |
| HAT-N05 | Ollama/embedding provider timeout or invalid schema | preserve report; show unavailable/manual path; no invented facts |
| HAT-N06 | duplicate score is high but human rejects link | preserve separate reports/incidents and audit override |
| HAT-N07 | priority inputs missing | explain missing facts and route to human decision; no LLM fallback priority |
| HAT-N08 | CV image unsuitable or alignment fails | refuse/limit comparison and require new capture or manual inspection |
| HAT-N09 | PDF generation fails | retain approved decision; expose retry/manual recovery; no outbox delivery |
| HAT-N10 | n8n unavailable or callback times out | outbox retries visibly; no lost state and no direct workflow-owned status |
| HAT-N11 | same signed event delivered repeatedly | one final external effect and idempotent callback |
| HAT-N12 | signature invalid, stale or wrong environment | reject without state mutation; alert/audit safely |
| HAT-N13 | public derivative or telemetry contains restricted marker | test fails and publication/release is blocked |
| HAT-N14 | concurrent human decisions conflict | optimistic/concurrency control prevents silent overwrite |
| HAT-N15 | map, GPS or pointer interaction unavailable | equivalent keyboard/screen-reader list/manual location path works |

## 6. Evidence record

Each result records:

- evidence ID, scenario ID and related requirement/test IDs;
- repository commit, build/container digests and dirty-state assertion;
- Local/CI/Demo environment and configuration fingerprint;
- fixture-manifest version and hashes;
- start/end time, executor and command/test path;
- expected versus actual result;
- machine-readable logs/reports with secret and restricted-data scan;
- screenshots only where visual behavior is material;
- limitations, failure issue and reviewer decision.

Artefacts must not contain credentials, tokens, personal data or unrestricted originals.

## 7. Exit rules

The future hero release gate passes only when HAT-001..014 and applicable negative scenarios pass on one identified candidate, with no open critical/high safety, privacy, authorization or integrity failure. Accepted lower risks must name owner, reason, expiry and remediation issue.

This Sprint 0 package itself passes when the contract is complete, traceable and approved. Current software execution remains **Not Run**.

## 8. Approval boundary

Product Owner approval dated 3 August 2026 covers this acceptance structure, fixed hero semantics, evidence minimum and safe-failure rules. It does not approve implementation, test results, real data, deployment, compliance, production readiness or independent municipal/privacy/security/accessibility/legal conclusions.
