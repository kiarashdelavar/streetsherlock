# Interaction, Accessibility, and Recovery State Matrix

| Field | Value |
|---|---|
| Document ID | SS-A11Y-001 |
| Work item | E00-08 |
| Version | 1.0 |
| Status | Approved |
| Owner | Kiarash Delavar |
| Product Owner | Kiarash Delavar |
| Approval | Approved by Product Owner on 2 August 2026 |
| Review date | 2 August 2026 |
| Next review | Before Sprint 1 UI scaffolding and whenever a critical journey changes |
| Required reviewers | Product Owner self-review; independent accessibility, service-design, privacy and security review remain pending |
| Controlled baseline | `docs/MASTER_PROJECT_SPEC.md` |
| Page source | `../product/low-fidelity-wireframes.md` |
| Target | WCAG 2.2 AA design target and applicable EN 301 549 baseline; no conformance claim |

## 1. Purpose

This matrix makes non-happy paths part of the designed product. It assigns a visible message, preserved state, allowed next action, focus/status behavior, authority boundary, and future test evidence to each critical page state.

A page is not implementation-ready when only the ideal screenshot is defined.

## 2. State vocabulary

| State ID | State | Meaning | Must not be confused with |
|---|---|---|---|
| ST-LOAD | Loading | A bounded request is in progress | Empty results |
| ST-EMPTY | Empty | A successful query returned no items | Loading or failure |
| ST-VALID | Validation failure | User input failed a known rule | Server outage |
| ST-PERM | Permission denied | Authenticated actor lacks authority or session is invalid | Record absence |
| ST-TIME | Timeout | Completion is unknown or exceeded the bounded time | Confirmed failure |
| ST-PART | Partial data | Some named source/section is unavailable or stale | Complete data |
| ST-OFF | Offline | Browser/network is unavailable | Backend rejection |
| ST-UP | Upload failure | One or more media transfers/validations failed | Whole report failure |
| ST-AI | AI unavailable/refused/invalid | Advisory result is not usable | Human workflow blocked |
| ST-PRIV | Privacy review/block | Safe derivative is unavailable or not approved | Source report deletion |
| ST-CONF | Conflict | The persisted version changed since the user loaded it | Validation error |
| ST-RETRY | Retry pending | An explicitly requested safe retry is queued/running | A new business decision |
| ST-SUCC | Success | Backend-confirmed outcome is complete | Optimistic UI assumption |

## 3. Universal interaction contract

Every interactive surface must meet these design requirements, with implementation evidence added later:

- A skip link reaches the main task.
- The page has one descriptive `h1`; headings reflect hierarchy.
- Controls have persistent programmatic names; placeholder text is not a label.
- Instructions identify required fields before input.
- Validation is shown in a summary and next to each field, linked with focus movement.
- Keyboard order follows visual/reading order.
- Focus is visible and is not hidden by sticky content.
- Opening a dialog moves focus inside; closing returns focus to the invoker.
- Dynamic status is announced once at an appropriate priority without stealing focus.
- Meaning never relies on colour, map position, animation, hover or icon alone.
- Status text includes what happened, what was preserved, and what the user can do.
- Repeated navigation and help appear consistently.
- Language changes update the page language metadata and keep the user in context.
- Motion is unnecessary for understanding and respects reduced-motion preferences.
- Touch targets aim for at least 44 by 44 CSS pixels pending formal criteria mapping.
- At 200% zoom and 400% text reflow, the critical task remains available without clipped actions.
- Session expiry preserves only data that policy permits and does not expose it to the next user.
- Error references/correlation IDs contain no personal data.

## 4. Public report journey matrix

