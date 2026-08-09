from functools import lru_cache
from typing import Literal

from pydantic import SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_prefix="VISION_",
        extra="ignore",
        case_sensitive=False,
    )

    environment: Literal["local", "ci"] | None = None
    internal_token: SecretStr | None = None

    @property
    def ready(self) -> bool:
        return self.environment is not None and self.internal_token is not None


@lru_cache
def get_settings() -> Settings:
    return Settings()
