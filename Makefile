.PHONY: help
SHELL := /bin/bash

TF_PWD_DIR := $(shell pwd)
TF_VER := 0.11.14
TF_PWD_CONT_DIR := "/go/src/project/"
TF_DOCKER_ENTRYPOINT := /usr/local/go/bin/terraform
TF_DOCKER_IMAGE := binbash/terraform-resources

define TF_CMD_PREFIX
docker run --rm \
-v ${TF_PWD_DIR}:${TF_PWD_CONT_DIR}:rw \
--entrypoint=${TF_DOCKER_ENTRYPOINT} \
-it ${TF_DOCKER_IMAGE}:${TF_VER}
endef

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

version: ## version: show terraform versio
	docker run --rm \
	--entrypoint=${TF_DOCKER_ENTRYPOINT} \
	-t ${TF_DOCKER_IMAGE}:${TF_VER} version

format: ## format: The terraform fmt is used to rewrite tf conf files to a canonical format and style.
	${TF_CMD_PREFIX} fmt ${TF_PWD_CONT_DIR}

doc: ## doc: A utility to generate documentation from Terraform modules in various output formats.
	docker run --rm -v ${TF_PWD_DIR}:/data -t binbash/terraform-docs markdown table /data

lint: ## lint: TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan.
	docker run --rm -v ${TF_PWD_DIR}:/data -t wata727/tflint --deep