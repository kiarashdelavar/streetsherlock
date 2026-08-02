# Source, Licence, and Provenance Register

| Field | Value |
|---|---|
| Document ID | SS-DATA-001 |
| Work item | E00-07 |
| Version | 0.1 |
| Status | Proposed |
| Owner | Kiarash Delavar |
| Product Owner | Kiarash Delavar |
| Review date | 2 August 2026 |
| Next review | Before the first source fixture is committed and at every source/terms change |
| Required reviewers | Product Owner self-review; independent data/licence and municipal review remain pending |
| Controlled baseline | `docs/MASTER_PROJECT_SPEC.md` |
| Related requirements | DATA-01..DATA-10, PLAT-07, NL-01..NL-11 |

## 1. Purpose

This register decides which external and synthetic sources StreetSherlock may use for engineering, evaluation, and demonstration. It records provenance and safe-failure controls before adapters or fixtures are implemented.

This is an engineering governance record, not legal advice. A source marked eligible is still subject to its current dataset metadata, terms, attribution, privacy review, and the exact way StreetSherlock uses or redistributes it.

## 2. Non-negotiable rules

1. Synthetic Deventer incidents are the only municipal case stories used in the portfolio demo.
2. Amsterdam public records may support historical engineering and evaluation; they must never be presented as Deventer records or current truth for another municipality.
3. Tests, CI, previews, and demos never depend on a live external API.
4. Every source-derived value carries source identity and relevant event, observation, and ingestion times.
5. External data is minimized to fields needed by a named feature or evaluation question.
6. A vague label such as `public` is not treated as a sufficient redistribution licence.
7. Public Domain Mark is recorded as a rights statement, not misrepresented as a software-style licence.
8. Real citizen contact details, unrestricted report text, real contractor cases, and real KLIC deliveries are not repository fixtures.
9. Licence or terms changes quarantine affected fixtures until re-review.
10. Open data may inform a recommendation; it never creates an official municipal decision.

## 3. E00-07 control interpretation

The Master Project Specification references DATA-01..DATA-10 as a control group. This document freezes their Sprint 0 meaning without adding product behavior.

| ID | Control |
|---|---|
| DATA-01 | Assign a stable `source_id` to every dataset, API, model, synthetic generator, and controlled import. |
| DATA-02 | Record publisher, authoritative URL, exact product/version, access method, and review date. |
| DATA-03 | Record licence/terms evidence, attribution, redistribution limits, and unresolved ambiguity. |
| DATA-04 | Preserve source record ID plus event, observation, validity, publication, retrieval, and ingestion time where supplied. |
| DATA-05 | Record cadence, freshness state, quota, cache policy, outage behavior, and dated-snapshot fallback. |
| DATA-06 | Version fixtures with a manifest, adapter/schema version, transformation history, and SHA-256 checksums. |
| DATA-07 | Minimize fields and classify public, internal, confidential, sensitive operational, controlled, or synthetic content. |
| DATA-08 | Keep attribution machine-readable and visible in exports, maps, evidence, and documentation where required. |
| DATA-09 | Block real customer, KLIC, restricted, personal, or unclear-rights data until written authority and controls exist. |
| DATA-10 | Revalidate terms, quality, bias, lineage, retention, and downstream use before activation and each release. |

## 4. Decision states

| State | Meaning | Implementation effect |
|---|---|---|
| Eligible for bounded fixture | Official evidence is sufficient for a minimal recorded snapshot | Adapter story may proceed after manifest and field-level review |
| Conditional | Use is possible only after the named condition is completed | No fixture or redistribution until condition passes |
| Blocked | Rights, product identity, security, or purpose is unresolved | Adapter remains disabled; synthetic fallback only |
| Prohibited in portfolio | Real content is outside the portfolio boundary | Do not fetch, store, commit, render, or transmit it |
| Synthetic only | No external records are used | Use deterministic generator and obvious synthetic labels |

## 5. Source decision summary

