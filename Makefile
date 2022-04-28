ROOT_BUILD_DIR   ?= ${PWD}
BINARY           ?= jsonnetdoc
GO               ?= go
GOCI             ?= golangci-lint
GOFMT            ?= $(GO)fmt
GOARCH           ?= amd64
pkgs              = $$($(GO) list $(MODOPT) ./...)
IMAGE             = AntoineThebaud/jsonnetdoc
TAG               = $$(git rev-parse --short HEAD)
COMMIT           := $(shell git status >/dev/null && git rev-parse HEAD)
BRANCH           := $(shell git status >/dev/null && git rev-parse --abbrev-ref HEAD)
DATE             := $(shell date +%Y-%m-%d)
COVERAGE_PROFILE := test-coverage-profile.out
PKG_LDFLAGS := github.com/prometheus/common/version
# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS := -ldflags "-X ${PKG_LDFLAGS}.Version=${VERSION} -X ${PKG_LDFLAGS}.Revision=${COMMIT} -X ${PKG_LDFLAGS}.BuildDate=${DATE} -X ${PKG_LDFLAGS}.Branch=${BRANCH}"

all: build test

build:
	CGO_ENABLED=0 GOARCH=${GOARCH} $(GO) build -a -installsuffix  cgo ${LDFLAGS} -o bin/${API_BINARY}

install:
	go install

test:
	go test

docker-build:
	docker build -t ${IMAGE}:${TAG} .
	docker tag ${IMAGE}:${TAG} ${IMAGE}:latest

docker-push:
	docker push ${IMAGE}:${TAG}
	docker push ${IMAGE}:latest
