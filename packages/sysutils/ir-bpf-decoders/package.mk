# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ir-bpf-decoders"
PKG_VERSION="1.20.0"
PKG_SHA256="aaf2b3d0cf3086317a4ee9c2a80af2520b59b303a71238742ee8bc20c4f2bbb6"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://linuxtv.org/"
PKG_URL="https://github.com/LibreELEC/ir-bpf-decoders/archive/v4l-utils-$PKG_VERSION.tar.gz"
PKG_LONGDESC="ir-bpf-decoders: precompiled binaries of IR BPF decoders from v4l-utils utils/keytable/bpf_protocols"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/udev/rc_keymaps/protocols
  cp $PKG_BUILD/*.o $INSTALL/usr/lib/udev/rc_keymaps/protocols
}
