#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1091
source "$ROOT_DIR/scripts/versions.env"

failures=0

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  failures=$((failures + 1))
}

need() {
  local command_name="$1"
  local help_text="$2"
  if ! command -v "$command_name" >/dev/null 2>&1; then
    fail "Missing $command_name. $help_text"
    return 1
  fi
}

exact() {
  local label="$1" actual="$2" expected="$3"
  if [[ "$actual" != "$expected" ]]; then
    fail "$label $actual is unsupported; expected $expected."
  else
    printf 'OK: %s %s\n' "$label" "$actual"
  fi
}

at_least() {
  local label="$1" actual="$2" minimum="$3"
  if [[ "$(printf '%s\n%s\n' "$minimum" "$actual" | sort -V | head -n1)" != "$minimum" ]]; then
    fail "$label $actual is unsupported; expected >= $minimum."
  else
    printf 'OK: %s %s\n' "$label" "$actual"
  fi
}

if need node 'Install the version in .nvmrc or .tool-versions.'; then
  exact Node "$(node --version | sed 's/^v//')" "$NODE_VERSION"
fi

if need pnpm 'Run corepack enable, then corepack prepare pnpm@10.13.1 --activate.'; then
  exact pnpm "$(pnpm --version)" "$PNPM_VERSION"
fi

if need java 'Install a Java 21 JDK; .sdkmanrc provides a Temurin candidate.'; then
  java_version="$(java -version 2>&1 | awk -F\" '/version/ {print $2; exit}')"
  java_major="${java_version%%.*}"
  exact Java-major "$java_major" "$JAVA_MAJOR"
fi

if need python3 'Install the version in .python-version or .tool-versions.'; then
  exact Python "$(python3 --version | awk '{print $2}')" "$PYTHON_VERSION"
fi

if need docker 'Install Docker Engine or Docker Desktop before service work.'; then
  docker_version="$(docker version --format '{{.Client.Version}}' 2>/dev/null || true)"
  if [[ -z "$docker_version" ]]; then
    fail 'Docker CLI exists but the client version could not be read.'
  else
    at_least Docker-client "$docker_version" "$DOCKER_MIN_VERSION"
  fi

  compose_version="$(docker compose version --short 2>/dev/null || true)"
  compose_version="${compose_version#v}"
  if [[ -z "$compose_version" ]]; then
    fail 'Docker Compose v2 is missing. Install the docker compose plugin.'
  else
    at_least Docker-Compose "$compose_version" "$COMPOSE_MIN_VERSION"
  fi
fi

if (( failures > 0 )); then
  printf '\nTool verification failed with %d actionable error(s).\n' "$failures" >&2
  exit 1
fi

printf '\nTool verification passed for the StreetSherlock Local/CI workspace.\n'

