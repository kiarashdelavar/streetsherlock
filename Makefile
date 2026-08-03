.PHONY: bootstrap doctor lint test build check

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

