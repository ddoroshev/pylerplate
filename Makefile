BINDIR=$(VIRTUAL_ENV)/bin

default: run

.PHONY: init
init:
	poetry install --no-root
	$(BINDIR)/pre-commit install
	$(BINDIR)/pre-commit install-hooks
	pre-commit run -a
	make test

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

.PHONY: pyrightconfig
pyrightconfig:
	@envsubst < pyrightconfig.tpl.json > pyrightconfig.json