| Page/state | Visible response | Preserved state | Allowed next action | Focus/announcement | Authority/privacy control |
|---|---|---|---|---|---|
| PUB-01/ST-PART | Optional content unavailable; core explanation/actions remain | None needed | Report or track | Status announced politely | No customer/municipal claim |
| PUB-02A/ST-VALID | Summary plus linked description error | Other valid draft fields | Correct and continue | Focus summary, then field | Do not send draft to AI |
| PUB-02A/ST-OFF | Offline notice before server work | Local form only within approved session policy | Retry or safely exit | Polite announcement | No uncontrolled persistence |
| PUB-02B/ST-PERM | GPS permission denied is neutral guidance | Description | Search/manual location | Focus manual alternative | No coercive permission request |
| PUB-02B/ST-PART | Map/geocoder unavailable | Description and typed location | Use manual location or retry | Map failure announced; focus alternative | Do not invent coordinates |
| PUB-02B/ST-VALID | Location missing/too imprecise for rule | Description and attempted location | Correct location | Linked summary/field focus | Explain minimum, not hidden rule |
| PUB-02C/ST-UP | Per-file reason and retry/remove action | Description, location, valid files/contact | Retry, remove, or continue without optional file | File row announced | Failed upload is not accepted evidence |
| PUB-02C/ST-VALID | Type/signature/size/count rule explained | Other valid inputs | Replace/remove file | Focus file error | Filename/MIME alone never trusted |
| PUB-02C/ST-OFF | Upload paused/failed; no false completion | Text/location and confirmed uploads | Reconnect and retry/remove | Assert only meaningful change | No duplicate object on retry |
| PUB-02D/ST-LOAD | Skeleton/status with “checking nearby incidents” | Full draft | Wait or cancel request safely | Polite status | No candidate decision |
| PUB-02D/ST-EMPTY | “No nearby open incident found” | Full draft | Continue separate report | Empty result announced | Does not prove no real incident |
| PUB-02D/ST-TIME | Nearby check unavailable | Full draft | Continue or retry | Focus recovery actions | Never block submission |
| PUB-02D/ST-PART | Some context unavailable/stale | Full draft and available candidates | Review limitations, continue | Missing source named | Public-safe candidate fields only |
| PUB-02E/ST-VALID | Server validation summary by section | All valid draft sections | Edit affected section | Focus summary | No partial report committed |
| PUB-02E/ST-TIME | Submission outcome unknown | Draft and idempotency key | Check/retry safely | Assertive once | Never tell user to blindly duplicate |
| PUB-02E/ST-OFF | Offline before confirmation | Draft under approved policy only | Reconnect and submit | Polite status | No “received” claim |
| PUB-02E/ST-SUCC | Navigate to committed confirmation | Tracking reference | Store/track | Focus confirmation heading | Only after backend commit |
| PUB-03/ST-PART | Notification channel unavailable, report still received | Report/tracking | Track manually | Status separates report from delivery | No rollback of accepted report |
| PUB-04/ST-VALID | Generic invalid/expired token message | None | Re-enter or request help | Focus token control | No record-existence leak |
| PUB-04/ST-EMPTY | Report exists; no public update yet | Tracking session | Refresh later | Explain current received state | No internal queue detail |
| PUB-04/ST-TIME | Timeline unavailable | Token retained for current attempt | Retry | Focus retry | No cached cross-user data |
| PUB-04/ST-PART | Named timeline source delayed | Available public events | Retry missing section | Partial banner announced | Never substitute internal events |
| PUB-05/ST-EMPTY | Incident has no approved public notes | Public incident shell | Follow/join or return | Empty section text | No internal note fallback |

## 5. Municipal review matrix

