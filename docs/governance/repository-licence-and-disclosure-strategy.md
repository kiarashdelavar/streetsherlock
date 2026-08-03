# Repository Licence and Responsible Disclosure Strategy

| Field | Value |
|---|---|
| Document ID | GOV-LIC-001 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Approval | Product Owner standing authorization — 3 August 2026 |
| Applies to | StreetSherlock repository, releases, demonstrations and retained evidence |
| External legal review | Pending |
| Current repository licence state | No blanket grant unless and until exact licence files are present on the applicable revision |

## 1. Purpose

This document defines how StreetSherlock will license material it owns, preserve third-party obligations, prevent accidental publication, and receive vulnerability reports. It is a governance baseline, not legal advice and not proof that every future file is distributable.

A public repository does not by itself make its contents open source. Rights are granted only by an applicable licence included in the relevant repository revision. Missing, ambiguous, incompatible or unverified rights fail closed.

## 2. Approved licensing direction

The intended licensing model is:

- original software source code: Apache License 2.0;
- original prose documentation and original diagrams: Creative Commons Attribution 4.0 International (CC BY 4.0);
- repository metadata, configuration and small code-like examples: Apache License 2.0 unless a file states otherwise;
- third-party material: its own verified licence only;
- datasets, fixtures, model weights, map assets, fonts, icons, photographs, video, screenshots and generated artefacts: never covered by the repository-wide grant unless explicitly listed with provenance and permission;
- project name, logos and other brand identifiers: no trademark or branding rights are granted by the code or documentation licences;
- security reports, personal data, confidential material, credentials and restricted evidence: not licensed for public redistribution.

The exact unmodified standard licence texts, copyright notice, SPDX identifiers and attribution files must be added and checked before a release is described as Apache-2.0 or CC BY 4.0. Until that implementation task passes, the repository remains in the current state stated in the control table.

## 3. Scope matrix

| Class | Default treatment | Required repository evidence | Publication gate |
|---|---|---|---|
| original application code | intended Apache-2.0 | author/commit history, root licence, SPDX or declared path scope | licence files present and scan passes |
| original test code | intended Apache-2.0 | same as application code | no restricted fixtures or secrets |
| original infrastructure/configuration | intended Apache-2.0 | ownership and dependency scan | environment values are non-secret |
| original prose documentation | intended CC BY 4.0 | documentation notice and path scope | sources and quotations are attributed |
| original Mermaid/architecture diagrams | intended CC BY 4.0 | source file and attribution notice | no confidential topology or credentials |
| API/schema definitions | intended Apache-2.0 | explicit path scope | no copied incompatible schema |
| generated clients/bundles | licence follows lawful inputs and generator obligations | generator, input and dependency manifest | reproducible and notices retained |
| dependency source/binaries | upstream licence only | lockfile, SBOM and notice record | allowed licence and version verified |
| containers/base images | upstream terms only | image digest, source and licence record | approved registry/source and scan |
| synthetic fixtures | project-defined grant only when original | generator, seed, manifest and SHA-256 | no real/reconstructed person or restricted source |
| public/open datasets | source-specific terms only | exact product/version/URL/licence/capture date | product-level rights verified |
| real municipal/citizen/contractor data | excluded | written authorization and governance record | prohibited in repository |
| KLIC data | excluded | none permits repository inclusion | prohibited; synthetic contract mock only |
| Amsterdam WIOR data | blocked pending precise reusable terms | exact licence decision | no payload committed while blocked |
| NDW data | blocked until product and licence are frozen | exact product-level decision | no payload committed while blocked |
| map tiles/styles/geocoding responses | provider terms only | provider, endpoint, attribution and cache rules | offline redistribution expressly allowed |
| model weights/embeddings | model-specific terms only | model card, version, checksum, licence and use limits | compatibility/security/privacy review |
| fonts/icons/media | asset-specific terms only | creator/source/licence/attribution | redistribution rights verified |
| screenshots/demos | derivative and privacy review required | build, fixture and asset manifest | no personal/restricted/confidential content |
| AI-generated content | no automatic ownership assumption | tool/model, prompt class, human review and source check | rights and similarity risks reviewed |
| logos/trademarks | reserved | ownership/permission record | separate written brand permission |
| vulnerability reports | confidential handling | restricted case record | coordinated disclosure decision only |
| build/test evidence | internal/restricted by default | evidence manifest and privacy scan | approved public derivative only |

## 4. Repository layout and notices

Before the first licensed software release, the repository must contain:

