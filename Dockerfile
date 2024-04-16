FROM ghcr.io/ddoroshev/pybase:3.11.5-compile as compile

COPY poetry.lock pyproject.toml /app/

RUN poetry install --no-root --only main && poetry run pip install setuptools

COPY . /app/

FROM ghcr.io/ddoroshev/pybase:3.11.5-runtime as runtime

COPY --from=compile /venv /venv
COPY --from=compile /app /app

CMD ["make", "run"]
