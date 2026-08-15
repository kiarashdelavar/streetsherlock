# E01-11 accessible persisted Report and Incident evidence

| Field | Value |
|---|---|
| Issue | [E01-11 #41](https://github.com/kiarashdelavar/streetsherlock/issues/41) |
| Branch | `agent/e01-11-accessible-report-incident-view` |
| Fixture | `FIX-SYN-DEV-001` v1.0.0 |
| Environment | Local/CI synthetic configuration |
| Evidence state | Pending pull-request CI |

## Implemented boundary

- PostgreSQL remains the authoritative business-state store.
- `GET /api/public/records` reads Report and Incident from their separate tables.
- The response is a privacy-safe projection with no citizen contact or restricted fields.
- The API requires an approved synthetic realm role and denies missing/unauthorized identities.
- The Next.js route keeps the bearer token server-side.
- One record-type filter drives both the spatial markers and accessible list.

## Automated evidence

| Evidence | Expected result |
|---|---|
| `API-READ-001` | authorized request returns separate Report/Incident projections and retry behavior |
| `AUTH-PUB-001` | missing identity returns 401; unauthorized role returns 403; UI leaks no records |
| `A11Y-PUB-001` | spatial view names the equivalent list and both preserve the selected filter |
| `AT-S1-001` | the seeded Report and Incident are visibly and semantically distinct |

The E01-10 clean-migration verifier independently proves that the fixture records
persist in PostgreSQL. E01-11 API tests prove the authorization and projection boundary.

## Limitations

No submission, duplicate detection, real GIS source, citizen identity, production
deployment, municipal accuracy, accessibility conformance or public-service claim is made.
Manual keyboard/browser review remains required before any accessibility claim.
