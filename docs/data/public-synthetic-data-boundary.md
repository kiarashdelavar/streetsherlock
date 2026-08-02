# Public and Synthetic Data Boundary

| Field | Value |
|---|---|
| Document ID | SS-DATA-002 |
| Work item | E00-07 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Review date | 2 August 2026 |
| Approval | Approved by Kiarash Delavar, Product Owner, on 2 August 2026 |
| Related document | `docs/data/source-licence-provenance-register.md` |

## 1. Boundary decision

StreetSherlock has two deliberately separate demo evidence lanes:

- **Synthetic Deventer lane:** fictional people, reports, incidents, works, repairs, inspections, contractors and warranty events used to demonstrate the complete product workflow.
- **Public-source lane:** minimized, dated open-data snapshots used only for map context, offline engineering, or bounded evaluation.

The lanes may be displayed together only when each record keeps its origin and the interface does not imply that a public Amsterdam record happened in Deventer or that a synthetic Deventer case is a municipal fact.

## 2. Data classes

| Class | Examples | Portfolio handling |
|---|---|---|
| Synthetic | Generated Deventer report, fictional repair, fake contact | Allowed with visible synthetic label and deterministic seed |
| Public open | Approved MORA subset, BGT object, KNMI observation | Allowed only under the source register, manifest and attribution rules |
| Public but contextual | Address, precise location, climate layer | Minimize and review because public data can become sensitive when joined |
| Internal project | Test results, fixture metrics, review notes | Repository access and normal project controls |
| Confidential | Real reporter contact, restricted original media, real contractor data | Not allowed in repository or public demo |
| Sensitive operational | Unpublished works, credentials, security events, integration metadata | Not allowed in public fixtures |
| Controlled/external | KLIC delivery or customer-contracted export | Prohibited in portfolio; pilot-specific approval required |
| Unknown rights | Accessible data without precise reuse terms | Blocked until resolved |

Public accessibility does not remove privacy, purpose, security, quality, attribution, or misleading-presentation risks.

## 3. Synthetic Deventer contract

### 3.1 Required identity

Every synthetic entity has:

- `data_origin = "synthetic"`;
- `synthetic_scenario_id`;
- deterministic stable ID;
- generator version;
- scenario clock;
- visible UI label where a user could mistake it for reality.

Every screenshot, recording, PDF and export containing the hero case must say:

> Synthetic Deventer demo data — not a real municipal case.

### 3.2 Synthetic people and organizations

Use:

- clearly fictional names;
- `example.invalid` email addresses;
- non-dialable phone placeholders;
- invented teams and contractor names that do not intentionally resemble a real local organization;
- avatar/media assets created for the project or separately licensed.

Do not use:

- copied LinkedIn profiles;
- real municipal employees;
- real citizens;
- real contractor allegations;
- harvested report text or photographs;
- plausible identity combinations that could be mistaken for a real person.

### 3.3 Synthetic geometry

A synthetic case may use a plausible map point or polygon to test spatial behavior, but it must not assert that:

- a defect exists there;
- a real repair failed there;
- a contractor worked there;
- a warranty is active there;
- a route is unsafe;
- a named person reported it.

For screenshots, prefer a documented demo area and avoid private-home targeting when an equivalent public-space location works.

### 3.4 Synthetic media

Synthetic media must be generated, staged by the project owner, or obtained under a separately recorded reusable licence. It must not contain real faces, licence plates, house numbers, contact details or location metadata unless the content is intentionally constructed for a privacy-transformation test and remains non-personal.

Original, redacted and public-derived test objects still use separate storage prefixes so tests prove the boundary.

## 4. Public-source contract

A public-source record is usable only when all of these are true:

1. A stable source ID exists in SS-DATA-001.
2. Exact product and authoritative URL are frozen.
3. Licence/rights and attribution evidence are recorded.
4. The planned fields and downstream purpose are explicit.
5. A minimal bounded snapshot is used.
6. Time semantics, CRS and transformations are recorded.
7. The fixture has a manifest and checksums.
8. The record contains no unreviewed personal or controlled data.
9. The UI/export shows origin, date and limitations.
10. Live failure has a visible non-destructive fallback.

