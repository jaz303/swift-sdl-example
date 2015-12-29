main: main.swift modules/SDL2.swiftmodule modules/libSDL2_swift.dylib
	swiftc -L/usr/local/lib -L./modules -lSDL2_swift -lSDL2 -Xcc -I/usr/include -I ./modules $<

modules/libSDL2_swift.dylib:
	cd modules/SDL2; \
	swiftc \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name SDL2_swift \
		-emit-library \
		SDL2.swift; \
	mv *.dylib ..

modules/SDL2.swiftmodule:
	cd modules/SDL2; \
	swiftc \
		-I ../ \
		-Xcc -I/usr/include \
		-module-name SDL2_swift \
		-emit-module \
		-emit-module-path ../SDL2_swift.swiftmodule \
		SDL2.swift

clean:
	rm -f main modules/SDL2.* modules/lib*

.PHONY: clean