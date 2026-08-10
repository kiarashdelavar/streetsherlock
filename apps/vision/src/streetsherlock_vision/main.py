from hmac import compare_digest
from typing import Annotated

from fastapi import Depends, FastAPI, Header, HTTPException, status
from fastapi.responses import JSONResponse

from .config import Settings, get_settings
from .contracts import AnalyzeRequest, ErrorResponse, HealthResponse, ReadinessResponse

app = FastAPI(
    title="StreetSherlock Vision Contract",
    version="0.1.0",
    docs_url=None,
    redoc_url=None,
    openapi_url="/v1/openapi.json",
)


@app.get("/v1/health/live", response_model=HealthResponse, tags=["health"])
def liveness() -> HealthResponse:
    return HealthResponse()


@app.get(
    "/v1/health/ready",
    response_model=ReadinessResponse,
    responses={503: {"model": ErrorResponse}},
    tags=["health"],
)
def readiness(settings: Annotated[Settings, Depends(get_settings)]) -> ReadinessResponse:
    if not settings.ready:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail={
    "code": "not_ready",
    "message": "Required vision configuration is unavailable.",
},
        )
    return ReadinessResponse()


def require_internal_authorization(
    settings: Annotated[Settings, Depends(get_settings)],
    authorization: Annotated[str | None, Header()] = None,
) -> None:
    if not settings.ready:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail={
    "code": "not_ready",
    "message": "Required vision configuration is unavailable.",
},
        )

    token = settings.internal_token
    if token is None:
        raise HTTPException(status_code=status.HTTP_503_SERVICE_UNAVAILABLE)

    expected = f"Bearer {token.get_secret_value()}"
    if authorization is None or not compare_digest(authorization, expected):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail={"code": "unauthorized", "message": "Valid internal authorization is required."},
            headers={"WWW-Authenticate": "Bearer"},
        )


@app.post(
    "/v1/vision/analyze",
    dependencies=[Depends(require_internal_authorization)],
    responses={501: {"model": ErrorResponse}, 503: {"model": ErrorResponse}},
    tags=["vision"],
)
def analyze_stub(_: AnalyzeRequest) -> JSONResponse:
    return JSONResponse(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        content={
            "code": "vision_not_implemented",
            "message": "Vision processing is unavailable in this foundation slice.",
        },
    )
