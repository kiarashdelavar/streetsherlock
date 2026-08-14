# Changelog

All notable implementation changes are recorded here. Passing Local/CI checks does
not imply production, security, privacy, accessibility or compliance approval.

## Unreleased
- E01-09 pinned, least-privilege CI jobs for backend, web, Vision, contract
  drift, clean-database migration, dependency review and blocking security scans.
### Added

- E01-08 versioned OpenAPI contract, generated TypeScript API types, backend contract
  tests and a deterministic stale-artifact drift check.
- E01-07 API problem details, correlation IDs, allowlisted privacy-safe request logs,
  and separate minimal liveness/readiness probes.
- Automated evidence for API error, telemetry privacy and health behavior.