1. a root `LICENSE` with the exact Apache License 2.0 text;
2. a documentation licence notice or exact CC BY 4.0 text whose path scope is unambiguous;
3. `NOTICE` for required attributions and material notices;
4. `THIRD_PARTY_NOTICES` or a generated equivalent tied to the released revision;
5. `SECURITY.md` with the supported-version and private-reporting route;
6. a source/licence/provenance register for non-code inputs and fixtures;
7. an SBOM for released application/container artefacts;
8. contribution terms explaining that contributors may submit only material they can license under the applicable project terms.

A path-specific licence or notice overrides a repository default only for that path. Overrides must be explicit, machine-readable where practical, and reviewed for compatibility.

## 5. SPDX and file-level rules

- Use SPDX expressions that exactly match the applicable terms.
- Do not write `Apache-2.0` on third-party, generated or mixed-origin files unless the rights actually allow it.
- Preserve upstream copyright, licence and notice text.
- Vendored code requires an exceptional, documented reason and its complete upstream notices.
- Copying from tutorials, answers, snippets or generated suggestions requires origin and licence review; “small” does not mean unrestricted.
- Modified third-party files must retain the original notice and clearly record modification where required.
- Dual-licensed inputs must record which compatible option StreetSherlock relies on.
- Unknown, custom, source-available, non-commercial, no-derivatives or field-of-use-restricted terms require explicit legal review; they are not silently treated as open source.

## 6. Dependency and supply-chain policy

Each dependency or build input must have:

- exact package/image/model name and resolved version or digest;
- authoritative source;
- declared licence expression and notice requirements;
- reason for use and owning component;
- automated vulnerability and licence scan result;
- transitive dependency visibility;
- replacement/removal path for a later incompatibility;
- release evidence tied to the commit and lockfile.

A dependency is blocked when its source, licence, maintainer provenance, integrity or redistribution rights cannot be established. A passing scanner is evidence, not legal authorization; false positives and false negatives require human review.

## 7. Data, fixture and media policy

The approved E00-07 source/licence/provenance register remains authoritative for data decisions. This strategy does not reopen blocked sources.

Repository fixtures must be deterministic, synthetic or precisely licensed. Synthetic data must not be derived so closely from a real person, address, report, work order or restricted dataset that it recreates protected information. Each fixture manifest records its generator/source, intended use, classification, licence decision, created/captured date and SHA-256.

Restricted originals must never be made public merely because a derivative was approved. Redaction, cropping, transformation, embedding or aggregation does not automatically create redistribution rights.

## 8. Contributions

Until a separate contributor agreement is justified, contributions use an inbound-equals-outbound model:

- contributors affirm they have the right to submit the work;
- submitted original code is offered under the repository’s applicable Apache-2.0 terms;
- submitted original documentation is offered under the applicable CC BY 4.0 terms;
- sign-off, provenance or additional review may be required for high-risk contributions;
- no employer/client/confidential code, real personal data, restricted municipal data, secrets or unlicensed assets may be submitted;
- maintainers may reject or remove material when rights cannot be demonstrated.

Approval of a pull request is not a substitute for provenance evidence.

## 9. Responsible vulnerability disclosure

Security researchers and users must be directed to a private channel supported by the repository host, preferably GitHub Private Vulnerability Reporting. A dedicated security contact may be added only when it can be monitored reliably.

Reports should include:

- affected revision/version and component;
- clear reproduction steps or proof of concept;
- expected and observed security impact;
- prerequisite access and configuration;
- relevant logs/screenshots with secrets and personal data removed;
- suggested mitigation if known;
- safe contact method for follow-up.

Public issues, discussions and pull requests must not contain live exploit details, credentials, personal data, restricted evidence or instructions that materially increase immediate harm.

## 10. Triage and coordination workflow

| Phase | Required action | Evidence |
|---|---|---|
| receive | restrict access, assign case ID, acknowledge when operationally possible | private timestamp and channel |
| validate | reproduce safely using synthetic/local data; reject unsafe testing requests | validation notes and affected versions |
| classify | assess impact, exploitability, exposure and affected authority boundaries | severity rationale |
| contain | revoke/rotate/isolate where needed without destroying evidence | incident/action log |
| remediate | create private fix, regression tests and rollback plan | commit/test references |
| verify | independent or second-person review where risk warrants | review and test record |
| coordinate | agree publication timing with reporter and affected providers | communication record |
| release | publish fixed version and concise advisory without sensitive data | release/advisory link |
| learn | update threat model, controls, backlog and disclosure process | linked follow-up issues |

