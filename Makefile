
PROJECT_NAME := java-hello-world-api
ORGANIZATION := skeleton

# Docker configuration
ifdef GITHUB_REF
  ifeq ($(findstring refs/tags/,$(GITHUB_REF)),refs/tags/)
    RELEASE_TAG := $(subst refs/tags/,,$(GITHUB_REF))
  endif
endif

FROM_COMMIT := $(shell git rev-parse HEAD 2>/dev/null | cut -c1-8)
PROJECT_VERSION := $(if ${RELEASE_TAG},${RELEASE_TAG},$(FROM_COMMIT))
DOCKER_NAME := $(ORGANIZATION)/$(PROJECT_NAME)
DOCKER_IMAGE := $(DOCKER_NAME):$(PROJECT_VERSION)


.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Java

.PHONY: fmt
fmt: ## Format the code
	./gradlew spotlessApply

.PHONY: check
check: ## Run checkstyle
	./gradlew check --stacktrace

.PHONY: test
test: ## Run tests
	./gradlew test

.PHONY: build
build: ## Build the project
	./gradlew clean build


##@ Docker

.PHONY: docker-build
docker-build: build
	docker build --rm \
		-t "$(DOCKER_IMAGE)" \
		-f "Dockerfile" . \
		--platform linux/amd64

.PHONY: docker-run
docker-run: docker-build
	docker run -p 8080:8080 $(DOCKER_IMAGE)


##@ Run
.PHONY: run
run: build ## Run the project
	./gradlew bootRun --args='--spring.profiles.active=dev'

##@ Environment

set-java-21: ## Set Java 21
	asdf install java openjdk-21
	asdf global java openjdk-21