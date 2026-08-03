# Backup and Recovery Assumptions

| Field | Value |
|---|---|
| Document ID | OPS-BR-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Approval | Product Owner approved 3 August 2026 |
| Scope | Sprint 0 assumptions and future evidence obligations |

## 1. Purpose and limitations

This baseline identifies what must be recoverable, what must not become a recovery authority, how a restore is kept isolated, and which decisions remain external.

No backup job or restore has been implemented or executed by this document. No RPO, RTO, retention duration, production readiness or real-data recovery claim is approved. All current portfolio data remains synthetic or an approved public snapshot.

## 2. Recovery principles

1. PostgreSQL is the sole authoritative business-state store.
2. A backup is untrusted until its integrity, environment identity and restore behavior are verified.
3. Restores occur into a new isolated target first; never overwrite a running target as the first step.
4. Environment and future tenant markers must match the approved restore plan or the restore aborts.
5. Object storage and database state are restored to a consistent point or media stays explicitly unavailable.
6. Restricted originals and public derivatives preserve separate zones, keys, access and lifecycle rules.
7. Encryption keys, credentials and tokens are not stored inside ordinary backups.
8. n8n execution history, caches, metrics, traces, Sentry and AI/vector outputs are not business-state recovery authorities.
9. Deleted personal data must not silently reappear: a restore replays the deletion/re-deletion ledger before release.
10. Recovery prioritizes safety and integrity over speed; no partially verified state is published.
11. Every exercise uses synthetic fixtures until real-data authorization and customer rules exist.
12. Failures preserve evidence, produce an explicit state and require a human release decision.

## 3. Recovery inventory

| ID | Component / artefact | Authority | Backup need | Restore rule | Classification |
|---|---|---|---|---|---|
| BR-A01 | PostgreSQL business schema/data | authoritative | required | restore first into isolated DB; validate migrations/invariants | Restricted/Internal |
| BR-A02 | Audit and outbox records in PostgreSQL | evidentiary/delivery state | required with DB | transaction-consistent with business state | Restricted/Internal |
| BR-A03 | Object-store restricted originals | authoritative content object | required only under approved policy | separate encrypted zone; never public | Restricted |
| BR-A04 | Safe derived/public media | derived artefact | required or reproducibly regenerated | validate provenance/publication decision | Public/Internal |
| BR-A05 | Object metadata, hashes and manifests | integrity/provenance | required | reconcile database and object inventory | Internal/Restricted |
| BR-A06 | Versioned policies/taxonomies/templates | authoritative configuration | required with DB/repository | validate referenced versions exist | Internal |
| BR-A07 | Source snapshots/fixture manifests | reproducible input | repository/approved artefact archive | verify SHA-256/licence/source status | Public/Internal |
| BR-A08 | Application source, migrations and IaC | release definition | Git + release artefacts, not DB backup | checkout signed/identified release | Public/Internal |
| BR-A09 | Model/prompt/dataset/workflow manifests | provenance | required manifests; artefact by policy | verify hash/version/approval | Internal |
| BR-A10 | Secrets/keys | security authority | separate managed mechanism | rotate/reissue; never restore from app archive | Secret |
| BR-A11 | n8n execution history | non-authoritative operational detail | optional/minimized by policy | do not reconstruct business state from it | Internal/Restricted |
| BR-A12 | Logs/metrics/traces/Sentry | non-authoritative telemetry | governed provider retention, not recovery source | do not replay into business state | Internal |
| BR-A13 | Caches/derived embeddings | rebuildable | normally no | regenerate from approved safe source/version | Internal |
| BR-A14 | CI ephemeral data | disposable | no | recreate | Synthetic |
| BR-A15 | Public tracking-token verifier material | access-control state | required if stored in DB; secrets separate | verify expiry/revocation and rotate if exposed | Secret/Restricted |

Exact inclusion and retention require the approved privacy schedule. Where deletion or backup policy is unresolved, the real-data path remains blocked.

