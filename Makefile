SHELL = /bin/bash

prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib
srcdir = Sources

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
RELEASEDIR = $(BUILDDIR)/release
SOURCES = $(wildcard $(srcdir)/**/*.swift)

.DEFAULT_GOAL = all

.PHONY: all
all: xmljson install

xmljson: $(SOURCES)
	@swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)"

install: xmljson
	@install "$(RELEASEDIR)/xmljson" "$(bindir)"
	@install "$(RELEASEDIR)/libSwiftToolsSupport.dylib" "$(libdir)"
	@install_name_tool -change \
		".build/x86_64-apple-macosx10.10/release/libSwiftToolsSupport.dylib" \
		"$(libdir)/libSwiftToolsSupport.dylib" \
		"$(bindir)/xmljson"

		echo "xmljson has been sucessfully installed."
		
uninstall:
	@rm -rf "$(bindir)/xmljson"
	@rm -rf "$(libdir)/libSwiftToolsSupport.dylib"

clean:
	@rm -rf $(BUILDDIR)
