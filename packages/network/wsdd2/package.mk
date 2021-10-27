# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wsdd2"
PKG_VERSION="1.8.6"
PKG_SHA256="707f9403559de70cc488c6c3deea12baf30d74068da88a59e7c0669a347b4661"
PKG_LICENSE="GPL 3.0"
PKG_SITE="https://github.com/Netgear/wsdd2/"
PKG_URL="https://github.com/Netgear/wsdd2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="WSD/LLMNR Discovery/Name Service Daemon"
PKG_BUILD_FLAGS="+size"

post_install() {
  enable_service wsdd2.service
}
