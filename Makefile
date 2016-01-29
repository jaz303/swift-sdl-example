SDL2_LIB_NAME := SDL2_swift
SDL2_DYLIB := lib$(SDL2_LIB_NAME).dylib
SDL2_SWIFTMODULE := $(SDL2_LIB_NAME).swiftmodule
LIB_DIR := /usr/local/lib # where SDL is installed

build/main: build extensions main.swift modules/$(SDL2_SWIFTMODULE) build/$(SDL2_DYLIB)
	swiftc \
		-L$(LIB_DIR) \
		-L./build \
		-l$(SDL2_LIB_NAME) \
		-lSDL2 \
		-Xcc -I/usr/include \
		-I ./modules \
		-o build/main \
		main.swift

build:
	mkdir -p build

# TODO: fix install_name_tool kludge
build/$(SDL2_DYLIB): build extensions
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

modules/$(SDL2_SWIFTMODULE): build extensions
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

extensions: build/libSDL2_swift_extensions.dylib

build/libSDL2_swift_extensions.dylib: modules/CSDL2/libSDL2_swift_extensions.dylib
	cp $< $@
	install_name_tool -id build/libSDL2_swift_extensions.dylib $@

clean:
	rm -rf build
	rm -f modules/*.swift{doc,module}

.PHONY: clean extensions