# StreetSherlock Privacy and Data-Classification Baseline

| Field | Value |
|---|---|
| Document ID | PRIV-DC-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar — Product Owner / solo delivery |
| Review cadence | Every sprint and after a purpose, data category, role, provider, model, integration, retention, publication, tenant or environment change |
| Controlled source | `requirements/StreetSherlock-Master-Project-Prompt.md` |
| Related issue | #24 |
| Approval | Product Owner approved — 3 August 2026 |
| Independent review | Privacy Officer / Functionaris Gegevensbescherming (FG), municipal controller, legal, security and domain reviews pending |

## 1. Purpose and claim boundary

This document defines the Sprint 0 privacy and data-classification baseline for StreetSherlock. It identifies data categories, purposes, classifications, visibility boundaries, lifecycle obligations, safe failure and the evidence required before personal-data processing is enabled.

This is a design and review baseline. It is not:

- a completed Data Protection Impact Assessment (DPIA);
- legal advice or proof of GDPR, UAVG, BIO2 or municipal-policy compliance;
- confirmation of a lawful basis, retention schedule or controller/processor contract;
- implementation, penetration-test or production-readiness evidence;
- permission to process real citizen, employee, contractor, KLIC or municipal production data;
- permission to deploy, pilot or connect to a municipal production system.

The portfolio baseline uses synthetic data and approved open-data fixtures only. Independent municipal privacy, legal, security and domain decisions are mandatory before any real-data or pilot claim.

## 2. Non-negotiable privacy rules

1. Collect the minimum data needed for a declared purpose.
2. Purpose changes require review; data is not silently reused.
3. Citizen contact details are never public and never visible to contractors.
4. An uploaded original is Restricted by default.
5. A public derivative is a separate object, not a visibility flag on the original.
6. Publication is blocked when redaction quality or authority is uncertain.
7. Remove EXIF and other unnecessary embedded metadata from derivatives.
8. AI and computer vision are advisory processors; they cannot supply lawful authority or make official decisions.
9. PostgreSQL remains the authoritative business record; prompts, model histories and n8n histories are not shadow records.
10. Logs, metrics, traces, errors and analytics use allowlisted fields and exclude content, contact data, tokens and secrets.
11. Tracking tokens grant only a minimized projection, are high entropy, expiring and revocable, and are not logged.
12. Access is server-side, deny-by-default, role/entity/purpose scoped and audited where sensitive.
13. Retention periods are not invented. Unknown periods remain open release blockers with named decision owners.
14. Deletion includes derivatives, caches, search/vector artefacts, workflow histories and backup expiry handling.
15. Real KLIC data, real citizen data and production municipal integration are prohibited in the portfolio baseline.

## 3. GDPR role assumptions requiring confirmation

| Role | Sprint 0 working assumption | Must be confirmed by |
|---|---|---|
| Data controller | The municipality determines purposes and essential means for an operational deployment | Municipal legal/privacy owner |
| Product developer | Kiarash develops a synthetic portfolio prototype and is not authorized to operate a municipal service | Product Owner plus municipal sponsor |
| Hosting/runtime provider | Processor or subprocessor status depends on the selected deployment and contract | Controller, procurement and Privacy Officer/FG |
| Email, telemetry, object storage and workflow providers | May be processors/subprocessors if enabled with real data | Controller, procurement, security and Privacy Officer/FG |
| Ollama/local models | Local execution reduces external disclosure but still processes personal data if real inputs are used | Privacy Officer/FG and security |
| Open-data publishers | Independent publishers/controllers for their source datasets; reuse remains bound by licence and purpose | Data steward/legal |
| Contractor user | Authorized recipient for minimum assignment information only; never a general controller-side user | Municipal owner and legal/privacy |
| Citizen | Data subject for submitted contact/content data, not responsible for determining municipal processing purposes | Privacy Officer/FG |

No processor, joint-controller, international-transfer, subprocessor or contract conclusion is approved by this table.

## 4. Classification scheme

The highest applicable classification controls the whole record, payload, export, cache and backup until fields are separated.

