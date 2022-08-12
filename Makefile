TARGET=./dist
ARCHS=amd64 386
GOOS=windows linux darwin
LDFLAGS="-s -w"
NAME="go2rev"

.PHONY: help windows linux mac all clean

help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

windows: ## Make Windows x86 and x64 Binaries
	@for ARCH in ${ARCHS}; do \
		echo "Building for windows $${ARCH}.." ;\
		GOOS=windows GOARCH=$${ARCH} go build -a -ldflags ${LDFLAGS} -trimpath -o ${TARGET}/${NAME}_$${ARCH}.exe || exit 1 ;\
	done; \
	echo "Done."

linux: ## Make Linux x86 and x64 Binaries
	@for ARCH in ${ARCHS}; do \
		echo "Building for linux $${ARCH}..." ; \
		GOOS=linux GOARCH=$${ARCH} go build -a -ldflags ${LDFLAGS} -trimpath -o ${TARGET}/${NAME}_linux_$${ARCH} || exit 1 ;\
	done; \
	echo "Done."

mac: ## Make Darwin (Mac) x86 and x64 Binaries
	@for ARCH in ${ARCHS}; do \
		echo "Building for mac $${ARCH}..." ; \
		GOOS=darwin GOARCH=$${ARCH} go build -a -ldflags ${LDFLAGS} -trimpath -o ${TARGET}/${NAME}_mac_$${ARCH} || exit 1 ;\
	done; \
	echo "Done."

install: ## Install to System
	@go build -a -ldflags ${LDFLAGS} -o /usr/local/bin/fscan
	@echo "Done."
	@echo "========Test========"
	@fscan

clean: ## Delete any binaries
	@rm -f ${TARGET}/* ; \
	echo "Done."

all: ## Make Windows, Linux and Mac x86/x64 Binaries
all: clean windows linux mac
