# compile against luajit and use '/usr' as install prefix
CMAKE_ARGS:="-DLUA_LIBRARY=/usr/lib/$(shell dpkg-architecture -qDEB_HOST_GNU_TYPE)/libluajit-5.1.so -DLUA_INCLUDE_DIR=/usr/include/luajit-2.0 -DCMAKE_INSTALL_PREFIX=/usr"

ifeq (,$(VERBOSE))
    MAKEFLAGS:=$(MAKEFLAGS)s
    ECHO=echo
else
    ECHO=@:
endif

TARGETS=awesome
BUILDDIR=build

all: check-unit $(TARGETS) ;

$(TARGETS): cmake-build

$(BUILDDIR)/Makefile:
	$(ECHO) "Creating build directory and running cmake in it. You can also run CMake directly, if you want."
	$(ECHO)
	mkdir -p $(BUILDDIR)
	$(ECHO) "Running cmake…"
	cd $(BUILDDIR) && cmake "${CMAKE_ARGS}" "$(@D)" ..

cmake-build: $(BUILDDIR)/Makefile
	$(ECHO) "Building…"
	$(MAKE) -C $(BUILDDIR)

tags:
	git ls-files | xargs ctags

install:
	$(ECHO) "Installing…"
	$(MAKE) -C $(BUILDDIR) install

distclean:
	$(ECHO) -n "Cleaning up build directory…"
	$(RM) -r $(BUILDDIR) $(TARGETS)
	$(ECHO) " done"

%: $(BUILDDIR)/Makefile
	$(ECHO) "Running make $@ in $(BUILDDIR)…"
	$(MAKE) -C $(BUILDDIR) $@

.PHONY: cmake-build install distclean tags
