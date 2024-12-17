SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: image
image: ## Build the docker image locally.
	docker build -t 'clue:local' .

.ONESHELL:
.PHONY: openapi-schema
openapi-schema: ## Generate the openapi schema from API.
	uv sync
	PYTHONPATH=$(shell pwd) bash -c "uv run python scripts/extract-openapi.py api_runner_printer:app"

.PHONY: openapi-go-client
.ONESHELL:
openapi-go-client: openapi-schema ## Generate the go client from the openapi spec.
	docker run --rm \
		-v $(shell pwd):/local openapitools/openapi-generator-cli generate \
		-i /local/openapi.yaml \
		-g go \
		-o /local/openapi

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Print all available make commands.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