| Class | Meaning | Examples | Default handling |
|---|---|---|---|
| Public | Approved for unrestricted disclosure | Approved minimized incident summary; licensed open data; synthetic demo content | Publish only through an explicit approved projection |
| Internal | Non-public operational information with limited personal-data risk | Taxonomy, synthetic fixtures, service health, non-sensitive policy versions | Authenticated role access; do not publish by default |
| Restricted | Personal, sensitive operational, evidential or aggregated information | Contact data, original media/text, precise private context, audit records, assignment details | Need-to-know, purpose-scoped access; encryption; audited sensitive access |
| Secret | Credentials or cryptographic material whose disclosure enables access or compromise | API keys, signing keys, passwords, token secrets, private keys | Secret manager only; never business database, logs, prompts or documents |

A public label is earned through a publication decision. It is never inferred from where data originated or from a successful automated redaction.

## 5. Data inventory and purpose register

“Retention status: Open” means no numeric period is approved and the affected real-data capability is blocked.

| ID | Data category | Class | Declared purpose | Primary owner | Allowed recipients | Retention status |
|---|---|---|---|---|---|---|
| D-01 | Citizen name, email, telephone or preferred contact channel | Restricted | Receipt, clarification and case updates | Municipal service owner | Assigned municipal users; approved delivery processor | Open: municipal schedule required |
| D-02 | Public tracking-token hash and status | Restricted/security-sensitive | Allow a citizen to retrieve a minimized update | Municipal service owner | Backend authorization path only | Open: token lifetime/revocation policy required |
| D-03 | Report text supplied by citizen | Restricted by default | Describe an observed street problem | Municipal service owner | Assigned municipal roles; bounded privacy/assessment processors | Open |
| D-04 | Original images/files | Restricted | Evidence for intake and human review | Municipal service owner | Authorized municipal reviewers; isolated media processors | Open |
| D-05 | File metadata, EXIF, device/location hints | Restricted | Integrity/privacy inspection where necessary | Municipal service owner | Privacy/media pipeline; authorized reviewer when justified | Minimize immediately; approved exceptions required |
| D-06 | Redacted derivative and minimized public summary | Public only after gate | Public/citizen communication | Municipal publication owner | Public or tracking recipient as approved | Open: publication/archival schedule required |
| D-07 | Report identifier, category, coarse location and timestamps | Internal or Restricted by precision/context | Intake, routing, investigation and status | Municipal service owner | Authorized municipal roles; minimized public projection | Open |
| D-08 | Incident, report-incident link and operational state | Internal/Restricted | Manage the real municipal problem | Municipal case owner | Authorized municipal roles; assigned contractor projection only | Open |
| D-09 | Human decisions, reasons, actor, time and version | Restricted audit | Accountability, correction and dispute handling | Municipal governance owner | Authorized reviewers, audit/privacy roles | Open: legal/audit schedule required |
| D-10 | Assessment run, duplicate candidate and score/explanation | Internal derived; Restricted if source content included | Advisory triage and reproducibility | Municipal case/data owner | Authorized reviewers and AI/data steward | Open |
| D-11 | Deterministic priority inputs/recommendation | Internal derived | Explainable decision support | Municipal case owner | Authorized municipal reviewers | Open |
| D-12 | Source snapshots, licences, hashes and provenance | Internal or Public by source terms | Reproducible context and audit | Data steward | Engineering/data roles; public only if licence allows | Per source register; unresolved sources blocked |
| D-13 | Employee identity, role, assignment and purpose grants | Restricted | Authentication, authorization and accountability | Municipal identity owner | Identity/admin and authorized audit roles | Open: IAM schedule required |
| D-14 | Contractor identity and assignments | Restricted | Limited work coordination in later release | Municipal contract owner | Assigned municipal roles and that contractor | Later release; schedule required |
| D-15 | Repair, inspection, warranty and field evidence | Restricted | Later InfraProof evidence lifecycle | Municipal works owner | Assigned municipal/contractor/inspector roles | Later release; schedule required |
| D-16 | Audit events and sensitive-access reasons | Restricted audit | Security, privacy and decision accountability | Governance/security owner | Authorized audit, security and privacy roles | Open; cannot be “keep forever” by default |
| D-17 | Email/outbox delivery intent and receipt | Internal/Restricted | Reliable approved notification | Municipal service owner | Delivery worker/provider; authorized support | Open; payload minimization required |
| D-18 | n8n execution metadata | Internal/Restricted | Orchestration and delivery troubleshooting | Platform owner | Restricted operations roles | Open; no content/contact duplication by default |
| D-19 | Application logs, metrics, traces and errors | Internal; Restricted if incident correlation is linkable | Reliability and security operations | Platform/security owner | Authorized operations/security roles | Open; allowlist required |
| D-20 | Prompts, model inputs/outputs and refusal/error records | Restricted when derived from a report | Advisory assessment and evaluation | AI/data owner | Authorized service and AI/data reviewers | Open; production prompt history disabled by default |
| D-21 | Embeddings/vector index entries | Restricted when derived from report content | Duplicate-candidate retrieval | AI/data owner | Backend retrieval path and authorized data steward | Open; deletion propagation required |
| D-22 | Model, prompt, policy and dataset version metadata | Internal | Reproducibility and rollback | AI/data owner | Engineering, reviewers and audit | Version schedule required; no personal training corpus |
| D-23 | Consent or contact-preference evidence, if used | Restricted audit | Prove a genuinely optional choice | Municipal privacy/service owner | Authorized service/privacy roles | Open; consent is not assumed lawful basis for core task |
| D-24 | Data-subject request/correction case | Restricted | Respond to access, correction, restriction or objection | Municipal privacy owner | Authorized privacy/service roles | Open: statutory/municipal schedule required |
| D-25 | Backup and restore artefacts | Restricted aggregate | Resilience and recovery | Platform owner | Approved recovery operators only | Open: schedule, expiry and restore isolation required |
| D-26 | Secrets and signing material | Secret | Authenticate systems and protect tokens/callbacks | Security/platform owner | Runtime identities and approved operators | Rotate by security policy; never retained in business exports |
| D-27 | Synthetic personas, reports and fixtures | Public/Internal synthetic | Development, tests and portfolio demonstration | Product Owner | Repository/runtime users | Retain while useful and licensed; clearly marked synthetic |

