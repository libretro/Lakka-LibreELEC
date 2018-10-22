# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="wetekdvb"
PKG_VERSION="20180222"
PKG_SHA256="9deb42ede05082279da971edf1ec0133c0f5da6edcae9d69c04f022fc91c7d6c"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.wetek.com/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Wetek's DVB driver "
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  device=${DEVICE:-$PROJECT}
  [ $device = "S905" ] && device=WeTek_Play_2
  for overlay_dir in driver/$device/*/; do
    overlay_dir=`basename $overlay_dir`
    mkdir -p $INSTALL/$(get_full_module_dir $overlay_dir)/$PKG_NAME
    cp driver/$device/$overlay_dir/wetekdvb.ko $INSTALL/$(get_full_module_dir $overlay_dir)/$PKG_NAME
  done

  mkdir -p $INSTALL/$(get_full_firmware_dir)
    cp firmware/* $INSTALL/$(get_full_firmware_dir)
}

post_install() {
  enable_service wetekdvb.service
}
