# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

.PHONY: all
all: headphone-sense

PREFIX = /usr

.PHONY: install
install: headphone-sense
	install -d $(DESTDIR)$(PREFIX)/bin
	install $< $(DESTDIR)$(PREFIX)/bin
