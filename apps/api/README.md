# StreetSherlock API

Spring Boot 3.5.4 modular-monolith shell for E01-03. It contains no business endpoints, workflow, real data, or municipal decision logic.

## Run

From the repository root:

```bash
export APP_ENVIRONMENT=local
make api-test
make api-run
```

On Windows PowerShell:

```powershell
$env:APP_ENVIRONMENT = "local"
mvn -f apps/api/pom.xml test
mvn -f apps/api/pom.xml spring-boot:run
```

The API binds to `127.0.0.1:8080`. Check `http://127.0.0.1:8080/actuator/health`. Only health is public; every other route is denied until later authorization work.

Starting without `APP_ENVIRONMENT` fails closed with a validation error. Maven 3.9.11 and Java 21 are required.

## Boundaries and evidence

- `intake`, `incidents`, and `shared` are explicit package boundaries.
- `ARCH-MOD-001..004` reject forbidden dependencies.
- `API-SMOKE-001` checks minimal health output and deny-by-default routing.
- Tests use no database or fixtures. Docker database integration remains a later backend story.
- Passing Local/CI tests is not production, security, privacy, accessibility, or compliance approval.