| Source ID | Source | Intended release | Rights evidence | Decision |
|---|---|---|---|---|
| SRC-SYN-DEV | Deterministic synthetic Deventer scenario | MVP | Project-created synthetic content | Eligible for bounded fixture |
| SRC-AMS-MORA | Amsterdam public-space reports subset | MVP evaluation / V1 | CC BY stated by Amsterdam dataset page | Eligible for bounded fixture |
| SRC-AMS-WIOR | Amsterdam works in public space | V1 | Dataset page says `public`, without a precise licence identifier | Blocked |
| SRC-PDOK-BGT | BGT OGC API | V1 | CC0 1.0 on exact API landing page | Eligible for bounded fixture |
| SRC-PDOK-BAG | BAG OGC API v2 | V1 | Public Domain Mark 1.0 on exact API landing page | Conditional |
| SRC-AHN6 | Actueel Hoogtebestand Nederland 6 | V1 | CC BY 4.0 stated by AHN | Eligible for bounded fixture |
| SRC-BRO-GM | BRO groundwater-monitoring characteristics | V1 | CC0 1.0 on exact API landing page | Eligible for bounded fixture |
| SRC-KNMI-10M | KNMI near-real-time 10-minute observations v1.0 | MVP/V1 | CC BY 4.0 in exact dataset metadata | Eligible for bounded fixture |
| SRC-NDW-MOBILITY | NDW/NTM cycle, traffic, or roadwork context | V1 | Exact product and product-level licence not yet frozen | Blocked |
| SRC-CLIMATE-ATLAS | Climate Impact Atlas selected layer | V1 | CC BY 4.0; required attribution stated by Atlas | Conditional |
| SRC-KLIC-MOCK | Synthetic KLIC-shaped contract fixture | Later adapter only | No real delivery; project-created schema mock | Synthetic only |
| SRC-KLIC-REAL | Real KLIC delivery | Pilot only if lawfully supplied | Purpose-specific paid/controlled delivery | Prohibited in portfolio |

## 6. Common provenance envelope

Every imported record or derived context value must be traceable to an immutable ingestion record containing at least:

```json
{
  "source_id": "SRC-KNMI-10M",
  "source_dataset_version": "1.0",
  "source_record_id": "publisher-provided-id-or-stable-composite",
  "source_url": "authoritative-dataset-or-record-url",
  "licence_or_rights_id": "CC-BY-4.0",
  "attribution_text": "KNMI",
  "event_time": "publisher-event-time-or-null",
  "observation_time": "publisher-observation-time-or-null",
  "valid_from": "publisher-validity-start-or-null",
  "valid_to": "publisher-validity-end-or-null",
  "published_at": "publisher-publication-time-or-null",
  "retrieved_at": "UTC timestamp",
  "ingested_at": "UTC timestamp",
  "snapshot_id": "FIX-KNMI-RAIN-001",
  "content_sha256": "lowercase-hex",
  "source_crs": "publisher CRS",
  "target_crs": "EPSG:28992",
  "transform_version": "named deterministic transform",
  "adapter_version": "git SHA or release version",
  "schema_version": "fixture/application schema version",
  "classification": "public",
  "synthetic": false,
  "lineage_parent_ids": []
}
```

Unknown time values remain `null`; ingestion time must never be substituted for event or observation time.

## 7. Detailed source records

### 7.1 SRC-SYN-DEV — Synthetic Deventer hero data

| Field | Decision |
|---|---|
| Publisher | StreetSherlock project |
| Authority | None; deliberately fictional |
| Purpose | Repeatable hero workflow, authorization tests, failure paths, screenshots, demo reset |
| Permitted fields | Fictional reports, incidents, users, teams, works, repairs, inspections, warranty metadata, contact placeholders and media |
| Minimization | Generate only fields used by a requirement or test |
| Geography | Plausible Deventer-area geometry; never claim it represents a real event, person, asset state, repair, or contractor |
| Time | Fixed scenario clock with a documented base timestamp |
| Classification | Synthetic; contact-like values remain non-routable |
| Licence | Project-created content; repository disclosure decision belongs to E00-10 |
| Required label | `Synthetic Deventer demo data — not a real municipal case` |
| Fixture strategy | Deterministic seed plus manifest and checksum |
| Quality limits | Useful for behavior, not evidence of real-world accuracy, fairness, volume, or municipal value |
| Deletion/rebuild | Rebuild from the versioned generator; reset must be idempotent |
| Downstream | MVP demo and tests |
| Decision | Eligible for bounded fixture |

Synthetic names must be obviously fictional; use reserved domains such as `example.invalid` and non-dialable phone patterns.

### 7.2 SRC-AMS-MORA — Amsterdam public-space reports

