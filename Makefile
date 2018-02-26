APP_NAME  := snmp-trapper
#VERSION := $(shell date +%Y%m%d%H%M)
VERSION := latest
NAMESPACE := mangirdas
IMAGE := $(NAMESPACE)/$(APP_NAME)
REGISTRY := docker.io
ARCH := linux 

.PHONY: clean

clean:
	rm -rf bin/%/$(APP_NAME)

build:
	GOOS=$(ARCH) GOARCH=amd64 go build -v -i -o bin/$(APP_NAME) ./

bin/%/$(APP_NAME):
	GOOS=linux GOARCH=amd64 go build -v -i -o bin/$*/$(APP_NAME) ./

build-image: bin/linux/$(APP_NAME)
	docker build . -t $(REGISTRY)/$(IMAGE):$(VERSION)

publish-image: build-image
	docker push $(REGISTRY)/$(IMAGE):$(VERSION)
