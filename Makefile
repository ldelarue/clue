SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: front
front: ## Install the front end libraries.
	npm --prefix ./front install

.PHONY: image
image: ## Build the docker image locally.
	docker build -t 'clue:local' .

.ONESHELL:
.PHONY: openapi-schema
openapi-schema: ## Generate the openapi schema from API.
	uv sync
	PYTHONPATH=$(shell pwd) bash -c "uv run python scripts/extract-openapi.py api_runner_printer:app"

.PHONY: openapi-client-go
openapi-client-go: openapi-schema ## Generate the go client from the openapi spec.
	docker run --rm \
		-v $(shell pwd):/local openapitools/openapi-generator-cli generate \
		-i /local/openapi.yaml \
		-g go \
		-o /local/openapi/go

.PHONY: openapi-client-ts
openapi-client-ts: openapi-schema ## Generate the typescript client from the openapi spec.
	npx @hey-api/openapi-ts \
		-c @hey-api/client-fetch \
		-i openapi.yaml \
		-o ts \

.PHONY: openapi-client-python
openapi-client-python: openapi-schema ## Generate the python client from the openapi spec.
	docker run --rm \
		-v $(shell pwd):/local openapitools/openapi-generator-cli generate \
		-i /local/openapi.yaml \
		-g python \
		-o /local/openapi/python

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Print all available make commands.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
