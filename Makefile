SHELL := /bin/bash

COMPOSE := docker compose
APP := $(COMPOSE) run --rm web

.PHONY: setup install-hooks up down logs shell bash bundle lint rubocop rubocop-autocorrect test security verify ci

setup:
	$(COMPOSE) up --build -d

install-hooks:
	git config core.hooksPath .githooks

up:
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f web

shell:
	$(APP) bin/rails console

bash:
	$(APP) bash

bundle:
	$(APP) bundle install

lint:
	$(APP) bin/rubocop

rubocop:
	$(APP) bin/rubocop

rubocop-autocorrect:
	$(APP) bin/rubocop -A

test:
	$(APP) bin/rails test

security:
	$(APP) bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error

verify:
	$(APP) bash -lc "bin/rubocop && bin/rails test"

ci:
	$(APP) bin/ci
