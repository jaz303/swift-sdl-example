main: main.swift
	swiftc -L/usr/local/lib -Xcc -I/usr/include -I ./modules $<

clean:
	rm -f main

.PHONY: clean