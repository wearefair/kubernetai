# Makefile for building CoreDNS with Kubernetai
GITCOMMIT:=$(shell git describe --dirty --always)
BINARY:=coredns
SYSTEM:=
VERBOSE:=-v

BIN_PATH = release/$(BINARY)-linux-amd64

# all: coredns
#
# coredns: godeps
# 	CGO_ENABLED=0 $(SYSTEM) go build $(VERBOSE) -ldflags="-s -w -X github.com/coredns/coredns/coremain.GitCommit=$(GITCOMMIT)" -o $(BINARY)

.PHONY: build godeps

all: build

build: godeps
	./build-all.sh

docker: build
	docker build --build-arg BIN_PATH=$(BIN_PATH) -t wearefair/kubernetai .

godeps:
	@ # Not vendoring these, so external plugins compile, avoiding:
	@ # cannot use c (type *"github.com/mholt/caddy".Controller) as type
	@ # *"github.com/coredns/coredns/vendor/github.com/mholt/caddy".Controller like errors.
	(cd $(GOPATH)/src/github.com/mholt/caddy 2>/dev/null              && git checkout -q master 2>/dev/null || true)
	(cd $(GOPATH)/src/github.com/miekg/dns 2>/dev/null                && git checkout -q master 2>/dev/null || true)
	(cd $(GOPATH)/src/github.com/prometheus/client_golang 2>/dev/null && git checkout -q master 2>/dev/null || true)
	go get -u github.com/mholt/caddy
	go get -u github.com/miekg/dns
	go get -u github.com/prometheus/client_golang/prometheus/promhttp
	go get -u github.com/prometheus/client_golang/prometheus
	(cd $(GOPATH)/src/github.com/mholt/caddy              && git checkout -q v0.11.1)
	(cd $(GOPATH)/src/github.com/miekg/dns                && git checkout -q v1.1.4)
	(cd $(GOPATH)/src/github.com/prometheus/client_golang && git checkout -q v0.9.1)
