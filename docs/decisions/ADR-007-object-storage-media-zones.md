# ADR-007 — Use S3-Compatible Object Storage with Classified Media Zones

## Document control

| Field | Value |
|---|---|
| Status | Accepted |
| Date | 2 August 2026 |
| Decision owner | Kiarash Delavar, Engineering |
| Decision date | 2 August 2026 |
| Scope | Uploaded originals, derived/redacted media, overlays and PDFs |
| Depends on | Approved data-flow baseline and ADR-004 |

## Context

Images and PDFs are large, security-sensitive and governed differently from transactional records. Citizen uploads may contain faces, licence plates, EXIF, contact information or malicious file structures. A single public bucket or permanent URL could expose restricted originals. Storing binaries in PostgreSQL would blur backup, access, retention and delivery boundaries.

## Decision

Use a portable S3-compatible object-storage adapter.

Separate logical buckets or enforced prefixes/policies for:

- **restricted originals:** never publicly addressable;
- **controlled derived media:** redacted/processed artifacts requiring authorization;
- **approved public/demo derivatives:** only after publication checks;
- **evidence packages:** role-controlled, versioned outputs.

PostgreSQL stores object keys, classification, checksum, size/type, processing status, provenance, retention state and access/audit references. The object store never determines business visibility by itself.

Use short-lived, purpose-bound signed access issued after backend authorization. A pinned MinIO community image may be evaluated for local/demo use only after licence and maintenance review; the contract remains portable.

## Options considered

| Option | Result | Reason |
|---|---|---|
| S3-compatible adapter with zones | Selected | Portable binary storage with explicit policy boundaries |
| Public bucket plus obscured names | Rejected | Guessability is not authorization and originals could leak |
| Store all binaries in PostgreSQL | Rejected | Poor separation of access, retention and operational concerns |
| Local filesystem | Rejected beyond disposable development | Weak portability, concurrency and recovery story |
| Vendor-specific object APIs | Deferred | Avoid lock-in before hosting requirements exist |

## Consequences

### Positive

- Clear restricted/derived/public separation.
- Portable local and hosted implementations.
- Database keeps authoritative classification and provenance.
- Large objects avoid transactional row bloat.

### Costs and risks

- Database/object consistency requires careful workflows.
- Signed URLs can leak within their lifetime.
- Backup/restore must cover two systems coherently.
- Orphan cleanup and retention need explicit jobs/policies.

## Mandatory controls

1. Validate signature/magic bytes, decoded content, size, count and dimensions.
2. Generate non-meaningful object keys; never expose original filenames as paths.
3. No public access for restricted or controlled zones.
4. Backend authorizes every access and issues short-lived purpose-bound URLs.
5. Derivatives never overwrite originals; versions and checksums are preserved.
6. Public publication requires successful policy/redaction status.
7. Object references are scoped and audited.
8. Logs/Sentry/errors exclude URLs, keys and sensitive metadata.
9. Backup, restore, retention and orphan reconciliation are tested.

## Verification evidence

- Authorization tests across object classes and roles.
- Test proving restricted originals cannot be fetched anonymously or through a derived key.
- Malicious/unsupported upload tests.
- Expired/reused signed-access test.
- Database/object failure and reconciliation tests.
- Restore exercise checking checksums and classification.
- Publication-block test when redaction is failed/uncertain.

## Reconsider when

- approved hosting/security rules require another storage contract;
- database/object consistency cannot meet recovery objectives;
- data residency, encryption or key-management requirements change;
- local MinIO licensing/maintenance is unsuitable.

## Not authorized by this ADR

No provider, bucket, public media, retention period, encryption/KMS product or real upload is approved.

## Approval record

| Role | Name | Decision | Date | Notes |
|---|---|---|---|---|
| Product Owner / Engineering | Kiarash Delavar | Accepted | 2 August 2026 | Engineering direction approved; implementation and external assurance remain gated |
| Privacy/security/operations reviewers | Unassigned | Pending | — | Required before real media |
