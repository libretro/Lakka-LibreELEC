# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="conmon"
PKG_VERSION="2.2.0"
PKG_SHA256="300d21c2244e1b5e90cc62d796da3e94812bec281bae6868d6e738432155319d"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/containers/conmon"
PKG_URL="https://github.com/containers/conmon/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib libseccomp systemd"
PKG_LONGDESC="An OCI container runtime monitor"

# Git commit of the matching release https://github.com/containers/conmon
export PKG_GIT_COMMIT="ff908cce92cf89167b6b97ed240e91a6b147acc1"

pre_configure_target() {
  export PKG_CONFIG_PATH="$(get_install_dir libseccomp)/usr/lib/pkgconfig:${PKG_CONFIG_PATH}"
  export GIT_COMMIT=${PKG_GIT_COMMIT}
}