| Page/state | Visible response | Preserved state | Allowed next action | Focus/announcement | Authority/audit control |
|---|---|---|---|---|---|
| OPS-01/ST-PERM | Generic sign-in/session error | No restricted view | Retry sign-in | Focus sign-in heading/action | No configuration leak |
| OPS-02/ST-LOAD | Dated loading state per tile | Shell/role | Wait or navigate | Polite region status | No stale count presented as current |
| OPS-02/ST-EMPTY | “No items need review” plus last refresh | Filters/time | Open map/list | Empty status | Not a service-health claim |
| OPS-02/ST-PART | Named service/source unavailable | Available counts labelled | Open manual queue/recovery | Partial banner | No invented zero |
| OPS-03/ST-EMPTY | No result for active filters | Filters | Reset filters | Focus empty heading/reset | Not “no municipal work” |
| OPS-03/ST-TIME | Queue request timed out | Filters/sort/page | Retry | Focus retry | No bulk fallback decision |
| OPS-03/ST-PERM | Role cannot access review queue | Route intent only | Return to allowed home | Focus denial heading | Backend denies; no record hints |
| OPS-04/ST-PART | Map layer unavailable | Filters and list results | Use list/retry map | Announce map only | Same authorized query projection |
| OPS-04/ST-EMPTY | No results in both equivalent views | Filters | Reset/change filters | Focus results heading | Never fabricate map marker |
| OPS-04/ST-TIME | Query timed out | Filters/view | Retry or narrow query | Focus recovery | Preserve URL state |
| OPS-05/ST-PRIV | Safe derivative unavailable/uncertain | Source report and transformation evidence | Correct/approve/block according to role | Assertive publication block | Source preserved; public access denied |
| OPS-05/ST-AI | Assessment absent, refused, malformed or timed out | Report/derived content | Continue manual review or retry provider | Advisory region announced | No automatic category/link |
| OPS-05/ST-PERM | Original media/contact not authorized | Safe permitted projection | Continue with permitted data | Denial inside region | Access attempt recorded where required |
| OPS-05/ST-PART | A derived/media/context source is stale/missing | All named available sections | Manual review/retry source | Partial banner | Missing data cannot become neutral evidence |
| OPS-06/ST-EMPTY | No candidate met bounded retrieval | Report | Keep separate/create incident via authorized flow | Empty explanation | No automatic incident creation |
| OPS-06/ST-AI | Semantic factor unavailable | Deterministic candidates/factors | Review without semantic signal | Missing factor labelled | Score recalculated/explained honestly |
| OPS-06/ST-CONF | Candidate/incident changed | Unsubmitted decision/reason | Reload and compare; reapply | Focus conflict heading | No partial link/rejection |
| OPS-06/ST-PERM | Actor lacks link authority | Candidate evidence read-only if allowed | Return/escalate | Denial announced | No command sent |
| OPS-06/ST-SUCC | Accepted/rejected decision confirmed | Queue filters and history | Next item/open incident | Status then focus heading | Actor/time/reason/history appended |
| OPS-07/ST-CONF | Incident version changed | Unsubmitted note/choice if safe | Compare/reload/copy draft | Assertive conflict | No overwrite |
| OPS-07/ST-PART | Weather/assessment/delivery section unavailable | Core incident state | Work manually/retry section | Named partial state | Final state remains authoritative |
| OPS-07/ST-PERM | Section/action unauthorized | Allowed incident projection | Continue read-only/return | Region denial | Hidden content absent from response |
| OPS-08/ST-AI | Not applicable to deterministic engine; if advisory context fails, label missing | Incident and available verified facts | Defer or decide only under allowed policy | Missing context announced | LLM never supplies final priority |
| OPS-08/ST-PART | Policy factor/source missing or stale | Recommendation marked incomplete | Defer/manual escalation or authorized decision with reason if policy permits | Factor-level labels | Missing cannot equal zero |
| OPS-08/ST-CONF | Recommendation/incident version changed | Unsubmitted reason if safe | Reload and review again | Focus conflict | No stale final priority |
| OPS-08/ST-PERM | Actor cannot decide priority | Explanation read-only if allowed | Return/escalate | Denial | No decision audit event |
| OPS-08/ST-SUCC | Final priority confirmed/overridden | Decision record | Return to incident | Announce exact final value | Recommendation retained separately |
| OPS-09/ST-VALID | Public/internal content or transition invalid | Valid draft fields | Correct | Summary/field focus | No partial state or intent |
| OPS-09/ST-CONF | Incident changed | Draft message if safe | Reload/compare/reapply | Conflict heading | Transaction not applied |
| OPS-09/ST-PART | Notification service unavailable after approval | Approved state and pending intent | Open recovery; no re-decision | Separate decision/delivery statuses | n8n not state owner |
| OPS-09/ST-SUCC | State/public intent committed | Incident history | Track delivery | Exact result announced | Audit/outbox written transactionally |

