
SHELL = /bin/bash
TAG ?= test

all: build

# Test build current architecture
build:
	docker build --tag seasketch/geoprocessing-workspace:$(TAG) --file Dockerfile .

# Test build multi-architecture
buildmulti:
	docker buildx build --platform linux/amd64,linux/arm64 -t seasketch/geoprocessing-workspace:$(TAG) -f Dockerfile .

shell: build
	docker run --rm -it \
		seasketch/geoprocessing-workspace:$(TAG) \
		/bin/bash

test:
	docker run --rm \
		--volume $(shell pwd)/:/app \
		seasketch/geoprocessing-workspace:$(TAG) \
		bash /app/tests/run_tests.sh


