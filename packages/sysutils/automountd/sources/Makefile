CC ?= gcc
CFLAGS ?= -Wall -g

HAL_CFLAGS        = $(shell pkg-config --cflags hal-storage)
HAL_LDFLAGS       = $(shell pkg-config --libs hal-storage)

GLIB_CFLAGS       = $(shell pkg-config --cflags glib-2.0)
GLIB_LDFLAGS      = $(shell pkg-config --libs glib-2.0)

DBUS_GLIB_CFLAGS  = $(shell pkg-config --cflags dbus-glib-1)
DBUS_GLIB_LDFLAGS = $(shell pkg-config --libs dbus-glib-1)

CFLAGS  += $(HAL_CFLAGS)  $(GLIB_CFLAGS)  $(DBUS_GLIB_CFLAGS)
LDFLAGS += $(HAL_LDFLAGS) $(GLIB_LDFLAGS) $(DBUS_GLIB_LDFLAGS)

SRCS = automountd.c
PROG = automountd

all: $(PROG)

$(PROG): $(SRCS)
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

clean:
	rm -f $(PROG)
