# Fixture Strategy and Manifest Contract

| Field | Value |
|---|---|
| Document ID | SS-DATA-003 |
| Work item | E00-07 |
| Version | 0.1 |
| Status | Proposed |
| Owner | Kiarash Delavar |
| Review date | 2 August 2026 |
| Approval | Pending Product Owner approval |
| Related documents | SS-DATA-001 and SS-DATA-002 |

## 1. Goal

StreetSherlock must be runnable and testable without live external services. This document defines how later stories will create small, repeatable, attributable and integrity-checked fixtures.

E00-07 creates the contract only. It does not download, generate or commit fixture payloads.

## 2. Fixture principles

1. One fixture has one stable ID, purpose and owner.
2. Synthetic and public-source payloads never share an origin label.
3. Every public fixture is a minimal, bounded snapshot—not a mirror.
4. Raw download, transformed fixture and derived evaluation artefact have separate checksums and lineage.
5. Fixture generation is explicit and reviewable; application startup never fetches external data.
6. CI accepts only committed/approved fixtures or separately pinned test artefacts.
7. Canonical ordering and serialization make rebuilds reproducible.
8. A checksum, manifest, schema, licence or privacy failure quarantines the fixture.
9. Golden evaluation data is not training data.
10. Deleting/rebuilding a fixture must be documented and testable.

## 3. Planned repository layout

```text
fixtures/
  synthetic/
    FIX-SYN-DEV-HERO-001/
      manifest.json
      scenario.json
      media/
  public/
    <source_id>/
      <fixture_id>/
        manifest.json
        NOTICE.md
        data/
  schemas/
    fixture-manifest.schema.json
    synthetic-scenario.schema.json
```

Large/raw artefacts may later use release artefacts or object storage rather than Git. Their manifest remains versioned and pins a content hash and retrieval procedure.

## 4. Manifest contract

Every fixture manifest must contain:

```json
{
  "manifest_version": "1.0",
  "fixture_id": "FIX-KNMI-RAIN-001",
  "title": "Bounded KNMI rainfall window for the hero acceptance test",
  "status": "proposed",
  "owner": "Kiarash Delavar",
  "source_id": "SRC-KNMI-10M",
  "data_origin": "public-open",
  "synthetic": false,
  "purpose": ["hero-acceptance", "weather-rule-test"],
  "requirements": ["NL-06", "NFX-01"],
  "source": {
    "publisher": "KNMI",
    "dataset_name": "Near real-time 10-minute automated in-situ meteorological observations",
    "dataset_version": "1.0",
    "authoritative_url": "https://dataplatform.knmi.nl/dataset/10-minute-in-situ-meteorological-observations-1-0",
    "distribution_url": "recorded-at-generation-time",
    "licence_or_rights_id": "CC-BY-4.0",
    "licence_or_rights_url": "https://creativecommons.org/licenses/by/4.0/",
    "attribution_text": "Source: KNMI",
    "terms_reviewed_at": "UTC timestamp"
  },
  "scope": {
    "geography": "named bounded area/stations",
    "bbox": null,
    "time_start": "UTC timestamp",
    "time_end": "UTC timestamp",
    "fields": [],
    "record_count": 0
  },
  "time_semantics": {
    "event_field": null,
    "observation_field": "publisher field",
    "publication_field": null,
    "retrieved_at": "UTC timestamp",
    "ingested_at": "UTC timestamp"
  },
  "spatial": {
    "source_crs": "publisher CRS",
    "target_crs": "EPSG:28992",
    "web_crs": "EPSG:4326",
    "transform_tool": "name and version"
  },
  "build": {
    "generator_command": "future deterministic command",
    "generator_git_sha": "full SHA",
    "adapter_version": "version",
    "input_schema_version": "version",
    "output_schema_version": "version",
    "canonicalization_version": "version"
  },
  "integrity": {
    "source_sha256": "lowercase hex or null when source is an API response stream",
    "fixture_sha256": "lowercase hex",
    "files": []
  },
  "classification": {
    "class": "public",
    "contains_personal_data": false,
    "contains_restricted_media": false,
    "contains_controlled_operational_data": false
  },
  "review": {
    "field_minimization": "pending",
    "licence_terms": "pending",
    "privacy": "pending",
    "redistribution": "pending",
    "approved_by": null,
    "approved_at": null
  },
  "limitations": [],
  "lineage_parent_fixture_ids": [],
  "deletion_and_rebuild": {
    "delete_command": "future safe command",
    "rebuild_command": "future deterministic command"
  }
}
```

