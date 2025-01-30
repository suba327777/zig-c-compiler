9cc: src/main.zig
	zig build-exe src/main.zig

test: main
	./test.sh

clean:
	rm -f main *.o *~ tmp*

.PHONY: test clean
