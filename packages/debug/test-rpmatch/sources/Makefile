CC ?= gcc
# CFLAGS = -static -Wall -g3 -ggdb3 -Os
LDFLAGS =

SRCS = test.c
PROG = test

all: $(PROG)

$(PROG): $(SRCS)
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

clean:
	rm -f $(PROG)