## 6. Workflow, governance, and later field matrix

| Page/state | Visible response | Preserved state | Recovery | Safety boundary |
|---|---|---|---|---|
| GOV-03/ST-EMPTY | No failed/pending attempts for filters | Filters | Reset filters | Not a proof of overall reliability |
| GOV-03/ST-RETRY | Retry in progress with attempt number | Original intent/idempotency key | Refresh; do not trigger duplicate retry | Same approved content only |
| GOV-03/ST-SUCC | Delivery recorded once | Attempt history | Open audit | Does not alter incident decision |
| GOV-03/ST-CONF | Another operator already retried/completed | Attempt history | Reload | Duplicate command harmless |
| GOV-04/ST-PERM | Audit scope denied | Filters only | Return/escalate | No hidden content or entity-existence leak |
| GOV-04/ST-PART | Some events delayed/unavailable | Returned events and query time | Retry | Do not imply complete audit |
| GOV-05/ST-VALID | Configuration diff fails schema/policy | Draft version | Correct | Active version unchanged |
| GOV-05/ST-CONF | Active/draft version changed | User draft if safe | Compare/rebase | No silent overwrite/activation |
| FLD-02/ST-PERM | Camera/location permission denied | Assignment/form facts | Enable permission or use approved file/manual route | No covert capture |
| FLD-02/ST-OFF | Network unavailable | Only policy-approved bounded draft | Reconnect/submit later or safely exit | Offline persistence unresolved; roadmap only |
| FLD-02/ST-UP | Evidence upload failed | Assignment, checklist, confirmed files | Retry/remove | No submitted-evidence claim |
| FLD-02/ST-AI | Quality service unavailable/uncertain | Captured source evidence | Manual review/retake/submit if policy permits | No invented quality |
| FLD-03/ST-AI | Alignment/comparison refused | Original evidence pair | Retake/select valid pair/manual compare | No fabricated overlay |
| FLD-04/ST-CONF | Inspection/work version changed | Unsaved reason if safe | Reload/compare | No partial decision |
| CON-01/ST-PERM | Assignment unavailable/unauthorized | No assignment detail | Return/contact authorized channel | No existence/reporter leak |
| CON-02/ST-UP | Evidence/response upload failed | Valid form and confirmed files | Retry/remove | No municipal acceptance implied |
| CON-03/ST-PERM | Notice link expired/unauthorized | No package | Request new approved link | Short-lived authorized access |

All FLD/CON behavior is later-release planning, not StreetPulse MVP acceptance.

## 7. Status and message pattern

Every non-happy message contains:

| Part | Question answered | Example pattern |
|---|---|---|
| State | What happened? | “The nearby-incident check did not finish.” |
| Scope | What still works/is preserved? | “Your description, location and photo are saved in this report draft.” |
| Consequence | What did not happen? | “No report was submitted and no incident link was created.” |
| Action | What can I do? | “Continue without this check or try again.” |
| Evidence | What support reference is safe? | “Reference: 8-character correlation alias.” |

Avoid countdowns or automatic retries that can duplicate a business command. Background read retries may be bounded; write retries require idempotency and visible status.

## 8. Focus management by transition

