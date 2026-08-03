#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

make_fake() {
  local name="$1" body="$2"
  printf '#!/usr/bin/env bash\n%s\n' "$body" > "$TMP_DIR/$name"
  chmod +x "$TMP_DIR/$name"
}

make_fake node "printf 'v22.18.0\\n'"
make_fake pnpm "printf '10.13.1\\n'"
make_fake java 'printf "openjdk version \"21.0.7\"\n" >&2'
make_fake python3 "printf 'Python 3.12.11\\n'"
make_fake docker 'if [[ "$1" == version ]]; then printf "27.5.1\\n"; else printf "2.33.1\\n"; fi'

PATH="$TMP_DIR:/usr/bin:/bin" bash "$ROOT_DIR/scripts/verify-tools.sh" >/dev/null

make_fake node "printf 'v20.0.0\\n'"
if PATH="$TMP_DIR:/usr/bin:/bin" bash "$ROOT_DIR/scripts/verify-tools.sh" >/dev/null 2>&1; then
  printf 'Expected unsupported Node version to fail.\n' >&2
  exit 1
fi

printf 'CLONE-001: prerequisite success and safe-failure paths passed.\n'