## 6. Purpose and lawful-basis decision register

The project records purposes now but does not select a lawful basis for a municipality.

| Purpose | Candidate legal question | Sprint 0 state |
|---|---|---|
| Receive and manage a street report | Is processing necessary for a public task or legal obligation under the municipality’s mandate? | Legal basis unconfirmed; real intake blocked |
| Contact a reporter and send updates | Which contact fields are necessary, and is optional anonymous reporting required? | Unconfirmed |
| Publish a minimized incident/status view | What public-task/transparency authority applies, and what balancing/minimization is required? | Unconfirmed; human publication gate required |
| Detect duplicate candidates and recommend priority | Is automated advisory processing necessary and proportionate, and what human safeguards apply? | DPIA review required; no solely automated decision |
| Maintain audit and security evidence | Which legal/security obligations apply and for how long? | Unconfirmed |
| Later contractor/inspection/warranty processing | What contract, public-task and evidence requirements apply? | Outside MVP; legal/privacy review required |
| Product analytics | Is analytics necessary, can it be aggregate, and is consent genuinely optional if used? | Disabled by default until decided |

Consent must not be used as a convenient default where refusing or withdrawing it would not be genuinely free. Core municipal processing needs an independently confirmed basis. Marketing, optional analytics or unrelated research are separate purposes and are not authorized.

## 7. Visibility and purpose matrix

Legend: **A** allowed for declared purpose, **M** minimized projection only, **N** denied, **L** later release and review required.

