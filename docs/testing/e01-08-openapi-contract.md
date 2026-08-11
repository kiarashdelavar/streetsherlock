# E01-08 OpenAPI client and drift evidence

| Field | Value |
|---|---|
| Issue | #38 — generate TypeScript client from OpenAPI and detect drift |
| Requirements | QR-MAIN-001; GR-003 |
| Data class | Synthetic Local/CI only |
| Tests | CONTRACT-001..006 |
| Production readiness | Not claimed |
| Independent assurance | Pending |

## Implemented behavior

- Springdoc publishes the authenticated backend contract from typed controller responses.
- `packages/contracts/openapi.json` is the reviewed, versioned contract artifact.
- `OpenApiContractTest` compares the committed API paths, methods, operation IDs and
  response codes with the live Spring Boot OpenAPI document.
- `openapi-typescript@7.9.1` generates the TypeScript types, including the RFC problem shape.
- `pnpm contracts:check` generates into a temporary directory and fails with an actionable
  message and diff if the committed TypeScript file is stale.
- Contract fixtures and descriptions contain synthetic Local/CI data only.

## Repeatable checks

From a clean checkout with Java 21, Maven 3.9.11, Node 22.18.0 and pnpm 10.13.1:

```bash
mvn -f apps/api/pom.xml clean test
pnpm contracts:check
```

Docker alternative for the Java check:

```bash
docker run --rm \
  -v "${PWD}:/workspace" \
  -v streetsherlock-maven-cache:/root/.m2 \
  -w /workspace \
  maven:3.9.11-eclipse-temurin-21 \
  mvn -f apps/api/pom.xml clean test
```

To accept an intentional reviewed schema change:

```bash
pnpm contracts:generate
git diff -- packages/contracts
pnpm contracts:check
```

Record the commit, tool versions, timestamp, commands, expected and actual test
counts, result and limitations for each execution. Passing Local/CI checks does not
establish production, security, privacy, accessibility or compliance readiness.