## 5. Separation rules

| Rule | Required implementation |
|---|---|
| No city relabelling | Amsterdam records retain `municipality_context = Amsterdam`; never rewrite to Deventer |
| No fake municipal truth | Synthetic Deventer records retain `synthetic = true` throughout storage, API, UI and export |
| No silent enrichment | Every joined source value keeps provenance and observation/snapshot time |
| No source overwrite | Derived values do not replace the source snapshot or synthetic input |
| No cross-lane identity join | Public records are not joined to synthetic contact or identity fields |
| No unsupported inference | Missing public data does not become a negative fact |
| No live demo dependency | Demo reads a dated fixture and can reset offline |
| No endorsement implication | Attribution must not imply publisher approval |
| No relicensing | Repository licence does not change an external dataset's terms |
| No hidden fixture drift | Fixture changes require manifest diff, checksum and review |

## 6. Environment matrix

| Environment | Synthetic Deventer | Public snapshots | Live public APIs | Real municipal/customer data | Real KLIC |
|---|---:|---:|---:|---:|---:|
| Local development | Allowed | Allowed if approved | Manual fetch command only; never required at runtime | Forbidden | Forbidden |
| CI | Allowed | Allowed if approved and redistributable | Forbidden | Forbidden | Forbidden |
| Preview PR | Allowed | Allowed if approved | Forbidden | Forbidden | Forbidden |
| Portfolio demo | Allowed and visibly labelled | Allowed with attribution/date | Optional operator refresh before demo; never required | Forbidden | Forbidden |
| Shadow pilot | Separate pilot fixture/data agreement | Contract-approved snapshots | Read-only adapters after customer review | Allowed only under signed scope and controls | Only if explicitly lawful and necessary |
| Production | Not authorized by Sprint 0 | Not authorized by Sprint 0 | Not authorized by Sprint 0 | Not authorized by Sprint 0 | Not authorized by Sprint 0 |

## 7. Field-level minimization

### 7.1 Public reports

Default allowlist:

- public source record ID;
- coarse or permitted geometry;
- public category/subcategory;
- event/report timestamp;
- public lifecycle/status fields required for the evaluation;
- source and snapshot metadata.

Default denylist:

- reporter contact;
- unreviewed free text;
- unreviewed media;
- IP/device/session identifiers;
- internal notes;
- exact household associations;
- inferred sensitive attributes.

### 7.2 Base and address context

Use BGT/BAG objects only to support the selected spatial feature. Do not infer owner, resident, disability, vulnerability, wealth, occupancy or service worthiness.

### 7.3 Weather and climate

Preserve quality flags and timestamps. A station observation or national model layer is context, not street-level proof. An unavailable measurement is `unknown`, not zero.

### 7.4 Works and mobility

No WIOR or NDW fixture is committed while its exact product-level licence and fields are unresolved. Synthetic work and route context remains the fallback.

### 7.5 Subsurface and KLIC

BRO public characteristics may be used only for bounded context. Real KLIC cable/pipe content is a different controlled class and is prohibited in the portfolio.

## 8. Join-risk rules

A join can increase sensitivity or mislead even when each input is public.

| Proposed join | Risk | Default decision |
|---|---|---|
| Public report + public geometry | Re-identification/local targeting | Minimize precision and review |
| BAG address + citizen report | Household/person association | Prohibited in public fixture |
| MORA record + synthetic Deventer incident | False city/event claim | Prohibited |
| KNMI observation + incident | False street-level certainty | Allowed as labelled context with time/distance |
| Climate layer + priority | National model becomes operational truth | Advisory evidence only; no automatic decision |
| Work polygon + recurrence | Implied contractor fault | Candidate only; human review and neutral language |
| KLIC + public map | Infrastructure exposure | Prohibited |
| Public snapshot + training set | Undocumented secondary use/leakage | Requires separate dataset/model decision |

## 9. Privacy and publication gate