| Data / role | Public | Reporter via token | Intake/case employee | Manager/admin | Inspector | Contractor | Support/platform | AI/CV worker |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Citizen contact | N | M: own masked/contact preference | A | A when needed | N by default | N | N; justified JIT exception only | N |
| Original text/media | N | M: own submission confirmation | A | A when needed | L: assigned evidence | N by default | N; justified JIT exception only | M: bounded job only |
| Public derivative | A after gate | A | A | A | A | M if assignment requires | M | M if needed |
| Report/incident operational record | M approved projection | M: own status | A | A | L: assigned | L: assignment projection | M: support metadata only | M: bounded advisory input |
| Human decisions/reasons | M approved summary | M: own outcome | A | A | L: assigned | M: own assignment outcome only | N by default | N |
| Audit events | N | N | M: own case where required | A by role/purpose | N | N | M: platform events only | N |
| Priority/duplicate advice | N by default | N | A | A | L | N | N | Produces bounded output; no broad read |
| Secrets/tokens | N | N | N | N | N | N | M through secret manager, never plaintext display | Runtime injection only |
| Later repair/warranty evidence | N unless separately approved | N | L | L | L | L: assigned minimum | L: metadata only | L: bounded job |

Frontend hiding is not authorization. Every allowed cell requires server-side entity, role and purpose enforcement. Support access must be just-in-time, time-limited, reason/ticket linked and audited.

## 8. Restricted-original and public-derivative lifecycle

1. Receive the original into a Restricted quarantine location.
2. Validate size, type and parser safety without making it public.
3. Remove unnecessary embedded metadata from the derivative pipeline.
4. Detect or flag faces, plates, addresses and other identifying content.
5. Create a separate derivative object; never overwrite the original.
6. Record tool/model/version, source object, transformation time and result.
7. If processing fails or confidence is insufficient, keep the original Restricted and block publication.
8. An authorized human reviews uncertain or policy-required cases.
9. Publish only an approved minimized projection and derivative.
10. Keep the public object identifier distinct from the original identifier.
11. Correction or withdrawal revokes the public object/projection without erasing required audit history.
12. Deletion schedules must address original, derivative, thumbnails, caches, CDN, search/vector artefacts and backups.

Automated redaction success is evidence for review, not authorization to publish.

## 9. Data minimization at collection

Required MVP fields must be justified individually before implementation. Defaults:

- allow an anonymous or pseudonymous reporting option if municipal policy permits;
- make contact fields optional unless necessary for the declared service;
- request coarse/useful location rather than continuous device location;
- never collect national identifiers, payment data, demographic profiling or special-category data for the hero flow;
- warn citizens not to include unnecessary people, plates, addresses or documents;
- do not import address-book, device, advertising or cross-site identifiers;
- strip client filenames and unnecessary media metadata;
- do not require an account solely to track one report;
- do not collect exact background location;
- do not retain raw request bodies in logs.

Unexpected special-category or criminal-offence data is quarantined/restricted and escalated; it is not used for model training or public display.

## 10. AI, computer vision and embeddings

- Inputs are bounded to the minimum fields needed for one declared advisory job.
- Models have no direct database, tool, email, publication or state-change authority.
- Model output is schema-validated, versioned and stored separately from human decisions.
- Prompt text and outputs inherit the highest classification of their inputs.
- Production prompt-history retention is disabled by default.
- Report content is not used to train or fine-tune a model without a new purpose, basis, DPIA review and explicit approval.
- Embeddings are treated as personal data when they encode personal report content.
- A report deletion/restriction workflow must propagate to embeddings, caches and derived indexes.
- Similarity output only creates a DuplicateCandidate; it never merges or hides a report.
- CV may refuse unsuitable evidence and cannot accept a repair or establish liability.
- Provider outage or malformed output leads to visible manual handling, never invented fields.
- External model APIs are disabled until transfer, region, processor, retention and subprocessor questions are approved.

## 11. Telemetry, analytics and error handling

Allowlisted operational fields may include:

- timestamp;
- service/component;
- environment;
- privacy-safe correlation ID;
- route template, not raw URL/query;
- result/status class;
- duration and bounded resource metrics;
- internal error code;
- model/policy version without input content.

