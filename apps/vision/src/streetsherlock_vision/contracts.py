from typing import Literal

from pydantic import BaseModel, ConfigDict, Field


class StrictContract(BaseModel):
    model_config = ConfigDict(extra="forbid")


class HealthResponse(StrictContract):
    status: Literal["up"] = "up"
    service: Literal["vision"] = "vision"
    api_version: Literal["v1"] = "v1"


class ReadinessResponse(StrictContract):
    status: Literal["ready"] = "ready"
    service: Literal["vision"] = "vision"


class AnalyzeRequest(StrictContract):
    fixture_id: str = Field(pattern=r"^SYN-[A-Z0-9-]{1,32}$")
    contract_version: Literal["v1"]


class ErrorResponse(StrictContract):
    code: str
    message: str
