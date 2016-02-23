LIB_DIR := /usr/local/lib # where SDL is installed

CAIRO_LIB_NAME := Cairo_swift
CAIRO_DYLIB := lib$(CAIRO_LIB_NAME).dylib
CAIRO_SWIFTMODULE := $(CAIRO_LIB_NAME).swiftmodule

SDL2_LIB_NAME := SDL2_swift
SDL2_DYLIB := lib$(SDL2_LIB_NAME).dylib
SDL2_SWIFTMODULE := $(SDL2_LIB_NAME).swiftmodule

SPLINE_LIB_NAME := spline
SPLINE_DYLIB := lib$(SPLINE_LIB_NAME).dylib
SPLINE_SWIFTMODULE := $(SPLINE_LIB_NAME).swiftmodule

build/main: build main.swift sdl2 cairo spline
	swiftc \
		-L$(LIB_DIR) \
		-L./build \
		-l$(SDL2_LIB_NAME) \
		-l$(CAIRO_LIB_NAME) \
		-l$(SPLINE_LIB_NAME) \
		-lSDL2 \
		-lcairo \
		-Xcc -I/usr/include \
		-I ./modules \
		-o build/main \
		main.swift

build:
	mkdir -p build

sdl2: build/$(SDL2_DYLIB) modules/$(SDL2_SWIFTMODULE)

# TODO: fix install_name_tool kludge
build/$(SDL2_DYLIB): build
	cd modules/SDL2 && \
	swiftc \
		-L$(LIB_DIR) \
		-L../../build \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name $(SDL2_LIB_NAME) \
		-emit-library \
		-o ../../build/$(SDL2_DYLIB) \
		SDL2.swift && \
	install_name_tool -id build/$(SDL2_DYLIB) ../../build/$(SDL2_DYLIB)

modules/$(SDL2_SWIFTMODULE): build
	cd modules/SDL2 && \
	swiftc \
		-L$(LIB_DIR) \
		-L/../../build \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name $(SDL2_LIB_NAME) \
		-emit-module \
		-emit-module-path ../$(SDL2_SWIFTMODULE) \
		SDL2.swift

cairo: build/$(CAIRO_DYLIB) modules/$(CAIRO_SWIFTMODULE)

build/$(CAIRO_DYLIB): build
	cd modules/Cairo && \
	swiftc \
		-L$(LIB_DIR) \
		-L../../build \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name $(CAIRO_LIB_NAME) \
		-emit-library \
		-o ../../build/$(CAIRO_DYLIB) \
		Cairo.swift && \
	install_name_tool -id build/$(CAIRO_DYLIB) ../../build/$(CAIRO_DYLIB)

modules/$(CAIRO_SWIFTMODULE): build
	cd modules/Cairo && \
	swiftc \
		-L$(LIB_DIR) \
		-L/../../build \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name $(CAIRO_LIB_NAME) \
		-emit-module \
		-emit-module-path ../$(CAIRO_SWIFTMODULE) \
		Cairo.swift

spline: build/$(SPLINE_DYLIB) modules/$(SPLINE_SWIFTMODULE)

build/$(SPLINE_DYLIB): build sdl2 cairo
	cd modules/spline && \
	swiftc \
		-L$(LIB_DIR) \
		-L../../build \
		-l$(SDL2_LIB_NAME) \
		-l$(CAIRO_LIB_NAME) \
		-lSDL2 \
		-lcairo \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name $(SPLINE_LIB_NAME) \
		-emit-library \
		-o ../../build/$(SPLINE_DYLIB) \
		spline.swift && \
	install_name_tool -id build/$(SPLINE_DYLIB) ../../build/$(SPLINE_DYLIB)

modules/$(SPLINE_SWIFTMODULE): build
	cd modules/spline && \
	swiftc \
		-L$(LIB_DIR) \
		-L/../../build \
		-l$(SDL2_LIB_NAME) \
		-l$(CAIRO_LIB_NAME) \
		-lSDL2 \
		-lcairo \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name $(SPLINE_LIB_NAME) \
		-emit-module \
		-emit-module-path ../$(SPLINE_SWIFTMODULE) \
		spline.swift

clean:
	rm -rf build
	rm -f modules/*.swift{doc,module}

.PHONY: clean sdl2 cairo spline