Prohibited telemetry fields include:

- report text, prompt content or images;
- name, email, telephone or precise private address;
- tracking token, session token, authorization header or signed URL;
- secrets or callback signatures;
- raw request/response bodies;
- EXIF or device identifiers;
- embeddings;
- unrestricted database rows.

Sentry or equivalent remains disabled for real data until region, processor terms, scrubbing, retention, access and test evidence are approved. Privacy canaries and automated tests must prove prohibited fields are removed before release.

## 12. n8n, email and external-provider boundaries

- The transactional outbox stores the approved business intent in PostgreSQL.
- n8n receives a minimized reference and delivery fields only; it is not a second case database.
- Execution history must not duplicate original media, report narratives or unnecessary contact data.
- Callbacks are signed, freshness checked, replay safe and idempotent.
- Email templates use approved minimized projections and confirmed recipients.
- No automated workflow selects a recipient, publishes content or changes final business state without prior authorized intent.
- Provider failure preserves persisted status and a manual/retry path.
- Provider selection requires processor terms, subprocessor list, region/transfer review, retention, deletion, access and incident-notification review.
- Development uses sink/fake providers and synthetic addresses.

## 13. Retention, deletion and backup principles

Numeric retention periods remain **Unapproved** until the municipality’s records schedule, public-record obligations, legal claims, security needs and data-subject rights are reconciled.

Required schedule dimensions:

| Data group | Start event | Required decision |
|---|---|---|
| Abandoned/unsubmitted uploads | Upload/quarantine time | Short automatic expiry and safe deletion |
| Citizen contact data | Case closure or last necessary contact | Earliest deletion/anonymization consistent with service/legal duty |
| Report and incident evidence | Submission/case closure | Municipal record schedule and dispute needs |
| Public derivative | Publication/case resolution | Unpublish, correction and archival rules |
| Assessment/embedding artefacts | Assessment creation/source deletion | Reproducibility versus minimization and propagation |
| Audit/security logs | Event time | Proportionate security/accountability schedule |
| n8n/email history | Delivery completion | Minimum troubleshooting/evidence period |
| Backups | Backup creation | Rolling expiry, deletion propagation limits and restore rules |
| Later warranty/contract evidence | Work/claim closure | Contract/legal schedule |
| Data-subject request file | Request closure | Legal/privacy schedule |

Deletion must be an auditable stateful workflow, not an untracked hard-delete command. Where erasure is not allowed, the system records the reason, authority, restriction and review date. Restoring an older backup must reapply tombstones/deletion queues before normal use.

## 14. Data-subject rights readiness

Before real-data use, the controller must define intake, identity verification, ownership and deadlines for:

- access;
- rectification;
- erasure where applicable;
- restriction;
- objection;
- portability where applicable;
- withdrawal of any genuinely consent-based optional processing;
- information about advisory automated processing and meaningful human review.

The system needs searchable identifiers without exposing data broadly, export redaction, correction history, derived-data propagation, request audit and a safe refusal/escalation path. The portfolio prototype may demonstrate these with synthetic fixtures only and cannot claim an operational rights process.

## 15. DPIA screening

A formal DPIA decision belongs to the controller and Privacy Officer/FG. Sprint 0 screening identifies likely high-risk factors:

| Factor | Relevance | Required review |
|---|---|---|
| Systematic public-service triage | Reports affect municipal attention and public space operations | Necessity, proportionality and human safeguards |
| AI-assisted categorization/duplicate/priority | Could shape employee attention even if advisory | Bias, explainability, contestability and no solely automated decision |
| Images in public space | May contain faces, plates, homes and bystanders | Collection warning, redaction, publication and retention |
| Location and time combinations | Can reveal behavior or sensitive context | Precision minimization and access/publication controls |
| Public tracking/public status | Enumeration or linkage can expose a reporter/case | Token and minimized-projection design |
| Employee/contractor monitoring | Audit and assignment data may profile workers | Purpose, proportionality, transparency and access |
| Dataset linking/open context | Combining sources may increase identifiability | Linkage necessity and re-identification analysis |
| Later repair/warranty evidence | May affect contractors, disputes and liability | Separate DPIA/legal/procurement review |
| Providers/telemetry/model infrastructure | May introduce subprocessors or transfers | Contract, region, retention, access and transfer assessment |
| Future multi-tenancy | Cross-municipality exposure would be severe | Isolation design and security/privacy verification |

