.DEFAULT_GOAL := default

# If makefile is called using sudo or as root, ensure that this user is also logged into dockerhub

IMAGE ?= nimra98/portfolio-performance
LATEST ?= false

ifndef VERSION
$(error VERSION is not set)
endif

ifndef PACKAGING
$(error PACKAGING is not set)
endif

.PHONY: build # Build the container image
build:
    @docker buildx create --use --name=crossplat --node=crossplat && \
    if [ "$(LATEST)" = "true" ]; then \
        docker buildx build \
        --build-arg VERSION=$(VERSION) \
        --build-arg PACKAGING=$(PACKAGING) \
        --output "type=docker,push=false" \
        --tag $(IMAGE):$(VERSION)-$(PACKAGING) \
        --tag $(IMAGE):latest \
        . ; \
    else \
        docker buildx build \
        --build-arg VERSION=$(VERSION) \
        --build-arg PACKAGING=$(PACKAGING) \
        --output "type=docker,push=false" \
        --tag $(IMAGE):$(VERSION)-$(PACKAGING) \
        . ; \
    fi

.PHONY: release-amd64 # Push the image to the remote registry for amd64
release-amd64:
    @docker buildx create --use --name=crossplat --node=crossplat && \
    if [ "$(LATEST)" = "true" ]; then \
        docker buildx build \
        --build-arg VERSION=$(VERSION) \
        --build-arg PACKAGING=$(PACKAGING) \
        --platform linux/amd64 \
        --push \
        --tag $(IMAGE):$(PACKAGING)-$(VERSION) \
        --tag $(IMAGE):$(PACKAGING) \
        . ; \
    else \
        docker buildx build \
        --build-arg VERSION=$(VERSION) \
        --build-arg PACKAGING=$(PACKAGING) \
        --platform linux/amd64 \
        --output "type=image,push=true" \
        --tag $(IMAGE):$(PACKAGING)-$(VERSION) \
        . ; \
    fi

.PHONY: release-arm64 # Push the image to the remote registry for arm64
release-arm64:
    @docker buildx create --use --name=crossplat --node=crossplat && \
    if [ "$(LATEST)" = "true" ]; then \
        docker buildx build \
        --build-arg VERSION=$(VERSION) \
        --build-arg PACKAGING=$(PACKAGING) \
        --platform linux/arm64 \
        --push \
        --tag $(IMAGE):$(PACKAGING)-$(VERSION) \
        --tag $(IMAGE):$(PACKAGING) \
        . ; \
    else \
        docker buildx build \
        --build-arg VERSION=$(VERSION) \
        --build-arg PACKAGING=$(PACKAGING) \
        --platform linux/arm64 \
        --output "type=image,push=true" \
        --tag $(IMAGE):$(PACKAGING)-$(VERSION) \
        . ; \
    fi