| Transition | Focus destination |
|---|---|
| Page navigation | Main heading, unless preserving a list-return focus target |
| Validation failure | Error summary; links move to invalid field |
| Successful step | Next page heading |
| Inline upload result | File-row status; do not unexpectedly move focus |
| Dialog open/close | First meaningful dialog control / original invoker |
| Candidate decision success | Confirmation status then next logical item/incident heading |
| Conflict | Conflict heading and compare/reload actions |
| Permission denied | Denial heading |
| Map marker selection | Linked result heading; list alternative remains synchronized |
| Return to queue/map | Previously activated row/control with filters and scroll restored |
| Async partial failure | Status region announced without focus theft |
| Session expiry | Sign-in heading; explain whether any draft was preserved |

## 9. Map/list equivalence contract

For OPS-04 and location-related public surfaces:

- Both representations use the same authorized query, filters and result count.
- Every map feature has a corresponding list item with name/category, safe location text, status and open action.
- Selecting either representation synchronizes the other without requiring pointer input.
- Filter, sort, selected item and view are encoded in restorable navigation state where safe.
- Cluster count is not the only way to understand results.
- Shape/line/category meaning has text and non-colour cues.
- If map tiles, scripts or geocoding fail, the list/address route remains usable.
- Precise restricted coordinates are not exposed merely to provide equivalence.
- Keyboard and screen-reader users are not required to operate a spatial canvas to complete a task.

## 10. Bilingual and plain-language behavior

- The user explicitly controls Dutch/English; detected language is a suggestion.
- Switching language keeps the current safe draft/page state.
- Validation, status, recovery, privacy notice and confirmation text switch together.
- IDs, policy/model versions and source names remain stable; explanatory labels translate.
- Generated/normalized/translated text is labelled and never replaces the source.
- Final Dutch copy requires a qualified reviewer; machine translation is not approval.
- Dates, times, addresses and number formatting follow the active locale while audit values preserve canonical forms.

## 11. Implementation evidence map

| Evidence ID | Future evidence |
|---|---|
| A11Y-E01 | Automated semantic/name/contrast checks on critical pages |
| A11Y-E02 | Complete keyboard walkthrough of PUB-02, PUB-04, OPS-06, OPS-08 and OPS-09 |
| A11Y-E03 | Screen-reader spot checks for errors, step progress, status, candidate factors and timeline |
| A11Y-E04 | 200% zoom and 400% reflow captures at 360 px equivalent |
| A11Y-E05 | Map/list result-equivalence test |
| A11Y-E06 | Reduced-motion and animation-independent task test |
| A11Y-E07 | Touch target and focus-obscuring review |
| REC-E01 | Upload failure preserves prior valid input |
| REC-E02 | AI timeout/refusal/malformed output preserves manual review |
| REC-E03 | Candidate and priority conflict cause zero partial mutation |
| REC-E04 | Notification retry/callback sends at most once |
| PRIV-E01 | Restricted/contact fields absent from public/contractor responses and rendered pages |
| AUTH-E01 | Backend authorization tests for each sensitive route/action |

These evidence IDs define future verification; they are not results.

## 12. External validation gaps

The following remain open:

- formal WCAG 2.2/EN 301 549 applicability and independent evaluation;
- representative keyboard, screen-reader, low-vision, cognitive and motor-user research;
- Dutch plain-language review and municipal terminology;
- lawful privacy notice/contact/retention and session-draft behavior;
- exact emergency, abuse and safeguarding content;
- map provider accessibility and location-precision policy;
- field offline-storage and device-management controls;
- real municipal role/permission mapping.

## 13. Approval record

| Role | Name | Decision | Date | Scope |
|---|---|---|---|---|
| Product Owner | Kiarash Delavar | Approved | 2 August 2026 | State coverage and portfolio design target |
| Accessibility reviewer | Unassigned external reviewer | Pending | — | Standards mapping and conformance evidence |
| Privacy/security reviewer | Unassigned external reviewer | Pending | — | Draft, session, token, upload and restricted-state behavior |
| Municipal/service-design reviewer | Unassigned external reviewer | Pending | — | Real recovery expectations and language |

Approval makes this the Sprint 0 interaction baseline only. It is not a compliance statement, implementation result, real-data authorization, or release gate.
