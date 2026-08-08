.PHONY: bootstrap doctor lint test build check db-up db-verify db-down db-reset

bootstrap:
	@bash scripts/bootstrap.sh

doctor:
	@bash scripts/verify-tools.sh

lint:
	@bash scripts/workspace.sh lint

test:
	@bash scripts/workspace.sh test

build:
	@bash scripts/workspace.sh build

check:
	@bash scripts/workspace.sh check

db-up:
	@bash scripts/database.sh up

db-verify:
	@bash scripts/database.sh verify

db-down:
	@bash scripts/database.sh down

db-reset:
	@bash scripts/database.sh reset
