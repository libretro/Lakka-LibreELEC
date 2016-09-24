################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="xf86-video-virtualbox"
PKG_VERSION="5.0.22"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.virtualbox.org"
PKG_URL="http://download.virtualbox.org/virtualbox/$PKG_VERSION/VirtualBox-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="VirtualBox-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain libXcomposite libXdamage libXfixes libXext libX11 libxcb libXau libXmu"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-virtualbox: The Xorg driver for virtualbox video"
PKG_LONGDESC="xf86-video-virtualbox: The Xorg driver for virtualbox video"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  # let's use our sysroot instead
  for include in x11 xorg pixman-1; do
    sed -i "s| \(/usr/include/${include}\)| ${SYSROOT_PREFIX}\1|" $ROOT/$PKG_BUILD/src/VBox/Additions/x11/vboxvideo/Makefile.kmk
  done
}

configure_target() {
  cd $ROOT/$PKG_BUILD
  ./configure --nofatal \
              --disable-xpcom \
              --disable-sdl-ttf \
              --disable-pulse \
              --disable-alsa \
              --with-gcc=$CC \
              --with-g++=$CXX \
              --target-arch=amd64 \
              --with-linux=$(kernel_path) \
              --build-headless
}

make_target() {
  . env.sh
  export VBOX_GCC_OPT="${CFLAGS} ${CPPFLAGS}"

  kmk TOOL_YASM_AS=yasm \
      VBOX_USE_SYSTEM_XORG_HEADERS=1 \
      KBUILD_PATH="$ROOT/$PKG_BUILD/kBuild" \
      KBUILD_VERBOSE=2 
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -P $ROOT/$PKG_BUILD/out/linux.amd64/release/bin/additions/VBoxService $INSTALL/usr/sbin/vboxguest-service
    cp -P $ROOT/$PKG_BUILD/out/linux.amd64/release/bin/additions/mount.vboxsf $INSTALL/usr/sbin

  mkdir -p $INSTALL/usr/bin
    cp -P $ROOT/$PKG_BUILD/out/linux.amd64/release/bin/additions/VBoxControl $INSTALL/usr/bin
    cp -P $ROOT/$PKG_BUILD/out/linux.amd64/release/bin/additions/VBoxClient $INSTALL/usr/bin
}

post_install() {
  # automount Error: VBoxServiceAutoMountWorker: Group "vboxsf" does not exist
  add_group vboxsf 300

  enable_service virtualbox-display.service
  enable_service virtualbox-guest-additions.service
}
