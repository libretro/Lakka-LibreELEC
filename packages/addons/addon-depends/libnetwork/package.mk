# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libnetwork"
PKG_VERSION="a543cbc4871f904b0efe205708eb45d72e65fd8b"
PKG_SHA256="3e3b0048aa468de0fe33ad2c08bf3891ac1a72fca434f92620312da51f344488"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/docker/libnetwork"
PKG_URL="https://github.com/docker/libnetwork/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="A native Go implementation for connecting containers."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  go_configure

  export CGO_ENABLED=0
  export LDFLAGS="-extld ${CC}"
  export GO111MODULE=off

  mkdir -p ${GOPATH}
  if [ -d ${PKG_BUILD}/vendor ]; then
    mv ${PKG_BUILD}/vendor ${GOPATH}/src
  fi

  ln -fs ${PKG_BUILD} ${GOPATH}/src/github.com/docker/libnetwork
}

make_target() {
  mkdir -p bin
  ${GOLANG} build -v -o bin/docker-proxy -a -ldflags "${LDFLAGS}" ./cmd/proxy
}
