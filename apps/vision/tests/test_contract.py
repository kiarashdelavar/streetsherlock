from fastapi.testclient import TestClient

from streetsherlock_vision.config import get_settings
from streetsherlock_vision.main import app

client = TestClient(app)


def configure(monkeypatch) -> None:
    monkeypatch.setenv("VISION_ENVIRONMENT", "ci")
    monkeypatch.setenv("VISION_INTERNAL_TOKEN", "synthetic-ci-token")
    get_settings.cache_clear()


def teardown_function() -> None:
    get_settings.cache_clear()


def test_api_vision_001_liveness_is_versioned_and_minimal() -> None:
    response = client.get("/v1/health/live")

    assert response.status_code == 200
    assert response.json() == {"status": "up", "service": "vision", "api_version": "v1"}


def test_api_vision_002_readiness_fails_closed_without_configuration(monkeypatch) -> None:
    monkeypatch.delenv("VISION_ENVIRONMENT", raising=False)
    monkeypatch.delenv("VISION_INTERNAL_TOKEN", raising=False)
    get_settings.cache_clear()

    response = client.get("/v1/health/ready")

    assert response.status_code == 503
    assert response.json()["detail"]["code"] == "not_ready"


def test_api_vision_003_readiness_reports_configured_state(monkeypatch) -> None:
    configure(monkeypatch)

    response = client.get("/v1/health/ready")

    assert response.status_code == 200
    assert response.json() == {"status": "ready", "service": "vision"}


def test_api_vision_004_authorized_contract_refuses_processing(monkeypatch) -> None:
    configure(monkeypatch)

    response = client.post(
        "/v1/vision/analyze",
        headers={"Authorization": "Bearer synthetic-ci-token"},
        json={"fixture_id": "SYN-VISION-001", "contract_version": "v1"},
    )

    assert response.status_code == 501
    assert response.json()["code"] == "vision_not_implemented"


def test_arch_auth_002_denies_missing_and_invalid_authorization(monkeypatch) -> None:
    configure(monkeypatch)
    payload = {"fixture_id": "SYN-VISION-001", "contract_version": "v1"}

    missing = client.post("/v1/vision/analyze", json=payload)
    invalid = client.post(
        "/v1/vision/analyze",
        headers={"Authorization": "Bearer wrong"},
        json=payload,
    )

    assert missing.status_code == 401
    assert invalid.status_code == 401
    assert "synthetic-ci-token" not in missing.text + invalid.text


def test_contract_rejects_extra_or_non_synthetic_fields(monkeypatch) -> None:
    configure(monkeypatch)

    response = client.post(
        "/v1/vision/analyze",
        headers={"Authorization": "Bearer synthetic-ci-token"},
        json={
            "fixture_id": "real-person-1",
            "contract_version": "v1",
            "image": "not-accepted",
        },
    )

    assert response.status_code == 422
