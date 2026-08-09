# Local vision service operations

**Scope:** E01-05 synthetic Local/CI contract stub only. No model, image processing, queue, persistence, or municipal decision is implemented.

## Install and test

Use Python 3.12.11.

### Linux, macOS, or WSL2

```bash
python -m venv apps/vision/.venv
source apps/vision/.venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e "apps/vision[dev]"
make vision-lint
make vision-test
```

### Windows PowerShell

```powershell
py -3.12 -m venv apps/vision/.venv
apps/vision/.venv/Scripts/Activate.ps1
python -m pip install --upgrade pip
python -m pip install -e "apps/vision[dev]"
python -m ruff check apps/vision
python -m pytest apps/vision
```

## Run safely

Set Local/CI-only configuration. Use a non-production token and never commit it.

```powershell
$env:VISION_ENVIRONMENT = "local"
$env:VISION_INTERNAL_TOKEN = "replace-with-a-local-only-token"
python -m uvicorn streetsherlock_vision.main:app --app-dir apps/vision/src --host 127.0.0.1 --port 8001
```

Liveness: `http://127.0.0.1:8001/v1/health/live`

Readiness: `http://127.0.0.1:8001/v1/health/ready`

The analysis contract is intentionally disabled. Missing configuration returns `503`, missing or invalid authorization returns `401`, invalid contracts return `422`, and a valid authorized synthetic request returns `501`. No request is stored or processed.

## Evidence and limitations

`API-VISION-001..004` and `ARCH-AUTH-002` cover versioned health, fail-closed readiness, strict refusal, and authorization denial. Record the commit, Python version, command, expected/actual result, and limitations. These checks do not establish production, AI, security, privacy, or municipal readiness.
