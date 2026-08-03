# SLO and Observability Baseline

| Field | Value |
|---|---|
| Document ID | OPS-SLO-001 |
| Version | 0.1 |
| Status | Proposed |
| Owner | Kiarash Delavar |
| Approval | Pending |
| Scope | Portfolio Demo hypotheses; not production SLA |

## 1. Purpose

This document defines initial service-level indicators (SLIs), objective hypotheses (SLOs), telemetry boundaries, alert expectations and operational ownership. It does not promise continuous availability, contractual support or production capacity.

An SLO is a product reliability target measured from trustworthy telemetry. An SLA is a contractual commitment; StreetSherlock has no SLA. Error budgets are learning signals in the portfolio, not authorization to weaken safety or privacy controls.

## 2. Indicator rules

Each measurement record must contain:

- SLI ID and formula;
- build/release and environment;
- start/end time and sample count;
- fixture/dataset and workload profile;
- exclusions and missing data;
- raw result, objective and pass/fail;
- tool/query version and evidence link;
- owner and follow-up issue.

Synthetic tests, demo traffic and shadow-pilot traffic must never be silently combined. Missing telemetry is unknown, never healthy.

## 3. Initial SLI/SLO hypotheses

| ID | Capability | SLI formula | Objective | Window/profile | Exclusions | Owner |
|---|---|---|---|---|---|---|
| SLO-01 | Public report acceptance | persisted valid submissions / valid controlled attempts | ≥99% | controlled release test | invalid/rejected input by policy | Backend/QA |
| SLO-02 | Normal API latency | p95 server duration | <500 ms | seeded profile per release | AI/external calls; declared warm-up | Backend |
| SLO-03 | Map query latency | p95 bounded-box duration | <1 s | chosen snapshot/profile | unbounded/invalid queries | Backend/GIS |
| SLO-04 | Duplicate result | p95 time to first candidate set | <3 s | precomputed embeddings, controlled profile | cold embedding creation | Data/Backend |
| SLO-05 | Workflow delivery correctness | approved intents with exactly one final delivery / approved intents | 100% | retry/replay fixture | none | Backend/Platform |
| SLO-06 | Audit coverage | expected critical audited transitions with complete envelope / expected transitions | 100% | critical-path suite | none | Backend/QA |
| SLO-07 | Privacy publication safety | unsafe or uncertain derivatives published | 0 | governed evaluation fixtures | none | Privacy/QA |
| SLO-08 | Authorization isolation | unauthorized successful accesses | 0 | role/entity/purpose matrix | none | Security/QA |
| SLO-09 | Recovery behavior | injected dependency failures retaining valid authoritative state and visible recovery / scenarios | 100% | resilience suite | none | Platform/QA |
| SLO-10 | Clean-clone reproducibility | successful declared clean-clone runs / attempted supported runs | 100% | release candidate | undeclared host profiles | Platform |
| SLO-11 | Backup restore integrity | verified isolated restores / scheduled portfolio exercises | 100% once exercises start | per release gate | no target yet in Sprint 0 | Platform |
| SLO-12 | Telemetry privacy | tested prohibited-value canaries absent from outputs / canaries | 100% | telemetry scrub suite | none | Platform/Privacy |

SLO-11 has no time-based RPO/RTO objective until the Product Owner and relevant customer/platform/privacy reviewers approve context. A restore test may pass without establishing customer recovery objectives.

## 4. Supporting indicators

| ID | Signal | Purpose |
|---|---|---|
| SLI-API-01 | request count/status/duration by allowlisted route template | availability and latency |
| SLI-DB-01 | pool saturation, query duration, migration state | database health |
| SLI-OBJ-01 | upload/read/delete outcomes without object key leakage | storage health |
| SLI-OUTBOX-01 | pending age, attempts, dead-letter/manual state | delivery recovery |
| SLI-AI-01 | duration, timeout, refusal, invalid schema and model version | advisory-provider behavior |
| SLI-CV-01 | queue age, quality refusal, failure and version | later vision behavior |
| SLI-SOURCE-01 | freshness, last success, quota/error and snapshot ID | external context quality |
| SLI-PRIV-01 | transformation state, uncertainty and publication decision | privacy gate |
| SLI-AUDIT-01 | expected/actual envelope completeness | accountability |
| SLI-UX-01 | failure/retry state completion in synthetic journeys | recoverable usability |

Business acceptance and human overrides are evaluation/product metrics, not service availability.

## 5. Telemetry layer boundaries

