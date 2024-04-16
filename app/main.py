from typing import cast

import sentry_sdk
from fastapi import FastAPI
from sentry_sdk.integrations.asgi import SentryAsgiMiddleware

from .config import Config
from .routes import add_routes


def create_app() -> FastAPI:
    config = Config()
    app = FastAPI()
    add_routes(app)

    if config.SENTRY_DSN:
        sentry_sdk.init(dsn=config.SENTRY_DSN)
        app = cast(FastAPI, SentryAsgiMiddleware(app))
    return app


app = create_app()
