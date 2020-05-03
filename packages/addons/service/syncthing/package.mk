# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="syncthing"
PKG_VERSION="1.4.2"
PKG_SHA256="061af43c1bbfcdf949499cdc50a325fff7cd67fb48f9d270adb52b4decbab899"
PKG_REV="109"
PKG_ARCH="any"
PKG_LICENSE="MPLv2"
PKG_SITE="https://syncthing.net/"
PKG_URL="https://github.com/syncthing/syncthing/releases/download/v${PKG_VERSION}/syncthing-source-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="service/system"
PKG_SHORTDESC="Syncthing: open source continuous file synchronization"
PKG_LONGDESC="Syncthing ($PKG_VERSION) replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Syncthing"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

configure_target() {
  export CGO_CFLAGS=${CFLAGS}
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export GOLANG=${TOOLCHAIN}/lib/golang/bin/go
  export GOOS=linux
  export GOROOT=${TOOLCHAIN}/lib/golang
  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld ${CC} \
                  -X github.com/syncthing/syncthing/lib/build.Version=v${PKG_VERSION}"
  export PATH=${PATH}:${GOROOT}/bin

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
        *)
          export GOARM=7
          ;;
      esac
      ;;
  esac
}

make_target() {
  ${GOLANG} build -v -o bin/syncthing -a -ldflags "${LDFLAGS}" ./cmd/syncthing
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp -P ${PKG_BUILD}/bin/syncthing ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
