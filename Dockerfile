FROM ghcr.io/ddoroshev/pylerplate:base-compile-3.10.7-alpine as compile

COPY poetry.lock pyproject.toml /app/

RUN poetry install --no-root --no-dev

COPY . /app/

FROM ghcr.io/ddoroshev/pylerplate:base-runtime-3.10.7-alpine as runtime

COPY --from=compile /venv /venv
COPY --from=compile /app /app

CMD ["make", "run"]
