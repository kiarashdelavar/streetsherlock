# E01-07 observability foundation evidence

| Field | Value |
|---|---|
| Issue | #37 — problem details, correlation IDs, privacy-safe logging and health |
| Requirements | QR-PRIV-001; QR-REL-001; QR-MAIN-001 |
| Data class | Synthetic Local/CI only |
| Tests | API-ERR-001..006; PRIV-TEL-001..006; RES-HEALTH-001 |
| Production readiness | Not claimed |
| Independent assurance | Pending |

## Implemented behavior

- API failures use `application/problem+json` with a stable, safe detail and correlation ID.
- A caller-supplied correlation ID is accepted only when it is a valid UUID; otherwise the API creates one.
- Every response includes `X-Correlation-ID`.
- Request logs contain only event name, method, matched route template, status and correlation ID.
- Query strings, headers, bodies, identifiers, exception messages and authentication data are not logged.
- `/actuator/health/liveness` and `/actuator/health/readiness` are separate, public, minimal probes.
- Health details remain hidden. The probes describe this process only and make no production availability claim.

## Repeatable check

From a clean checkout with Java 21 and Maven 3.9.11:

```bash
mvn -f apps/api/pom.xml clean test
```

Docker alternative:

```bash
docker run --rm \
  -v "${PWD}:/workspace" \
  -v streetsherlock-maven-cache:/root/.m2 \
  -w /workspace \
  maven:3.9.11-eclipse-temurin-21 \
  mvn -f apps/api/pom.xml clean test
```

The E01-07 tests verify unauthorized, forbidden, unknown-resource, valid and untrusted
correlation-ID paths; telemetry omission; and minimal liveness/readiness responses, including degraded readiness.

For each execution, record the source commit, JDK/Maven or container image version,
timestamp, command, expected/actual test counts, result and limitations. Do not mark
this record verified until the command passes on the named commit. A passing Local/CI
run is implementation evidence only; it is not production monitoring, privacy,
security, reliability or compliance approval.
