# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libnetwork"
PKG_VERSION="4725f2163fb214a6312f3beae5991f838ec36326"
PKG_SHA256="049bddc1e584f30c29e0fed8716b3c7023d4bb31789d7c3aa48d17b979f1522b"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/docker/libnetwork"
PKG_URL="https://github.com/docker/libnetwork/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="A native Go implementation for connecting containers."
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
  export GOPATH=$PKG_BUILD/.gopath
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  mkdir -p $PKG_BUILD/.gopath
  if [ -d $PKG_BUILD/vendor ]; then
    mv $PKG_BUILD/vendor $PKG_BUILD/.gopath/src
  fi

  ln -fs $PKG_BUILD $PKG_BUILD/.gopath/src/github.com/docker/libnetwork
}

make_target() {
  mkdir -p bin
  $GOLANG build -v -o bin/docker-proxy -a -ldflags "$LDFLAGS" ./cmd/proxy
}