## 4. Backup set and consistency assumptions

A recoverable release set references:

- release/build identifier and source commit;
- database backup identifier, schema/migration version and checksum;
- object manifest with zone, object ID, hash, classification and database reference;
- policy/taxonomy/template versions;
- source snapshot and fixture manifest versions;
- model/prompt/dataset/workflow manifests where relevant;
- environment identifier, created time, backup tool/version and encryption-key reference;
- previous successful verification and expiry status.

A database snapshot and object manifest need a declared consistency point. New uploads/publications during capture must be either included together or remain pending for reconciliation; never acknowledge an object as safely published from a database-only recovery.

## 5. Security controls

| Control ID | Requirement | Verification |
|---|---|---|
| BR-C01 | encryption in transit and at rest | configuration/evidence review |
| BR-C02 | backup access separate from routine application access | permissions matrix |
| BR-C03 | restore role separate and time-bounded where practical | access exercise |
| BR-C04 | immutable/isolated copy appropriate to measured risk | deletion/tamper test |
| BR-C05 | secret and encryption-key custody outside backup payload | archive scan |
| BR-C06 | environment/tenant binding in manifest and restore gate | wrong-target negative test |
| BR-C07 | integrity hash/signature and completeness manifest | corruption test |
| BR-C08 | backup actions and restores are audited without content leakage | audit review |
| BR-C09 | expired backups are destroyed under policy | lifecycle evidence |
| BR-C10 | suspected exposure triggers containment, key/token rotation and privacy/security review | tabletop |

The exact provider, region, key manager, immutability mechanism and administrator roles are pending.

## 6. Restore sequence

### 6.1 Preconditions

- approved incident/change ticket and accountable restore owner;
- selected known release and backup set;
- isolated target with no external email, webhook, public publication or source write-back;
- synthetic exercise dataset unless separately authorized;
- verified tool versions and access;
- communication and rollback/abandon criteria.

### 6.2 Procedure hypothesis

1. Record target environment, intended point and backup identifiers.
2. Verify manifest, expiry, hashes, encryption and environment/tenant markers.
3. Abort on missing, mismatched, expired, quarantined or unapproved artefacts.
4. Create a new isolated network/storage/database target.
5. Restore secrets through the separate approved mechanism or use exercise-only replacements.
6. Restore PostgreSQL without enabling traffic.
7. Apply only the migration path approved for the selected release.
8. Restore/reconcile object zones using the manifest.
9. Confirm restricted originals cannot resolve through public identities/URLs.
10. Replay the governed deletion/re-deletion ledger and verify expired/revoked tokens.
11. Rebuild only approved derived caches/embeddings; do not copy unknown derived state.
12. Run integrity, domain-invariant, authorization, audit/outbox, privacy-zone and fixture tests.
13. Run application smoke/hero recovery tests with external side effects disabled.
14. Compare counts, hashes, sampled relations and expected pending states.
15. Record result, gaps, evidence and human go/no-go decision.
16. Promote only through the normal reviewed release path; never expose the isolated target directly.
17. Destroy or retain the exercise target under the approved test-data policy.

### 6.3 Mandatory abort conditions

- environment/tenant mismatch;
- checksum/signature failure;
- unknown schema or missing migration;
- missing authoritative database segment;
- object/database mismatch that could expose or lose content;
- restricted/public boundary failure;
- deletion ledger cannot be applied;
- authorization/audit invariants fail;
- external side effects cannot be disabled;
- accountable reviewer unavailable for release decision.

## 7. Restore verification catalogue

