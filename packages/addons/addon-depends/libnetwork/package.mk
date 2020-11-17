# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libnetwork"
PKG_VERSION="535ef365dc1dd82a5135803a58bc6198a3b9aa27"
PKG_SHA256="19743ff09198d7b16bbfe9fcd26fc82781982a4a11b0bc4f46eaaeff8a555ccd"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/docker/libnetwork"
PKG_URL="https://github.com/docker/libnetwork/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="A native Go implementation for connecting containers."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  go_configure

  export CGO_ENABLED=0
  export LDFLAGS="-extld $CC"

  mkdir -p ${GOPATH}
  if [ -d $PKG_BUILD/vendor ]; then
    mv $PKG_BUILD/vendor ${GOPATH}/src
  fi

  ln -fs $PKG_BUILD ${GOPATH}/src/github.com/docker/libnetwork
}

make_target() {
  mkdir -p bin
  $GOLANG build -v -o bin/docker-proxy -a -ldflags "$LDFLAGS" ./cmd/proxy
}
