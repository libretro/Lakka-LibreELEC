# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)

PKG_NAME="libnetwork"
PKG_VERSION="7b2b1fe"
PKG_SHA256="2eee331b6ded567a36e7db708405b34032b93938682cf049025f48b96d755bf6"
PKG_ARCH="any"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/docker/libnetwork"
PKG_URL="https://github.com/docker/libnetwork/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="system"
PKG_SHORTDESC="Libnetwork provides a native Go implementation for connecting containers"
PKG_LONGDESC="Libnetwork provides a native Go implementation for connecting containers"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  case $TARGET_ARCH in
    x86_64)
      export GOARCH=amd64
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
    aarch64)
      export GOARCH=arm64
      ;;
  esac

  export GOOS=linux
  export CGO_ENABLED=0
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=$CFLAGS
  export LDFLAGS="-extld $CC"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD.gopath
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin
}

make_target() {
  mkdir -p bin
  $GOLANG build -v -o bin/docker-proxy -a -ldflags "$LDFLAGS" ./cmd/proxy
}
