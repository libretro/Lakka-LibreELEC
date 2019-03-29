# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="crazycat_aml"
PKG_VERSION="835dc72da3ee63df7f4057bd0507887454c005d1"
PKG_SHA256="3d68d368a9eda15688c6686caa854a045a753740ec93553d80a4bcfc14c2950a"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://bitbucket.org/CrazyCat/media_build"
PKG_URL="https://bitbucket.org/CrazyCat/media_build/get/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux media_tree_cc_aml"
PKG_NEED_UNPACK="$LINUX_DEPENDS media_tree_cc_aml"
PKG_SECTION="driver.dvb"
PKG_LONGDESC="DVB drivers from the latest kernel"

PKG_IS_ADDON="embedded"
PKG_IS_KERNEL_PKG="yes"
PKG_ADDON_IS_STANDALONE="yes"
PKG_ADDON_NAME="DVB drivers from the latest kernel"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  export LDFLAGS=""
}

make_target() {
  cp -RP $(get_build_dir media_tree_cc_aml)/* $PKG_BUILD/linux

  # compile modules
  echo "obj-y += video_dev/" >> "$PKG_BUILD/linux/drivers/media/platform/meson/Makefile"
  echo "obj-y += wetek/" >> "$PKG_BUILD/linux/drivers/media/platform/meson/Makefile"

  # make config all
  kernel_make VER=$KERNEL_VER SRCDIR=$(kernel_path) allyesconfig

  # deactivate several build options
  sed '/CONFIG_VIDEO_S5C73M3=m/d' -i $PKG_BUILD/v4l/.config

  # enable AML drivers
  echo "CONFIG_IR_MESON=m" >> $PKG_BUILD/v4l/.config
  echo "CONFIG_V4L_AMLOGIC_VIDEO=m" >> $PKG_BUILD/v4l/.config
  echo "CONFIG_VIDEOBUF_RESOURCE=m" >> $PKG_BUILD/v4l/.config

  kernel_make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  install_driver_addon_files "$PKG_BUILD/v4l/"
}