A manifest status may be `proposed`, `approved`, `quarantined`, `superseded`, or `retired`.

## 5. Fixture catalogue

| Fixture ID | Source | Purpose | Planned content | State |
|---|---|---|---|---|
| FIX-SYN-DEV-HERO-001 | SRC-SYN-DEV | Full hero acceptance flow | Six categories, three related reports, one incident, privacy case, failure/recovery states | Planned |
| FIX-SYN-DEV-AUTH-001 | SRC-SYN-DEV | Authorization negative tests | Fictional roles, tenant-shaped IDs and prohibited cross-role access cases | Planned |
| FIX-AMS-MORA-EVAL-001 | SRC-AMS-MORA | Offline duplicate/category evaluation | Minimal dated Amsterdam subset; no contact, unreviewed media or unrestricted text | Conditional on field review |
| FIX-PDOK-BGT-DEV-001 | SRC-PDOK-BGT | Public-space object context | Minimal demo bbox and selected object classes | Conditional on exact query |
| FIX-PDOK-BAG-DEV-001 | SRC-PDOK-BAG | Address/building fallback test | Minimal selected collections and bbox | Blocked pending rights/metadata manifest review |
| FIX-AHN6-DEV-001 | SRC-AHN6 | Elevation-context limitation test | Small edition/tile crop plus capture metadata | Conditional on proportional feature need |
| FIX-BRO-GM-OV-001 | SRC-BRO-GM | Ground-context research | Minimal regional characteristics | Deferred until a concrete V1 feature |
| FIX-KNMI-RAIN-001 | SRC-KNMI-10M | Rain-to-drain/hero weather evidence | Bounded station/time window with quality flags | Planned |
| FIX-CLIMATE-WATER-001 | SRC-CLIMATE-ATLAS | Indicative waterlogging context | One exact selected layer and small crop | Blocked pending layer selection |
| FIX-KLIC-MOCK-001 | SRC-KLIC-MOCK | Controlled-source adapter contract | Purely fictional schema-shaped records | Planned for later adapter |
| FIX-AMS-WIOR-001 | SRC-AMS-WIOR | Work-footprint context | None | Blocked |
| FIX-NDW-MOBILITY-001 | SRC-NDW-MOBILITY | Cycle/roadwork context | None | Blocked |
| FIX-KLIC-REAL-001 | SRC-KLIC-REAL | None in portfolio | None | Prohibited |

## 6. Deterministic synthetic fixture

The synthetic generator must accept a fixed seed and scenario clock.

```text
input:
  seed
  scenario_version
  base_time
  locale set
  category set

output:
  canonical JSON
  deterministic IDs
  stable geometry
  non-routable contacts
  media references
  expected decisions and failure states
  manifest and checksums
```

Expected decisions are test assertions, not hidden application state. The generator must not call an LLM, a geocoder, live map service, or random web source.

## 7. Public snapshot build stages

```text
source review valid
→ explicit maintainer fetch
→ temporary raw quarantine
→ signature/content/schema checks
→ field allowlist and spatial/time bound
→ deterministic transform
→ canonical sort/serialization
→ manifest + SHA-256
→ privacy/licence/redistribution review
→ approve fixture
→ tests and demo may consume it
```

Raw temporary content is deleted after an approved transformed fixture is produced, unless a separately approved retention purpose requires it.

## 8. Integrity rules

- Use SHA-256 for every committed file and the canonical fixture set.
- Verify checksums before tests or seed import.
- Do not execute code, templates, macros or links from a fixture.
- Parse data with size, depth, record-count and decompression limits.
- Reject path traversal, absolute paths, symlinks and duplicate normalized filenames.
- Reject unexpected fields unless a schema review approves the change.
- Record content type based on validated content, not filename alone.
- Quarantine rather than partially accepting a failed snapshot.

## 9. Canonicalization rules

For reproducible checksums:

- UTF-8 without BOM;
- LF line endings;
- stable key and record ordering;
- UTC ISO-8601 timestamps;
- explicit `null` for unknowns;
- documented numeric precision;
- no volatile request IDs, signed URLs or access tokens;
- normalized CRS axis order;
- deterministic media filenames;
- no environment-specific absolute paths.

