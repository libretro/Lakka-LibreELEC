################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="syncthing"
PKG_VERSION="0.14.3"
PKG_REV="103"
PKG_ARCH="any"
PKG_LICENSE="MPLv2"
PKG_SITE="https://syncthing.net/"
PKG_URL="https://github.com/syncthing/syncthing/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="service/system"
PKG_SHORTDESC="Syncthing: open source continuous file synchronization"
PKG_LONGDESC="Syncthing ($PKG_VERSION) replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Syncthing"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

configure_target() {
  go run build.go assets

  mkdir -p $PKG_BUILD $PKG_BUILD/src/github.com/syncthing
  ln -fs $PKG_BUILD $PKG_BUILD/src/github.com/syncthing/syncthing
  ln -fs $PKG_BUILD/vendor $PKG_BUILD/vendor/src

  case $TARGET_ARCH in
    x86_64)
      export GOARCH=amd64
      ;;
    aarch64)
      export GOARCH=arm64
      ;;
    arm)
      export GOARCH=arm
      case $TARGET_CPU in
        arm1176jzf-s)
          export GOARM=6
          ;;
        cortex-a7|cortex-a9)
          export GOARM=7
          ;;
      esac
      ;;
  esac

  export GOOS=linux
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=$CFLAGS
  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld $CC -X main.Version=v$PKG_VERSION"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD/src/github.com/syncthing/syncthing:$PKG_BUILD/vendor:$PKG_BUILD/Godeps/_workspace
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin
}

make_target() {
  cd $PKG_BUILD/src/github.com/syncthing/syncthing
  mkdir -p bin
  $GOLANG build -v -o bin/syncthing -a -ldflags "$LDFLAGS" ./cmd/syncthing
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/bin/syncthing $ADDON_BUILD/$PKG_ADDON_ID/bin
}
