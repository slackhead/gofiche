# for debug add -g -O0 to line below
CFLAGS+=-pthread -O2 -Wall -Wextra -Wpedantic -Wstrict-overflow -fno-strict-aliasing -std=gnu11
prefix=/usr/local/bin

all:
	${CC} main.c fiche.c $(CFLAGS) -o gofiche

install: gofiche
	install -m 0755 gofiche $(DESTDIR)$(prefix)

clean:
	rm -f gofiche

.PHONY: clean
