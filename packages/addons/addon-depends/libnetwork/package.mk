# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libnetwork"
PKG_VERSION="64b7a4574d1426139437d20e81c0b6d391130ec8" # 2021-05-25
PKG_SHA256="ede21e645ff6552b3a508f6186d3f34d267015ec0f96eefecf6d08c03cbd2987"
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
