# Local API operations

**Scope:** E01-03, synthetic Local/CI shell only.

## Prerequisites

Use Java 21 and Maven 3.9.11. Set `APP_ENVIRONMENT=local`; the application intentionally refuses a blank environment.

## Commands

| Action | Linux/macOS/WSL2 | Windows PowerShell |
|---|---|---|
| Test | `make api-test` | `mvn -f apps/api/pom.xml test` |
| Run | `APP_ENVIRONMENT=local make api-run` | `$env:APP_ENVIRONMENT="local"; mvn -f apps/api/pom.xml spring-boot:run` |
| Health | `curl http://127.0.0.1:8080/actuator/health` | `Invoke-RestMethod http://127.0.0.1:8080/actuator/health` |

The API currently does not require Docker because E01-03 intentionally has no persistence or business workflow. Run the spatial database separately with `make db-up` when validating E01-02. Database-to-backend connectivity will be introduced in its own versioned task.

## Safe behavior

- Blank/missing `APP_ENVIRONMENT` stops startup.
- The server binds to loopback by default.
- Health details are hidden.
- Every non-health HTTP route is denied.
- Logs, fixtures, and responses contain no restricted, personal, municipal, or KLIC data.

## Evidence

`ARCH-MOD-001..004` and `API-SMOKE-001` run through Maven tests. Record the commit, JDK/Maven versions, command, actual result, and limitations. No production or independent assurance claim is created.