## 10. Time rules

The manifest separates:

- event time: when the reported event occurred;
- observation time: when a measurement or observation was made;
- validity interval: when a forecast, work or status is valid;
- publication time: when the publisher released it;
- retrieval time: when StreetSherlock fetched it;
- ingestion time: when transformation/import completed.

If the source does not provide a time, the field remains unknown. Retrieval time never becomes event time.

## 11. Spatial rules

- Store source CRS exactly.
- Use EPSG:28992 for Dutch metric distance, buffer and intersection operations.
- Use EPSG:4326 GeoJSON for browser interchange.
- Record transform software/version and axis-order assumptions.
- Test known control points and geometry validity.
- Store the query bbox/polygon and selected collections in the manifest.
- Do not download a city or country when a small test area is sufficient.

## 12. CI and demo behavior

CI must:

- verify schemas and checksums;
- reject expired/pending/quarantined fixtures;
- run without network access to source APIs;
- report fixture IDs and versions used;
- prevent a golden fixture from entering a training job;
- validate synthetic/public origin separation.

Demo reset must:

- clear only the explicit demo dataset;
- re-seed approved fixtures idempotently;
- preserve fixture/source identity;
- produce the same hero IDs and expected states;
- show snapshot age and synthetic labels.

## 13. Training and evaluation separation

| Use | Rule |
|---|---|
| Unit/integration fixture | May be synthetic or minimal approved public snapshot |
| Golden evaluation set | Versioned, immutable per evaluation release and labelled `evaluation_only` |
| Model training set | Separate approval, licence, privacy, split and lineage record required |
| Prompt examples | Must not copy evaluation answers into prompts |
| Demo screenshots | Must retain attribution and synthetic/source labels |

Moving any case from evaluation to training creates a new dataset version and requires leakage review. Training and evaluation partitions are identified by stable record IDs and checked for overlap.

## 14. Update and retirement

A fixture update is a reviewed change, not an in-place refresh.

1. Create a new snapshot/fixture version.
2. Compare fields, records, terms, quality, time range and checksums.
3. Re-run tests and evaluation baselines.
4. Record expected metric changes.
5. Approve or quarantine the new version.
6. Mark the old version superseded; retain or delete according to the documented purpose.
7. Update release evidence.

Retire a fixture when rights change, the source disappears, it contains disallowed data, it is no longer representative, or a better bounded fixture replaces it.

## 15. Validation checklist

Before a fixture becomes `approved`:

- [ ] Source is eligible in SS-DATA-001.
- [ ] Purpose and mapped requirements are explicit.
- [ ] Exact licence/rights evidence and attribution are present.
- [ ] Fields, geography and time range are minimal.
- [ ] Data class and privacy review are complete.
- [ ] Source, transform and fixture checksums verify.
- [ ] Source and target schemas validate.
- [ ] Event/observation/retrieval times are not conflated.
- [ ] CRS and transformation are tested.
- [ ] Live outage behavior is defined.
- [ ] Deletion and rebuild are safe and documented.
- [ ] Public redistribution/commit is explicitly approved.
- [ ] Evaluation/training use is explicit.
- [ ] Known limitations are visible.

## 16. Open implementation decisions

The following belong to later issues:

- exact fixture schema implementation language and validation command;
- Git versus release artefact/object-storage threshold;
- source adapter command names;
- exact MORA field allowlist;
- exact BGT/BAG collections and bounding boxes;
- selected AHN edition/product and Climate Impact Atlas layer;
- an exact NDW/NTM product;
- fixture review-expiry duration;
- whether raw source hashes can be retained when raw content must be deleted.

## 17. Approval record

| Decision | Reviewer | Date | Result |
|---|---|---|---|
| Fixture strategy and manifest contract | Kiarash Delavar, Product Owner | Pending | Pending |
| Data/licence review | Unassigned | Pending | Required before public fixture commit/redistribution |
| Privacy/security review | Unassigned | Pending | Required for any higher-risk source |
| Implementation verification | Future data-adapter owner | Pending | Required when schema/scripts exist |

Approval freezes this strategy only. It does not approve a fixture payload, source adapter, live fetch, model dataset, pilot, or production use.
