# E01-06 authorization evidence

| Field | Value |
|---|---|
| Issue | #36 — OIDC/dev identity boundary and seeded roles |
| Requirements | QR-SEC-001; PLAT-02/03 |
| Fixture | `infra/identity/streetsherlock-dev-realm.json` |
| Data class | Synthetic Local/CI only |
| Tests | AUTH-MATRIX-001; AUTH-IDOR-001..008; SEC-CONFIG-001 |
| Production readiness | Not claimed |
| Independent assurance | Pending |

## Expected behavior

- health is explicitly public;
- every other API path requires a valid signed JWT;
- method rules grant only the declared seeded roles;
- scopes never become municipal roles;
- anonymous, missing-role, wrong-role and unknown-resource requests fail safely;
- the committed dev realm cannot be silently promoted to Demo or production.

## Repeatable check

```bash
docker compose --profile identity up -d identity
mvn -f apps/api/pom.xml test
```

For each execution, record the source commit, JDK and Maven versions, Docker/Compose versions, Keycloak image digest, timestamp, command, expected/actual counts, pass/fail state, and limitations. A passing Local/CI run is implementation evidence only; it is not an external security review, production IdP approval, tenant-isolation proof, or compliance decision.
