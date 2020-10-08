FROM ghcr.io/pomidoroshev/pylerplate:base-compile-3.9 as compile

COPY poetry.lock pyproject.toml /app/

RUN poetry install --no-root --no-dev

COPY . /app/

FROM ghcr.io/pomidoroshev/pylerplate:base-runtime-3.9 as runtime

COPY --from=compile /venv /venv
COPY --from=compile /app /app

CMD ["make", "run"]
