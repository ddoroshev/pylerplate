FROM ghcr.io/ddoroshev/pybase:3.13.1-compile-v1 as compile

COPY poetry.lock pyproject.toml /app/

RUN poetry install --no-root --only main && poetry run pip install setuptools

COPY . /app/

FROM ghcr.io/ddoroshev/pybase:3.13.1-runtime-v1 as runtime

COPY --from=compile /venv /venv
COPY --from=compile /app /app

CMD ["make", "run"]
