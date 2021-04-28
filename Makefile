RUN=poetry run

default: run

.PHONY: init
init:
	poetry install -E devtools --no-root
	$(RUN) pre-commit install
	$(RUN) pre-commit install-hooks
	make format check test

.PHONY: clean
clean:
	find . | grep -E "(__pycache__|\.pyc|\.pyo$$)" | xargs rm -rf

.PHONY: run
run:
	$(RUN) uvicorn app:app

.PHONY: dev
dev:
	$(RUN) uvicorn app:app --reload

.PHONY: test
test:
	$(RUN) pytest

.PHONY: cov
cov:
	$(RUN) pytest --cov

.PHONY: cov-html
cov-html:
	$(RUN) pytest --cov --cov-report=html

.PHONY: flake8
flake8:
	$(RUN) flake8

.PHONY: mypy
mypy:
	$(RUN) mypy app

.PHONY: check
check: flake8 mypy

.PHONY: format
format:
	$(RUN) pre-commit run -a
