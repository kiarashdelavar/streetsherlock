# StreetSherlock API

Spring Boot 3.5.4 modular-monolith shell with a deny-by-default OIDC resource-server boundary. It contains no production identity provider, workflow, real data, or municipal decision logic.

## Run

From the repository root:

```bash
docker compose --profile identity up -d identity
export APP_ENVIRONMENT=local
make api-test
make api-run
```

On Windows PowerShell:

```powershell
docker compose --profile identity up -d identity
$env:APP_ENVIRONMENT = "local"
mvn -f apps/api/pom.xml test
mvn -f apps/api/pom.xml spring-boot:run
```

The API binds to `127.0.0.1:8080`. Check `http://127.0.0.1:8080/actuator/health`. Only health is public; all other paths require a valid JWT and protected demo routes additionally require a seeded role.

The `identity` Compose profile imports a deterministic, synthetic Keycloak realm on `127.0.0.1:8180`. Its users, passwords, roles and admin credential are local-only fixtures committed for repeatability. Never deploy or reuse them outside Local/CI. Production IdP and tenant-claim selection remain out of scope.

Starting without `APP_ENVIRONMENT` fails closed with a validation error. Maven 3.9.11 and Java 21 are required.

## Boundaries and evidence

- `intake`, `incidents`, `identity`, and `shared` are explicit package boundaries.
- JWT realm roles are normalized to `ROLE_*`; scopes are not treated as municipal roles.
- `ARCH-MOD-001..004` reject existing forbidden dependencies.
- `API-SMOKE-001` checks minimal health output and deny-by-default routing.
- `AUTH-MATRIX-001`, `AUTH-IDOR-001..008`, and `SEC-CONFIG-001` test anonymous, role-negative, unknown-resource, and authorized behavior.
- Tests and fixtures use no real user, municipal, restricted, or personal data.
- Passing Local/CI tests is not production, security, privacy, identity-provider, accessibility, or compliance approval.