Until the controller records whether a DPIA is required and completes any required DPIA, real-data pilots and operational deployment remain blocked.

## 16. Privacy threat and control mapping

| Privacy risk | Related threat IDs | Required control/evidence |
|---|---|---|
| Tracking exposes another citizen’s case | TM-003 | Entropy, expiry, revocation, rate-limit and generic-error tests |
| IDOR/cross-role disclosure | TM-004, TM-005, TM-021 | Server-side negative authorization matrix |
| Prompt/model leakage or repurposing | TM-006, TM-011, TM-029 | Bounded adapters, no tools, scrub tests, version/purpose review |
| n8n history or provider leakage | TM-008, TM-009 | Minimized signed payloads, retention/access review |
| Public derivative exposes identifiers | TM-016, TM-019 | Separate objects, EXIF removal, redaction evaluation and human gate |
| Backup or wrong-environment disclosure | TM-014 | Encryption, environment binding, isolated restore test |
| Support access without purpose | TM-028 | Just-in-time reasoned access and review |
| Wrong recipient/publication | TM-030 | Approved projection, recipient confirmation and delivery audit |

Approval of this baseline does not lower any threat rating or prove a control exists.

## 17. Safe failure and recovery

| Failure/uncertainty | Safe behavior | Prohibited behavior |
|---|---|---|
| Redaction unavailable or uncertain | Keep original Restricted; block public derivative; require review | Publish best effort |
| Lawful basis/purpose unclear | Disable real-data capability and escalate | Rely on generic consent text |
| Retention period unresolved | Block production data for that category; retain only synthetic fixtures | Choose “forever” or an arbitrary number |
| Authorization context missing | Deny and provide privacy-safe correlation ID | Grant broad fallback access |
| Provider terms/region unknown | Keep provider disabled; use synthetic local fake | Send real data for convenience |
| AI/CV unavailable or malformed | Record failure; continue human path | Invent or silently accept output |
| Deletion cannot propagate | Restrict affected data, record blocker and escalate | Claim deletion complete |
| Backup restore contains erased records | Isolate restore; reapply deletion/tombstones | Return environment to service directly |
| Telemetry scrub fails | Disable affected telemetry/export and alert | Continue collecting prohibited fields |
| Wrong publication/recipient suspected | Revoke/contain, preserve privacy-safe evidence and notify owners | Quietly overwrite history |
| Data-subject identity uncertain | Pause disclosure and use approved verification/escalation | Reveal data based on weak matching |

## 18. Required implementation evidence backlog

Before public synthetic demo:

- fixture lint proving names, contacts, media and cases are synthetic;
- no real KLIC or production credentials/data;
- public/restricted object separation test;
- metadata stripping and redaction uncertainty fixture;
- telemetry allowlist and prohibited-field canaries;
- fake email/n8n endpoints.

Before any real citizen intake:

- confirmed controller, purposes, lawful bases and privacy notice;
- approved field-by-field minimization;
- retention/deletion schedule;
- tracking-token security/privacy tests;
- data-subject rights procedure and export/correction/deletion tests;
- processor/subprocessor/region/transfer review;
- privacy-safe incident procedure;
- DPIA decision and completed DPIA if required;
- independent privacy, legal and security approval.

Before municipal employee access:

- approved role/entity/purpose matrix;
- IDOR and contractor-negative tests;
- sensitive-access reason and audit completeness;
- support just-in-time access procedure;
- employee transparency and monitoring review.

Before AI/CV/embedding enablement:

- necessity/proportionality assessment;
- dataset/prompt/model purpose and provenance;
- deletion propagation tests;
- injection, extraction, malformed, timeout and refusal cases;
- bias/performance evaluation by category and relevant context;
- human-review and contestability evidence;
- no external provider until processor/transfer questions close.

