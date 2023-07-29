FROM ghcr.io/ddoroshev/pylerplate:base-compile-3.11.4-slim as compile

COPY poetry.lock pyproject.toml /app/

RUN poetry install --no-root --without=dev

COPY . /app/

FROM ghcr.io/ddoroshev/pylerplate:base-runtime-3.11.4-slim as runtime

COPY --from=compile /venv /venv
COPY --from=compile /app /app

CMD ["make", "run"]