| Test ID | Scenario | Expected result |
|---|---|---|
| BR-T01 | known-good synthetic full restore | all invariants pass in isolation |
| BR-T02 | corrupted backup segment | restore aborts before exposure |
| BR-T03 | wrong environment marker | restore aborts before mutation |
| BR-T04 | unknown/newer schema | restore stops with clear evidence |
| BR-T05 | missing object | DB record remains explicit/unavailable; no false public success |
| BR-T06 | restricted object requested publicly | denied |
| BR-T07 | previously deleted contact/media restored | re-deletion removes/blocks before release |
| BR-T08 | revoked/expired tracking token restored | remains revoked/expired |
| BR-T09 | outbox item at consistency boundary | no lost intent or duplicate final delivery |
| BR-T10 | AI/n8n/Sentry unavailable after restore | core human path remains usable |
| BR-T11 | secret absent from archive | separate injection/rotation succeeds |
| BR-T12 | abandoned exercise | isolated target is securely destroyed |

A test result records timing, but does not establish an RTO until an objective is approved.

## 8. Recovery tiers and ordering

| Tier | Capability | Reason |
|---|---|---|
| 0 | containment, identity/secrets decision and evidence preservation | prevent further harm |
| 1 | PostgreSQL, authorization, audit and core report/incident state | authoritative safe core |
| 2 | restricted object access and privacy processing | controlled evidence |
| 3 | safe derivatives/public tracking after validation | public continuity |
| 4 | source adapters, AI/embeddings and n8n delivery | degradable integrations |
| 5 | CV, analytics and later InfraProof helpers | later/non-core |

Tiering is a recovery order hypothesis, not a customer priority promise.

## 9. Failure and communication

| Failure | Safe response |
|---|---|
| backup job failed | alert owner; protect last verified copy; investigate; do not claim coverage |
| restore failed | keep target isolated; preserve logs; abandon safely; fix and repeat |
| exposure suspected | stop access; revoke/rotate; preserve safe evidence; notify privacy/security owners |
| corruption detected | quarantine set; select earlier verified set; record possible data loss |
| source/object mismatch | keep affected records unavailable/pending; reconcile manually |
| provider unavailable | use documented portable artefact/alternate target only after review |
| RPO/RTO missed | report measured result; do not hide or redefine target retroactively |

## 10. Open assumptions and decisions

| ID | Item | Current state | Owner/reviewer |
|---|---|---|---|
| OD-BR-01 | customer RPO | Unset | Municipality/product/platform |
| OD-BR-02 | customer RTO and recovery order | Unset | Municipality/operations |
| OD-BR-03 | retention/expiry by data class | Blocked | Privacy/FG/legal |
| OD-BR-04 | backup provider/region/replication | Unselected | Platform/security/privacy |
| OD-BR-05 | encryption and key custody | Unselected | Security/platform |
| OD-BR-06 | immutable copy and ransomware controls | Unselected | Security/platform |
| OD-BR-07 | support/restore roles and separation | Unassigned | Municipality/supplier |
| OD-BR-08 | deletion ledger design and archive exceptions | Blocked | Privacy/FG/legal |
| OD-BR-09 | object/database consistency mechanism | Proposed | Architecture/platform |
| OD-BR-10 | exercise cadence | Proposed per release gate | Product/platform |
| OD-BR-11 | shadow-pilot export recovery responsibilities | Unset | Customer/legal/platform |
| OD-BR-12 | incident notification and evidence retention | Unset | Privacy/security/legal |

## 11. Sprint/release gates

- Sprint 0: approve assumptions and verification backlog only.
- Sprint 1: create local/CI backup and restore skeleton issue; no real data.
- Before portfolio release: execute and publish a synthetic isolated restore result.
- Before shadow pilot: customer-approved RPO/RTO, retention, roles, provider, region, key custody, incident and deletion procedures.
- Before production: repeated measured exercises and independent security/privacy/operations acceptance.

## 12. Approval

| Role | Decision | Date | Scope |
|---|---|---|---|
| Product Owner | Approved | 3 August 2026 | Sprint 0 recovery assumptions and verification obligations only |
| Platform/SRE | Pending | — | backup architecture and exercises |
| Security reviewer | Pending | — | confidentiality, integrity and key custody |
| Privacy officer / FG | Pending | — | retention, deletion and restored personal data |
| Municipal operations owner | Pending | — | RPO/RTO, ownership and communication |
