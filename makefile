.DEFAULT_GOAL := default

# If makefile is called using sudo or as root, ensure that this user is also logged into dockerhub

IMAGE ?= nimra98/portfolio-performance
LATEST ?= false

ifndef VERSION
$(error VERSION is not set)
endif

ifndef TARGETARCH
$(error TARGETARCH is not set)
endif

ifndef ARCHITECTURE
$(error ARCHITECTURE is not set)
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
		--build-arg TARGETARCH=$(TARGETARCH) \
		--build-arg ARCHITECTURE=$(ARCHITECTURE) \
		--build-arg PACKAGING=$(PACKAGING) \
		--output "type=docker,push=false" \
		--tag $(IMAGE):$(VERSION)-$(PACKAGING) \
		--tag $(IMAGE):latest \
		. ; \
	else \
		docker buildx build \
		--build-arg VERSION=$(VERSION) \
		--build-arg TARGETARCH=$(TARGETARCH) \
		--build-arg ARCHITECTURE=$(ARCHITECTURE) \
		--build-arg PACKAGING=$(PACKAGING) \
		--output "type=docker,push=false" \
		--tag $(IMAGE):$(VERSION)-$(PACKAGING) \
		. ; \
	fi
	

.PHONY: release # Push the image to the remote registry #linux/386,linux/amd64,linux/arm/v7,linux/arm64 
release:
	@docker buildx create --use --name=crossplat --node=crossplat && \
	if [ "$(LATEST)" = "true" ]; then \
		docker buildx build \
		--build-arg VERSION=$(VERSION) \
		--build-arg TARGETARCH=$(TARGETARCH) \
		--build-arg ARCHITECTURE=$(ARCHITECTURE) \
		--build-arg PACKAGING=$(PACKAGING) \
		--platform linux/amd64 \
		--push \
		--tag $(IMAGE):$(PACKAGING)-$(VERSION) \
		--tag $(IMAGE):$(PACKAGING) \
		. ; \
	else \
		docker buildx build \
		--build-arg VERSION=$(VERSION) \
		--build-arg TARGETARCH=$(TARGETARCH) \
		--build-arg ARCHITECTURE=$(ARCHITECTURE) \
		--build-arg PACKAGING=$(PACKAGING) \
		--platform linux/amd64 \
		--output "type=image,push=true" \
		--tag $(IMAGE):$(PACKAGING)-$(VERSION) \
		. ; \
	fi
