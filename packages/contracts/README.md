# Contracts workspace

The Spring Boot API is the source of truth for the versioned API surface. The
committed OpenAPI document is checked against Springdoc in
`OpenApiContractTest`, and the TypeScript client types are generated from that
document with pinned `openapi-typescript@7.9.1`.

Generate after an intentional API contract change:

```bash
pnpm contracts:generate
```

Detect stale generated output without modifying the worktree:

```bash
pnpm contracts:check
```

Commit `openapi.json` and `src/generated/api-types.ts` together. Do not
hand-edit the generated TypeScript file. The document contains synthetic
Local/CI examples only and makes no production or compliance claim.
