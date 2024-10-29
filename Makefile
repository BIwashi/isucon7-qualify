.DEFAULT_GOAL := help

OS   := $(shell uname | awk '{print tolower($$0)}')
ARCH := $(shell case $$(uname -m) in (x86_64) echo amd64 ;; (aarch64) echo arm64 ;; (*) echo $$(uname -m) ;; esac)

.PHONY: run/bench
run/bench: ## Run bench docker compose ## make run/bench
	docker compose up bench

.PHONY: run/all
run/all: ## Run all docker compose ## make run/all
	docker compose --profile all up --attach db --attach app --attach web

.PHONY: help
help: ## Display this help screen ## make or make help
	@echo ""
	@echo "Usage: make SUB_COMMAND argument_name=argument_value"
	@echo ""
	@echo "Command list:"
	@echo ""
	@printf "\033[36m%-30s\033[0m %-50s %s\n" "[Sub command]" "[Description]" "[Example]"
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "\033[36m%-30s\033[0m %-50s %s\n", $$1, $$2, $$3}'