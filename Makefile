PROJECT := gopal
PACKAGE := github.com/remerge/$(PROJECT)

GOMETALINTER_OPTS = --enable-all --tests --fast --errors

include Makefile.common

# https://golang.org/doc/install/source#environment
DIST_PLATFORMS := darwin_amd64 linux_amd64

.PHONY: dist $(DIST_PLATFORMS)

dist: $(DIST_PLATFORMS)

$(DIST_PLATFORMS): # i'm sure we can do this better
	CGO_ENABLED=0 \
	GOOS=$(word 1, $(subst _, ,$@)) GOARCH=$(word 2, $(subst _, ,$@)) \
	go build -v -i -ldflags "$(LDFLAGS)" -o $(PROJECT) $(MAINGO) && \
		tar -czvf $(PROJECT)-$(CODE_VERSION)-$@.tar.gz $(PROJECT) && \
		rm $(PROJECT)
