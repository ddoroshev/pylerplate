BINDIR=$(VIRTUAL_ENV)/bin

default: run

.PHONY: init
init:
	poetry install -E devtools --no-root
	$(BINDIR)/pre-commit install
	$(BINDIR)/pre-commit install-hooks
	make format check test

.PHONY: clean
clean:
	find . | grep -E "(__pycache__|\.pyc|\.pyo$$)" | xargs rm -rf

.PHONY: run
run:
	$(BINDIR)/uvicorn app:app

.PHONY: dev
dev:
	$(BINDIR)/uvicorn app:app --reload

.PHONY: test
test:
	$(BINDIR)/pytest

.PHONY: cov
cov:
	$(BINDIR)/pytest --cov

.PHONY: cov-html
cov-html:
	$(BINDIR)/pytest --cov --cov-report=html

.PHONY: flake8
flake8:
	$(BINDIR)/flake8

.PHONY: mypy
mypy:
	$(BINDIR)/mypy app

.PHONY: check
check: flake8 mypy

.PHONY: format
format:
	$(BINDIR)/pre-commit run -a
