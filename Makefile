cnf ?= .env.aws
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# Get the latest tag
TAG=$(shell git describe --tags --abbrev=0)
GIT_COMMIT=$(shell git log -1 --format=%h)
TERRAFORM_VERSION=latest

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

WORKDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /bin/bash -euo pipefail

.PHONY: clean all build run devel-and-die devel-and-live

#help: 							## Show help.
#	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

clean:							## Clear terraform
	find . -type d -name ".terraform" -prune -exec rm -rf {} \; && \
	find . -type f -name ".terraform.lock.hcl" -prune -exec rm -rf {} \; && \
	find . -type f -name "*.tfstate*" -prune -exec rm -rf {} \;

docker-sh: ## terraform console
	  docker run -it --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$$AWS_DEFAULT_REGION -e TF_VAR_APP_VERSION=$(GIT_COMMIT) --entrypoint "" hashicorp/terraform:$(TERRAFORM_VERSION) sh 

podman-sh: ## terraform console
	  podman run -it --privileged --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$$AWS_DEFAULT_REGION -e TF_VAR_APP_VERSION=$(GIT_COMMIT) --entrypoint "" hashicorp/terraform:$(TERRAFORM_VERSION) sh