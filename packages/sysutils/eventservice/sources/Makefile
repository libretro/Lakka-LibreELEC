# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

.PHONY: all
all: spkeys-service

PREFIX = /usr

.PHONY: install
install: spkeys-service
	install -d $(DESTDIR)$(PREFIX)/bin
	install $< $(DESTDIR)$(PREFIX)/bin