Before later InfraProof:

- separate purpose/lawful-basis/DPIA review;
- contractor and inspector data projections;
- evidence integrity, retention and dispute process;
- contract/warranty/legal review;
- no autonomous liability, claim, payment or repair acceptance.

## 19. Open decisions and review gaps

| ID | Open decision | Owner / required reviewer | Release impact |
|---|---|---|---|
| P-01 | Controller identity and processing-role allocation | Municipal legal/privacy | Blocks all real data |
| P-02 | Lawful basis per purpose and anonymous-reporting policy | Controller + Privacy Officer/FG | Blocks real intake |
| P-03 | Field-level necessity and privacy-notice wording | Service owner + Privacy Officer/FG | Blocks real intake |
| P-04 | Retention/deletion schedule for every D-ID | Records/legal/privacy | Blocks affected real data |
| P-05 | DPIA requirement and, if required, completed DPIA | Controller + Privacy Officer/FG | Blocks pilot/deployment |
| P-06 | Data-subject rights and identity-verification procedure | Privacy/service owner | Blocks real service |
| P-07 | Public derivative/redaction review policy | Publication/privacy owner | Blocks public media |
| P-08 | Tracking-token lifetime, revocation and projection | Product + privacy/security | Blocks public tracking |
| P-09 | OIDC roles, employee/contractor purpose rules and support access | Municipal owner + privacy/security | Blocks staff access |
| P-10 | Provider list, contracts, subprocessors, regions and transfers | Procurement/legal/privacy/security | Blocks providers |
| P-11 | Telemetry/Sentry fields, retention, region and access | Platform + privacy/security | Blocks real telemetry |
| P-12 | AI/CV/embedding necessity, evaluation and derived-data deletion | AI/data + Privacy Officer/FG | Blocks real AI/CV |
| P-13 | Backup deletion propagation and restored-data reconciliation | Platform + privacy/security | Blocks production recovery claim |
| P-14 | Later contractor, inspection and warranty purposes | Legal/procurement/privacy/domain | Blocks InfraProof |
| P-15 | Future tenant isolation and municipal data-sharing rules | Architecture + municipal privacy/security | Blocks multi-tenancy |

## 20. Review and release gates

- **Sprint 0 acceptance:** the inventory, classification, purpose, visibility, lifecycle, DPIA questions and evidence backlog are coherent; unresolved decisions stay open.
- **Feature design:** every field maps to a D-ID, purpose, class, recipient and retention state.
- **Feature merge:** applicable privacy/security tests pass and no prohibited field crosses logs, public views, contractor views or providers.
- **Portfolio demo:** synthetic/open approved data only; limitations visible.
- **Shadow pilot:** controller, lawful basis, notice, retention, rights, provider, DPIA and independent reviews completed for the actual municipality/environment.
- **Operational pilot:** separately authorized and outside the current baseline.

Any new data category, purpose, recipient, provider, model, export, public view, role, integration, tenant or environment requires this document and the threat model to be reviewed.

## 21. Approval record

| Role | Name | Decision | Date | Scope |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Approved | 3 August 2026 | Sprint 0 privacy structure, classification, boundaries and design obligations only |
| Privacy Officer / FG | Unassigned | Pending | — | GDPR roles, necessity, proportionality, DPIA, rights and retention |
| Municipal controller/domain owner | Unassigned | Pending | — | Purposes, lawful basis, operations and records schedule |
| Legal/procurement reviewer | Unassigned | Pending | — | Contracts, providers, transfers and later warranty processing |
| Independent security reviewer | Unassigned | Pending | — | Technical privacy and access controls |
| Accessibility reviewer | Unassigned | Pending | — | Accessible notices, choices and rights journeys |

Product Owner approval confirms the Sprint 0 privacy structure, classifications, boundaries and design obligations only. It does not complete a DPIA, choose a lawful basis, approve retention, authorize providers or real data, close external review, or permit deployment.
