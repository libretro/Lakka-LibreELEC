# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="moby"
PKG_VERSION="26.1.3"
PKG_SHA256="2f51e2dd1c122e364510c95f66e94b7fff9d5199545484e92c2e52b0efcdc2e6"
PKG_LICENSE="ASL"
PKG_SITE="https://mobyproject.org/"
PKG_URL="https://github.com/moby/moby/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host systemd"
PKG_LONGDESC="Moby is an open-source project created by Docker to enable and accelerate software containerization."
PKG_TOOLCHAIN="manual"

# Git commit of the matching release https://github.com/moby/moby
export PKG_GIT_COMMIT="8e96db1c328d0467b015768e42a62c0f834970bb"

PKG_MOBY_BUILDTAGS="daemon \
                    autogen \
                    exclude_graphdriver_devicemapper \
                    exclude_graphdriver_aufs \
                    exclude_graphdriver_btrfs \
                    journald"

configure_target() {
  go_configure

  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld ${CC}"

  # used for docker version
  export GITCOMMIT=${PKG_GIT_COMMIT}
  export VERSION=${PKG_VERSION}
  export BUILDTIME="$(date --utc)"

  cat > "${PKG_BUILD}/go.mod" << EOF
module github.com/docker/docker

go 1.18
EOF

  GO111MODULE=auto ${GOLANG} mod tidy -modfile 'vendor.mod' -compat 1.18
  GO111MODULE=auto ${GOLANG} mod vendor -modfile vendor.mod

  bash hack/make/.go-autogen
}

make_target() {
  mkdir -p bin
  ${GOLANG} build -mod=mod -modfile=vendor.mod -v -o bin/docker-proxy -a -ldflags "${LDFLAGS}" ./cmd/docker-proxy
  ${GOLANG} build -mod=mod -modfile=vendor.mod -v -o bin/dockerd -a -tags "${PKG_MOBY_BUILDTAGS}" -ldflags "${LDFLAGS}" ./cmd/dockerd
}

makeinstall_target() {
  :
}
