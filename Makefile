BUILDDIR=build
PLUGINBUILDDIR=$(BUILDDIR)/plugins
PLUGINBUILDER=./scripts/build-plugin.sh
BINARY=$(BUILDDIR)/rhp
GO=/usr/local/go/bin/go
GOOPTS=
SRCS=main.go types.go

all: clean $(BINARY) example-plugin

debug: GOOPTS += -race
debug: all

example-plugin:
	BUILD_PLUGIN_OUTDIR="$(PLUGINBUILDDIR)" GOOPTS=$(GOOPTS) $(PLUGINBUILDER) plugins/example

$(BINARY): $(SRCS)
	$(GO) fmt
	$(GO) build -o $(BINARY) $(GOOPTS) $(SRCS)

run: debug example-plugin
	./$(BINARY) -listen 0.0.0.0

.PHONY: clean
clean:
	rm -fr $(BUILDDIR)
	$(GO) clean
