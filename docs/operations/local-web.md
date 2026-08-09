# Local web operations

**Scope:** E01-04 synthetic Local/CI shell only. This is not a public reporting service or accessibility-conformance claim.

## Prerequisites and commands

Use Node.js 22.18.0 and pnpm 10.13.1 via Corepack.

| Action | Linux/macOS/WSL2 | Windows PowerShell |
|---|---|---|
| Install | `corepack enable && pnpm install --frozen-lockfile` | `corepack enable; pnpm install --frozen-lockfile` |
| Test | `pnpm --filter @streetsherlock/web test` | same |
| Build | `pnpm --filter @streetsherlock/web build` | same |
| Run | `pnpm --filter @streetsherlock/web dev` | same |

Open `http://127.0.0.1:3000`. Database and backend are independent in this foundation slice; the page contains deterministic synthetic fixtures only.

## Evidence and limitations

`A11Y-SHELL-001..006` verify landmarks, navigation, alternatives, and recovery states at component level. `WEB-SMOKE-001` verifies the shell renders. Record commit, runtime, command, actual result, and limitations. Keyboard behavior still requires manual browser verification. These checks do not establish WCAG, legal, security, privacy, or production compliance.
