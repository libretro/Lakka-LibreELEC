# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ir-bpf-decoders"
PKG_VERSION="v4l-utils-1.18.0"
PKG_SHA256="7d8777708ba861dcf46e26d5c04dc9f6e6181b4cb6a82cf836d1e015818a76e9"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://linuxtv.org/"
PKG_URL="https://github.com/LibreELEC/ir-bpf-decoders/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="ir-bpf-decoders: precompiled binaries of IR BPF decoders from v4l-utils utils/keytable/bpf_protocols"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/udev/rc_keymaps/protocols
  cp $PKG_BUILD/*.o $INSTALL/usr/lib/udev/rc_keymaps/protocols
}