| Layer | Purpose | May contain | Must not contain | Authority |
|---|---|---|---|---|
| Business audit | official access, action and decision evidence | actor ID, role, reason, entity ID, version, time, correlation | secrets; unnecessary raw content | evidentiary record, not current-state store |
| Operational logs | diagnose system behavior | event name, route template, status, duration, correlation | report text, contact, tokens, auth headers, raw coordinates/media URLs | none |
| Metrics | aggregate health and quality | counts, durations, queue depth, version labels | high-cardinality personal/entity values | none |
| Traces | correlated technical path | service/span, timings, sanitized error class | request/response bodies, prompts, media, secrets | none |
| Sentry | scrubbed application errors/releases/traces | error class, release, environment, correlation, safe tags | citizen content, contact, tokens, sensitive coordinates, URLs, auth | none |
| Evaluation telemetry | versioned model/quality evidence | aggregate metrics, governed fixture IDs, model/prompt version | unrestricted operational-data collection | none |
| n8n history | workflow diagnosis | minimized reference, attempt/status | business truth, citizen PII, broad payloads, secrets | none |

PostgreSQL remains the sole business-state authority. Audit records prove actions; they do not permit reconstructing current state by guessing. Sentry is not an audit log. n8n is not a queue/source of truth.

## 6. Correlation and labels

Every applicable request/job/workflow includes a generated correlation ID. Logs, traces, safe error feedback and workflow receipts use it without exposing public tracking tokens.

Allowed low-cardinality tags include:

- environment and release;
- module and sanitized operation;
- assessment/workflow type;
- synthetic demo municipality ID;
- model/prompt/policy/dataset/workflow version;
- result class such as success, refused, timeout, invalid or unavailable.

Entity IDs, email, free text, precise coordinates, tokens and object keys are not metric tags.

## 7. Health model

| Check | Meaning | Failure behavior |
|---|---|---|
| Liveness | process can respond | restart only when truly stuck |
| Readiness | process can safely accept its core work | remove from traffic; do not lose accepted state |
| Dependency health | DB/storage/provider/source/workflow condition | show degraded/unknown; preserve manual path |
| Migration state | expected schema is installed | block unsafe promotion |
| Fixture/source freshness | context age and provenance | mark stale; do not invent current facts |

AI, vision, n8n, Sentry or public-source failure does not make the core database process dead. Database unavailability makes write readiness fail.

## 8. Alert hypotheses

| Alert ID | Trigger hypothesis | Severity | Immediate safe action |
|---|---|---|---|
| ALT-01 | suspected data exposure or authorization bypass | SEV-1 | contain path, revoke, preserve safe evidence |
| ALT-02 | destructive corruption or unsafe autonomous decision | SEV-1 | stop mutation path, preserve state |
| ALT-03 | intake/decision/recovery unavailable without workaround | SEV-2 | disable unsafe entry, communicate recovery |
| ALT-04 | object store outage with pending uploads/publication | SEV-3 unless loss suspected | block false success, retry/manual |
| ALT-05 | AI/CV outage or malformed spike | SEV-3 | disable provider, route manual |
| ALT-06 | n8n outage/replay/duplicate risk | SEV-3 or SEV-1 if unsafe send | pause dispatch, retain outbox |
| ALT-07 | source stale/quota exceeded | SEV-3 | use approved snapshot/unknown marker |
| ALT-08 | telemetry suspected PII leak | SEV-1 | disable export, contain and review |
| ALT-09 | backup failure or restore verification failure | SEV-2/3 by exposure and recoverability | protect last good copy, investigate |
| ALT-10 | upload abuse/capacity spike | SEV-3 | rate-limit/quarantine without broad access |

Thresholds require measured baselines. Do not create noisy paging promises before an accountable rota exists.

## 9. Runbook minimum structure

Future runbooks cover database/migration, object storage, AI, vision, n8n, Dutch sources, Sentry leakage/outage, outbox backlog, backup/restore, key rotation, rollback and upload abuse.

Each must state detection, user impact, safe degradation, diagnosis, containment, recovery, verification, communication, evidence and follow-up owner.

## 10. Review cadence

- per PR: changed signals, scrub impact and applicable SLO evidence;
- per release candidate: objective results and known failures;
- monthly during active portfolio development: target usefulness and measurement bias;
- after incident, provider/environment change or new personal-data path: immediate review;
- before shadow pilot: replace portfolio hypotheses with customer-approved objectives and ownership.

## 11. Open decisions

| ID | Decision | Required reviewer |
|---|---|---|
| OD-SLO-01 | customer availability window and maintenance treatment | Municipality/operations |
| OD-SLO-02 | workload, volume and geography profiles | Product/municipality |
| OD-SLO-03 | Sentry/telemetry providers, region, retention and processors | Privacy/platform |
| OD-SLO-04 | alert routing, on-call ownership and communication | Operations/municipality |
| OD-SLO-05 | customer RPO/RTO and recovery priority | Platform/privacy/municipality |
| OD-SLO-06 | production error-budget policy | Product/operations/security |

## 12. Approval

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Pending | — | Portfolio SLI/SLO hypotheses and observability boundary |
| Platform/SRE | Pending | — | Measurement and response design |
| Security reviewer | Pending | — | security signals and exposure alerts |
| Privacy officer / FG | Pending | — | telemetry content/processor choices |
| Municipal operations owner | Pending | — | customer objectives and response ownership |
