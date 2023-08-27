FROM ghcr.io/ddoroshev/pybase:compile-3.11.5 as compile

COPY poetry.lock pyproject.toml /app/

RUN poetry install --no-root --only main && poetry run pip install setuptools

COPY . /app/

FROM ghcr.io/ddoroshev/pybase:runtime-3.11.5 as runtime

COPY --from=compile /venv /venv
COPY --from=compile /app /app

CMD ["make", "run"]