| Field | Decision |
|---|---|
| Publisher | Gemeente Amsterdam |
| Authoritative URL | https://api.data.amsterdam.nl/v1/docs/datasets/meldingen.html |
| Rights evidence | https://api.data.amsterdam.nl/v1/mvt/meldingen |
| Dataset statement | Open subset of Amsterdam public-space reports from mid-2018, with documented category and split-report exclusions |
| Purpose | Historical category/duplicate-retrieval engineering and bounded offline evaluation |
| Fields | Public source ID, public category/subcategory, public geometry at permitted precision, event/report time, public status/time fields needed by the test |
| Excluded fields | Free text or media unless explicitly present, necessary, reviewed, and safe; no contact data; no hidden/internal fields |
| Geography | Amsterdam only |
| Time | Preserve report/event time separately from snapshot retrieval time |
| Licence | Creative Commons Attribution as stated by the dataset page; record the exact licence URL/version in each fixture manifest before download |
| Attribution | `Source: Gemeente Amsterdam, Meldingen Openbare Ruimte` plus source URL and snapshot date |
| CRS | Record the endpoint CRS; transform spatial calculations to EPSG:28992 and web interchange to EPSG:4326 |
| Freshness | Historical engineering source, not real-time truth; snapshot date displayed |
| Outage behavior | Use dated, checksum-verified fixture; do not call live API in tests/demo |
| Quality limits | Public subset, excluded categories and transformed workflows can create selection and history bias |
| Deletion/rebuild | Delete fixture directory and regenerate from manifest only while terms remain valid |
| Downstream | Offline evaluation; never copied into synthetic Deventer incidents |
| Decision | Eligible for bounded fixture after field-level minimization |

### 7.3 SRC-AMS-WIOR — Amsterdam works in public space

| Field | Decision |
|---|---|
| Publisher | Gemeente Amsterdam |
| Authoritative URL | https://api.data.amsterdam.nl/v1/docs/datasets/wior.html |
| Rights evidence | https://api.data.amsterdam.nl/v1/mvt/wior/v1 |
| Dataset statement | Publicly accessible context about execution and applications for works in public space |
| Purpose | Later work-footprint and dig-once demonstration |
| Licence/terms | Dataset page currently reports `public`; this is not a precise reusable licence identifier |
| Attribution | To be frozen only after exact terms are confirmed |
| Freshness | API-key requirements and endpoint changes must be monitored |
| Quality limits | Amsterdam-specific work process and schema; not transferable municipal truth |
| Fixture strategy | None until exact licence/terms and permitted redistribution are recorded |
| Outage behavior | Synthetic work polygons only |
| Decision | Blocked |

Unblock only when the exact endpoint, licence/terms URL, attribution, permitted fixture redistribution, fields, cadence, and schema version are recorded.

### 7.4 SRC-PDOK-BGT — detailed public-space topography

| Field | Decision |
|---|---|
| Publisher | Kadaster (LV-BGT) through PDOK |
| Authoritative URL | https://api.pdok.nl/lv/bgt/ogc/v1?f=html&lang=en |
| Purpose | Road, cycle path, pavement, water and terrain object context |
| Fields | Stable object identity, selected object type, geometry, status/source dates where supplied |
| Licence | CC0 1.0 on the exact OGC API landing page |
| Attribution | Preserve publisher/source URL even where CC0 does not require attribution |
| Geography | Minimal bounding boxes around selected demo/test locations |
| Freshness | Landing page states daily updates; store snapshot/retrieval date |
| CRS | Prefer Dutch metric operations in EPSG:28992; record any source response CRS and transform |
| Quality limits | Registration does not prove current hazard, accessibility, ownership, or maintenance condition |
| Outage behavior | Use bounded fixture; mark stale age; disable enrichment if no valid fixture |
| Fixture strategy | Selected object types only, deterministic bbox/query, canonical ordering and SHA-256 |
| Decision | Eligible for bounded fixture |

### 7.5 SRC-PDOK-BAG — address/building context

| Field | Decision |
|---|---|
| Publisher | Kadaster (LV-BAG) through PDOK |
| Authoritative URL | https://api.pdok.nl/kadaster/bag/ogc/v2?f=html&lang=en |
| Purpose | Manual address fallback and building/address context where necessary |
| Fields | Only selected public address/building IDs, geometry and status needed by a named feature |
| Rights evidence | Public Domain Mark 1.0 on the exact OGC API landing page |
| Rights note | Public Domain Mark communicates known public-domain status; it is not presented as a licence grant |
| Geography | Minimal demo bounding box |
| Freshness | Landing page states daily updates |
| CRS | Record source CRS; EPSG:28992 for metric processing, EPSG:4326 for GeoJSON interchange |
| Privacy/minimization | A public address may still become personal in context; never join it to reporter identity in a public fixture |
| Quality limits | BAG is not evidence of resident identity, accessibility, occupancy, ownership, or incident validity |
| Fixture strategy | Block until the exact feature collection, metadata record, rights statement and attribution decision are copied into the manifest |
| Decision | Conditional |

