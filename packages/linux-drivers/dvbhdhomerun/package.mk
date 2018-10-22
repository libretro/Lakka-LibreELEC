# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="dvbhdhomerun"
PKG_VERSION="20130704"
PKG_SHA256="1af817b85b163f3c6c3a9a07410f54875e74513c197709638b4922165e894f54"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/dvbhdhomerun/"
PKG_URL="${DISTRO_SRC}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
#PKG_URL="$SOURCEFORGE_SRC/project/dvbhdhomerun/${PKG_NAME}_${PKG_VERSION}.tar.gz"
#PKG_DEPENDS_TARGET="toolchain linux libhdhomerun"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="A linux DVB driver for the HDHomeRun TV tuner (http://www.silicondust.com)."
PKG_IS_KERNEL_PKG="yes"

PKG_CMAKE_SCRIPT="userhdhomerun/CMakeLists.txt"

pre_make_target() {
  ( cd ../kernel
    LDFLAGS="" make dvb_hdhomerun KERNEL_DIR=$(kernel_path)
    fix_module_depends dvb_hdhomerun_core.ko "dvb_core"
  )
}

pre_configure_target() {

# use it here to be sure libhdhomerun is already built
  PKG_CMAKE_OPTS_TARGET="-DLIBHDHOMERUN_PATH=$(ls -d $BUILD/libhdhomerun-*/)"

# absolute path
  LIBHDHOMERUN_PATH=$(ls -d $BUILD/libhdhomerun-*/)
  sed -i "s|SET(LIBHDHOMERUN_PATH .*)|SET(LIBHDHOMERUN_PATH $LIBHDHOMERUN_PATH)|g" ../userhdhomerun/CMakeLists.txt
  sed -i "s|/etc/dvbhdhomerun|/tmp/dvbhdhomerun|g" ../userhdhomerun/hdhomerun_tuner.cpp
  sed -i "s|/etc/dvbhdhomerun|/tmp/dvbhdhomerun|g" ../userhdhomerun/hdhomerun_controller.cpp
}

makeinstall_target() {
  cd $PKG_BUILD
    mkdir -p $INSTALL/$(get_full_module_dir)/hdhomerun
      cp kernel/*.ko $INSTALL/$(get_full_module_dir)/hdhomerun/

    mkdir -p $INSTALL/usr/bin
      cp -PR .$TARGET_NAME/userhdhomerun $INSTALL/usr/bin
}
