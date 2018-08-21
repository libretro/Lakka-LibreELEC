# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="crazycat"
PKG_VERSION="2017-12-06"
PKG_SHA256="779c7d42e5fd4dfac8f53654ce8af467d22a81b6c0b21e24f14aaaed033c6eb1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/crazycat69/linux_media"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver.dvb"
PKG_LONGDESC="DVB driver for TBS cards with CrazyCats additions."

PKG_IS_ADDON="embedded"
PKG_IS_KERNEL_PKG="yes"
PKG_ADDON_IS_STANDALONE="yes"
PKG_ADDON_NAME="DVB drivers for TBS (CrazyCat)"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

if [ $LINUX = "amlogic-3.10" ]; then
  PKG_PATCH_DIRS="amlogic-3.10"
elif [ $LINUX = "amlogic-3.14" ]; then
  PKG_PATCH_DIRS="amlogic-3.14"
fi

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  export LDFLAGS=""
}

make_target() {
  kernel_make SRCDIR=$(kernel_path) untar

  # copy config file
  if [ "$PROJECT" = Generic ]; then
    if [ -f $PKG_DIR/config/generic.config ]; then
      cp $PKG_DIR/config/generic.config v4l/.config
    fi
  else
    if [ -f $PKG_DIR/config/usb.config ]; then
      cp $PKG_DIR/config/usb.config v4l/.config
    fi
  fi

  # hack to workaround media_build bug
  if [ $LINUX = "amlogic-3.14" -o $LINUX = "amlogic-3.10" ]; then
    sed -e 's/CONFIG_VIDEO_TVP5150=m/# CONFIG_VIDEO_TVP5150 is not set/g' -i v4l/.config
    sed -e 's/CONFIG_DVB_LGDT3306A=m/# CONFIG_DVB_LGDT3306A is not set/g' -i v4l/.config
    if [ $LINUX = "amlogic-3.10" ]; then
      sed -e 's/CONFIG_IR_NUVOTON=m/# CONFIG_IR_NUVOTON is not set/g' -i v4l/.config
    fi
  elif [ "$PROJECT" = Rockchip ]; then
    sed -e 's/CONFIG_DVB_CXD2820R=m/# CONFIG_DVB_CXD2820R is not set/g' -i v4l/.config
    sed -e 's/CONFIG_DVB_LGDT3306A=m/# CONFIG_DVB_LGDT3306A is not set/g' -i v4l/.config
  fi

  # add menuconfig to edit .config
  kernel_make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  install_driver_addon_files "$PKG_BUILD/v4l/"
}
