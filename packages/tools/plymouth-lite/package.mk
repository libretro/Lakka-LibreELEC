################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="plymouth-lite"
PKG_VERSION="0.6.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.meego.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_INIT="toolchain gcc:init libpng"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="plymouth-lite: Boot splash screen based on Fedora's Plymouth code"
PKG_LONGDESC="Boot splash screen based on Fedora's Plymouth code"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$UVESAFB_SUPPORT" = yes ]; then
  PKG_DEPENDS_INIT="$PKG_DEPENDS_INIT v86d:init"
fi

pre_configure_init() {
  # plymouth-lite dont support to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME-init
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
    cp ply-image $INSTALL/bin

  mkdir -p $INSTALL/splash
    if [ -f $PROJECT_DIR/$PROJECT/splash/splash.conf ]; then
      cp $PROJECT_DIR/$PROJECT/splash/splash.conf $INSTALL/splash
      cp $PROJECT_DIR/$PROJECT/splash/*.png $INSTALL/splash
    elif [ -f $PROJECT_DIR/$PROJECT/splash/splash-1024.png \
           -o -f $PROJECT_DIR/$PROJECT/splash/splash-full.png ]; then
      cp $PROJECT_DIR/$PROJECT/splash/splash-*.png $INSTALL/splash
    elif [ -f $DISTRO_DIR/$DISTRO/splash/splash.conf ]; then
      cp $DISTRO_DIR/$DISTRO/splash/splash.conf $INSTALL/splash
      cp $DISTRO_DIR/$DISTRO/splash/*.png $INSTALL/splash
    elif [ -f $DISTRO_DIR/$DISTRO/splash/splash-1024.png \
           -o -f $DISTRO_DIR/$DISTRO/splash/splash-full.png ]; then
      cp $DISTRO_DIR/$DISTRO/splash/splash-*.png $INSTALL/splash
    else
      cp $PKG_DIR/splash/splash-*.png $INSTALL/splash
    fi
}
