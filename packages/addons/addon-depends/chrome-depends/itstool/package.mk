# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="itstool"
#PKG_VERSION="2.0.6"
PKG_VERSION="e21be796ad7c274674aa62817b405569039f669f"
PKG_SHA256=""
#PKG_SHA256="6233cc22726a9a5a83664bf67d1af79549a298c23185d926c3677afa917b92a9"
PKG_LICENSE="GPLv3"
PKG_SITE="http://itstool.org"
#PKG_URL="http://files.itstool.org/itstool/itstool-${PKG_VERSION}.tar.bz2"
PKG_URL="https://github.com/itstool/itstool/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain libxml2:host"
PKG_LONGDESC="ITS Tool allows you to translate your XML documents with PO files."
PKG_TOOLCHAIN="autotools"