### 7.6 SRC-AHN6 — elevation context

| Field | Decision |
|---|---|
| Publisher | AHN collaboration; distributed through AHN/PDOK |
| Authoritative URL | https://www.ahn.nl/eerste-deel-ahn-6-beschikbaar |
| Purpose | Broad elevation/context feature; never infer defect depth, slope compliance, compaction or liability from it |
| Fields | Minimal raster cells or derived aggregate for a bounded test area, edition/tile identity and capture metadata |
| Licence | CC BY 4.0 for AHN6, as stated by AHN |
| Attribution | `Source: AHN`, edition, tile and snapshot date |
| Geography | Minimal bounding area; no nationwide copy in repository |
| Freshness | Edition/capture time matters more than retrieval time; record both |
| CRS | Preserve published grid CRS and transformation; calculations use EPSG:28992 |
| Quality limits | Capture date, surface/terrain model choice, resolution and acquisition conditions limit street-level interpretation |
| Outage behavior | Dated fixture or enrichment unavailable; never invent height |
| Fixture strategy | Small deterministic crop; checksum source artefact and transformed output |
| Decision | Eligible for bounded fixture |

### 7.7 SRC-BRO-GM — groundwater-monitoring characteristics

| Field | Decision |
|---|---|
| Publisher | BZK/BRO through PDOK |
| Authoritative URL | https://api.pdok.nl/tno/bro-grondwatermonitoring-in-samenhang-karakteristieken/ogc/v1?f=html&lang=en |
| Purpose | Optional groundwater/subsurface context for later reopen-risk research |
| Fields | Selected monitoring network/well characteristics and geometry; no unnecessary measurements |
| Licence | CC0 1.0 on the exact API landing page |
| Freshness | Landing page states daily updates; observation times remain distinct |
| CRS | Record source CRS and transform deterministically |
| Quality limits | Monitoring-site data does not prove local causation, defect origin, or current groundwater at an incident |
| Outage behavior | Feature unavailable or dated fixture; no priority penalty |
| Fixture strategy | Minimal regional subset only after a concrete feature needs it |
| Decision | Eligible for bounded fixture |

### 7.8 SRC-KNMI-10M — near-real-time meteorological observations

| Field | Decision |
|---|---|
| Publisher | KNMI |
| Authoritative URL | https://dataplatform.knmi.nl/dataset/10-minute-in-situ-meteorological-observations-1-0 |
| API guidance | https://developer.dataplatform.knmi.nl/open-data-api |
| Purpose | Rain, wind and temperature context for transparent rules and failure demonstrations |
| Fields | Station ID/location, observation timestamp, selected precipitation/wind/temperature variables, quality/status flags supplied by source |
| Licence | CC BY 4.0 in exact dataset metadata |
| Attribution | `Source: KNMI`, dataset/version, snapshot time and licence link |
| Time | Observation time is authoritative for the measurement; keep publication/retrieval/ingestion separately |
| Freshness | Ten-minute source; UI must display age and never treat missing updates as zero weather |
| Access/quota | API key and current quota policy apply; excessive polling is forbidden |
| CRS | Preserve station coordinate metadata; transform spatial matching to EPSG:28992 |
| Quality limits | Station observations are not street-level measurements; missing/quality-flagged data lowers confidence |
| Outage behavior | Dated fixture in tests/demo; production-shaped adapter returns explicit unavailable/stale state |
| Fixture strategy | One bounded rainfall/storm time window with source file IDs and checksums |
| Decision | Eligible for bounded fixture |

### 7.9 SRC-NDW-MOBILITY — mobility context

| Field | Decision |
|---|---|
| Publisher | NDW / National Access Point for Mobility Data and underlying supplier |
| Candidate catalog | https://ntm.ndw.nu/ |
| Copyright context | https://english.ndw.nu/service/copyright |
| Purpose | Later cycle-route, traffic, roadwork or dig-once context |
| Licence/terms | Website content defaults to CC0 with image exceptions, but this does not automatically establish the licence for every data product |
| Product state | Exact dataset/product, supplier, fields, geography, licence and update semantics are not frozen |
| Fixture strategy | None |
| Outage behavior | Feature unavailable; no guessed cycle importance or priority penalty |
| Decision | Blocked |

Unblock through a separate source-selection review of one exact NTM publication and distribution, including product-level licence, attribution, data-subject risk, coverage, quality, cadence and fixture redistribution.

### 7.10 SRC-CLIMATE-ATLAS — Climate Impact Atlas