Before a record or derived artefact becomes public:

1. confirm its class and source;
2. check that the planned visibility is allowed;
3. remove or transform prohibited fields;
4. verify attribution and synthetic labels;
5. check that precise geometry is safe for the use;
6. confirm media review/redaction state;
7. verify source age and limitations;
8. record the publication decision and actor.

A failed or uncertain check returns `publication_blocked`. It does not silently publish a partial record.

## 10. Fixture versus live behavior

### Recorded-fixture path

1. An explicit maintainer command requests an allowed minimal subset.
2. The raw response is stored temporarily in a controlled build location.
3. Integrity, schema, field allowlist, terms and privacy checks run.
4. Deterministic transformation produces a minimal canonical fixture.
5. Manifest and checksums are written.
6. Reviewer approves redistribution/commit.
7. Runtime, CI and demo read the fixture.

### Live-adapter path

Live adapters are not part of E00-07. A future adapter must:

- sit behind a replaceable interface;
- time out safely;
- rate-limit and cache according to source rules;
- return current, aging, stale, unavailable or quarantined state;
- never mutate authoritative business state from raw input;
- preserve provenance;
- fall back to a valid dated fixture or manual workflow.

## 11. Licence/terms change response

When an automated or manual review finds a source change:

```text
detected
→ disable refresh
→ quarantine affected fixture
→ identify downstream use
→ review terms/schema/fields
→ approve rebuild or delete
→ regenerate and re-verify
→ reactivate
```

No existing fixture is grandfathered merely because it was once public.

## 12. Export and repository rules

- External fixture directories must include their own notice and manifest.
- Export packages include source attribution, snapshot time and known limitations.
- Do not bundle a blocked or controlled source in a release archive.
- Large/raw source artefacts stay out of Git unless a separate storage and redistribution decision approves them.
- Do not place API keys, signed URLs, access tokens or customer exports in manifests.
- A README may summarize sources but cannot replace machine-readable fixture provenance.
- E00-10 decides the repository code/document licence; external content remains under its own rights statement.

## 13. Required negative tests for later implementation

The future data/adapter stories must prove:

- a fixture labelled Amsterdam cannot be imported as Deventer;
- a synthetic flag cannot be removed by an API update;
- a manifest/checksum mismatch quarantines the fixture;
- a missing observation remains unknown;
- a stale source is visible and does not silently drive priority;
- a blocked source cannot be enabled by configuration alone;
- a public export excludes confidential/controlled fields;
- a real KLIC-shaped payload is rejected outside an approved pilot profile;
- licence/terms review expiry disables refresh;
- deleting a fixture removes or rebuilds derived test data predictably.

## 14. Open external questions

These are intentionally unresolved:

- Which municipality-approved public-data and address precision is acceptable for a real pilot?
- Which lawful basis, retention, archive and data-subject procedures apply to imported reports?
- Can the selected Amsterdam WIOR distribution be redistributed, and under which exact licence?
- Which exact NDW/NTM publication supports the CycleSafe/dig-once feature and what are its product-level terms?
- Which Climate Impact Atlas layer is necessary, and are its layer-specific rights identical to the general FAQ?
- Which AHN edition/crop is proportionate for the selected feature?
- What municipal data-sharing agreement governs historical reports and work/repair data?
- Is any KLIC access genuinely necessary for a shadow pilot, and who is authorized to request and view it?
- Which independent privacy, data/licence, security and municipal reviewers will sign the activation gate?

## 15. Approval record

| Decision | Reviewer | Date | Result |
|---|---|---|---|
| Product/data boundary | Kiarash Delavar, Product Owner | 2 August 2026 | Approved — bounded portfolio design only |
| Independent data/licence review | Unassigned | Pending | Required before redistribution/pilot |
| Municipal validation | Unassigned | Pending | Required before operational use |
| Privacy/security review | Unassigned | Pending | Required before controlled or personal data |

Product Owner approval accepts the bounded portfolio design only. It does not authorize a live adapter, public fixture redistribution, real municipal data, a pilot, production, or a compliance claim.
