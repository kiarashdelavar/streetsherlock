.PHONY: bootstrap doctor lint test build check db-up db-verify db-down db-reset api-test api-run web-test web-build web-run vision-lint vision-test vision-run

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
api-test:
	@mvn -f apps/api/pom.xml test
api-run:
	@mvn -f apps/api/pom.xml spring-boot:run
web-test:
	@pnpm --filter @streetsherlock/web test
web-build:
	@pnpm --filter @streetsherlock/web build
web-run:
	@pnpm --filter @streetsherlock/web dev
vision-lint:
	@python -m ruff check apps/vision
vision-test:
	@python -m pytest apps/vision
vision-run:
	@python -m uvicorn streetsherlock_vision.main:app --app-dir apps/vision/src --host 127.0.0.1 --port 8001