No fixed response or remediation SLA is promised until an accountable security function and monitored channel exist. Silence must not be represented as acceptance of disclosure terms.

## 11. Safe-harbour boundary

The project may later publish a good-faith safe-harbour statement after legal review. This Sprint 0 baseline does not grant authorization to:

- access accounts, systems, tenants, environments or data without permission;
- test production, municipal or third-party systems;
- perform denial of service, social engineering, physical intrusion or persistence;
- exfiltrate, retain or publish personal/confidential data;
- degrade availability or alter authoritative records;
- violate provider terms or applicable law.

Researchers should minimize access, stop after demonstrating impact, preserve confidentiality and use synthetic/local targets wherever possible.

## 12. Disclosure decisions

A maintainer-owned case record decides whether, when and how to disclose. The decision considers active exploitation, affected users/providers, patch availability, verification, legal/privacy constraints and whether publication creates disproportionate risk.

Advisories must distinguish verified facts from hypotheses, identify affected and fixed versions, describe mitigations, credit reporters with consent, and avoid credentials, personal data, restricted source material or unnecessarily weaponized detail.

## 13. Release and publication gates

A public release is blocked if any applicable check fails:

1. intended standard licence texts and scopes are present;
2. source/licence/provenance register has no unresolved included source;
3. dependency licence scan and human exception review pass;
4. SBOM and required notices match the release;
5. fixture/media/model rights and attribution pass;
6. secret and restricted-marker scans pass;
7. privacy classification permits the exact public artefacts;
8. generated artefacts preserve notices and reproducibility evidence;
9. README claims match the actual licence state;
10. supported security-reporting channel is available;
11. no critical/high unresolved publication, rights or disclosure risk exists;
12. release evidence records commit, digests, manifests and reviewer.

Removing a file from the latest revision does not remove it from Git history. Accidental publication requires containment, history/removal assessment, credential rotation where applicable, notification decisions and preserved incident evidence.

## 14. Verification backlog

| ID | Obligation | Planned evidence | Current state |
|---|---|---|---|
| LIC-T01 | exact Apache-2.0 text and intended software scope | file/hash/path review | Not Run |
| LIC-T02 | exact CC BY 4.0 documentation notice and scope | file/hash/path review | Not Run |
| LIC-T03 | contribution terms match inbound/outbound model | review test | Not Run |
| LIC-T04 | dependency licence allow/block rules | CI fixture tests | Not Run |
| LIC-T05 | SBOM/notice generation is reproducible | clean-clone evidence | Not Run |
| LIC-T06 | prohibited-source fixture fails the gate | negative CI test | Not Run |
| LIC-T07 | secret/restricted marker blocks release | negative CI test | Not Run |
| LIC-T08 | generated/vendored notice preservation | fixture test | Not Run |
| LIC-T09 | private vulnerability reporting route works | controlled channel check | Not Run |
| LIC-T10 | security template avoids public sensitive reports | repository inspection | Not Run |
| LIC-T11 | release archive matches licence/notices/SBOM | release-candidate check | Not Run |
| LIC-T12 | README and package metadata state rights accurately | drift test | Not Run |

These are implementation obligations for Sprint 1 and later release work. Approval of this document is not a passing result.

## 15. Open decisions and external gates

The following remain pending:

- independent legal review of the Apache-2.0/CC BY 4.0 split and contribution wording;
- copyright-holder and year formatting;
- operational security contact and supported-version policy;
- safe-harbour wording;
- municipality, customer or pilot-specific confidentiality and disclosure duties;
- exact licences for Amsterdam WIOR, the selected NDW product and any later source;
- model, map, font, icon and media selections not yet frozen;
- release automation and evidence retention implementation.

A later decision may replace the intended licences before release. Such a change requires compatibility and contributor-rights analysis and a controlled update; it cannot retroactively revoke rights already validly granted for an earlier revision.

## 16. Approval boundary

Product Owner approval dated 3 August 2026 accepts this licensing direction, classification rules, release gates, contribution model and responsible-disclosure process as the Sprint 0 baseline.

It does not:

- activate a licence whose exact text is absent;
- grant rights over third-party, restricted or personal material;
- authorize real data, a pilot, deployment or production;
- complete legal, municipal, privacy, security or accessibility review;
- claim the disclosure channel, scans, SBOM, notices or verification tests are implemented;
- permit public release of any blocked source or security detail.
