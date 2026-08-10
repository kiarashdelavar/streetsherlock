# Local API and identity operations

**Scope:** E01-03 and E01-06, synthetic Local/CI foundation only.

## Prerequisites

Use Java 21, Maven 3.9.11, Docker 27+ and Docker Compose v2.29+. Set `APP_ENVIRONMENT=local`; the application intentionally refuses a blank environment.

## Commands

| Action | Linux/macOS/WSL2 | Windows PowerShell |
|---|---|---|
| Start dev identity | `docker compose --profile identity up -d identity` | same |
| Identity logs | `docker compose logs identity` | same |
| Test API | `make api-test` | `mvn -f apps/api/pom.xml test` |
| Run API | `APP_ENVIRONMENT=local make api-run` | `$env:APP_ENVIRONMENT="local"; mvn -f apps/api/pom.xml spring-boot:run` |
| Health | `curl http://127.0.0.1:8080/actuator/health` | `Invoke-RestMethod http://127.0.0.1:8080/actuator/health` |
| Stop identity | `docker compose --profile identity stop identity` | same |

The resource server reads keys from `OIDC_JWK_SET_URI`; its Local default is the imported realm at `http://127.0.0.1:8180/realms/streetsherlock-dev/protocol/openid-connect/certs`. Demo or later environments must explicitly supply their own authorized URI and must not copy the dev realm.

## Safe behavior

- Blank/missing `APP_ENVIRONMENT` stops startup.
- The server and Keycloak dev profile bind to loopback by default.
- Health details are hidden and health is the only anonymous API path.
- Invalid/missing JWTs receive 401; authenticated roles without permission receive 403.
- Unknown synthetic resource identifiers receive 404 without disclosing another resource.
- Scopes do not grant municipal roles.
- Logs, fixtures, and responses contain no restricted, personal, municipal, or KLIC data.
- The local realm is not a production IdP, tenant model, or custom password-auth system.

## Evidence

Run `mvn -f apps/api/pom.xml test` for `ARCH-MOD-001..004`, `API-SMOKE-001`, `AUTH-MATRIX-001`, `AUTH-IDOR-001..008`, and `SEC-CONFIG-001`. Record the commit, JDK/Maven versions, command, actual result, and limitations in [E01-06 authorization evidence](../testing/e01-06-authorization.md). No production or independent-assurance claim is created.