| Field | Decision |
|---|---|
| Publisher | Climate Adaptation Services foundation with named layer producer |
| Authoritative URL | https://www.klimaateffectatlas.nl/en/faq |
| Purpose | Later broad waterlogging, drought, heat, flood or subsidence context |
| Fields | One selected layer value/class, scenario/year, resolution and layer producer metadata |
| Licence | CC BY 4.0 according to the Atlas FAQ; verify the selected layer metadata too |
| Attribution | Exact required form: `Climate Impact Atlas, 2026`; also name the layer producer where required |
| Geography | National/regional model context |
| Freshness | Layer-specific; record scenario, model version, publication and snapshot dates |
| CRS | Layer-specific and recorded in manifest; transform deterministically |
| Quality limits | National model layers are indicative and usually approximate locally; never present them as street-level ground truth |
| Outage behavior | Dated fixture or unavailable context; no automatic priority or liability decision |
| Fixture strategy | Conditional on selecting one exact layer and confirming its metadata/terms |
| Decision | Conditional |

### 7.11 SRC-KLIC-MOCK and SRC-KLIC-REAL

| Field | Synthetic mock | Real delivery |
|---|---|---|
| Publisher | StreetSherlock | Kadaster and network operators |
| Authoritative context | https://www.kadaster.nl/zakelijk/producten/graafwerk/klic-melding | Same |
| Purpose | Exercise an adapter contract without cable/pipe content | Pilot-specific lawful excavation/orientation use only |
| Content | Fictional IDs, geometry and non-sensitive categories | Controlled cable/pipe information and delivery metadata |
| Rights/access | Project-created schema mock | Purpose-specific request, account, payment and customer controls |
| Repository | Allowed when clearly synthetic | Forbidden |
| Public UI | Never show realistic cable/pipe detail | Forbidden |
| Decision | Synthetic only | Prohibited in portfolio |

A future pilot must define lawful purpose, access, retention, tenant isolation, authorized roles, security, export/deletion and contract terms before any real KLIC import.

## 8. Attribution and disclosure

1. Store attribution beside the source definition, not only in README prose.
2. Render required attribution on maps, exports, evidence packages and dataset documentation.
3. Preserve dataset name, publisher, version, snapshot date and licence/rights URL.
4. Do not imply that a publisher endorses StreetSherlock or a derived decision.
5. Repository licence E00-10 does not relicense external datasets or fixtures.
6. Each distributable fixture requires a manifest-level `redistribution_review: approved`.
7. Screenshots must keep visible source and synthetic labels.

## 9. Freshness and outage policy

| Freshness state | Meaning | Required behavior |
|---|---|---|
| Current | Within source-specific accepted age | Show source and observation time |
| Aging | Available but older than preferred | Show age warning; lower or omit dependent evidence |
| Stale | Older than the accepted maximum | Do not present as current evidence |
| Unavailable | No valid live value or fixture | Manual workflow continues without the enrichment |
| Quarantined | Integrity, licence, schema or provenance check failed | Block use and alert the data owner |

Missing external data is never interpreted as no rain, no work, no asset, no risk, or no incident.

## 10. Change and incident rules

Trigger re-review when:

- dataset, endpoint, collection, publisher, terms, attribution or authentication changes;
- a fixture adds fields, geography, time range or a new downstream use;
- public data is joined with contact, media, customer, contractor or controlled data;
- a fixture is proposed for training, public redistribution, screenshots or pilot use;
- a CRS/transformation, adapter schema or event-time meaning changes.

On suspected licence/provenance failure:

1. disable the adapter or feature flag;
2. quarantine affected snapshots and derived artefacts;
3. preserve manifest/checksum/audit metadata without redistributing content;
4. identify downstream tables, exports, evaluations and releases;
5. delete/rebuild where required;
6. record the decision and independent review needed before reactivation.

## 11. Approval and open reviews

| Review | Status | Owner / condition |
|---|---|---|
| Product Owner | Pending | Kiarash Delavar must approve before merge |
| Independent data/licence | Pending | Required before public fixture redistribution or pilot |
| Municipal domain/data owner | Pending | Required before treating any source as operationally useful |
| Privacy | Pending | Required before personal, address-linked, media, or customer data |
| Security | Pending | Required before authenticated/controlled source access |
| Repository disclosure | Pending E00-10 | Must state external fixture exclusions and notices |

Approval of this document freezes the engineering boundary only. It does not authorize source activation, live ingestion, real municipal data, a pilot, production, or a legal/compliance claim.
