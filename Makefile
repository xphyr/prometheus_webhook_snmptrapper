APP_NAME  := snmp-trapper
DEBUG_POSTFIX := -debugger
#VERSION := $(shell date +%Y%m%d%H%M)
VERSION := latest
NAMESPACE := mangirdas
IMAGE := $(NAMESPACE)/$(APP_NAME)
DEBUG_IMAGE :=  $(NAMESPACE)/$(APP_NAME)$(DEBUG_POSTFIX)
REGISTRY := docker.io
ARCH := linux 

.PHONY: clean

clean:
	rm -rf bin/%/$(APP_NAME)

build:
	GOOS=$(ARCH) GOARCH=amd64 go build -v -i -o bin/$(APP_NAME) ./
	GOOS=$(ARCH) GOARCH=amd64 go build -v -i -o bin/$(APP_NAME)$(DEBUG_POSTFIX) ./trapdebug

build-release:
	GOOS=linux GOARCH=amd64 go build -v -i -o bin/linux/$(APP_NAME) ./
	GOOS=linux GOARCH=amd64 go build -v -i -o bin/linux/$(APP_NAME)$(DEBUG_POSTFIX) ./trapdebug

build-image: build-release build-trapper-image build-debug-image

build-trapper-image:
	docker build . -t $(REGISTRY)/$(IMAGE):$(VERSION)

publish-image:
	docker push $(REGISTRY)/$(IMAGE):$(VERSION)
	docker push $(REGISTRY)/$(DEBUG_IMAGE):$(VERSION)

build-debug-image:
	docker build -f Dockerfile.debugger . -t $(REGISTRY)/$(DEBUG_IMAGE):$(VERSION)