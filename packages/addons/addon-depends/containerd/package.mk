# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="containerd"
PKG_VERSION="1.2.8"
PKG_SHA256="6165ae2ad669d9ec6d317492d30a1511365bd31ad29efae757f19c1828bf75b3"
PKG_LICENSE="APL"
PKG_SITE="https://containerd.tools/"
PKG_URL="https://github.com/containerd/containerd/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="A daemon to control runC, built for performance and density."
PKG_TOOLCHAIN="manual"

# Git commit of the matching release https://github.com/containerd/containerd/releases
PKG_GIT_COMMIT="a4bc1d432a2c33aa2eed37f338dceabb93641310"

pre_make_target() {
  case ${TARGET_ARCH} in
    x86_64)
      export GOARCH=amd64
      ;;
    arm)
      export GOARCH=arm

      case ${TARGET_CPU} in
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
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=${CFLAGS}
  export CONTAINERD_VERSION=${PKG_VERSION}
  export CONTAINERD_REVISION=${PKG_GIT_COMMIT}
  export CONTAINERD_PKG=github.com/containerd/containerd
  export LDFLAGS="-w -extldflags -static -X ${CONTAINERD_PKG}/version.Version=${CONTAINERD_VERSION} -X ${CONTAINERD_PKG}/version.Revision=${CONTAINERD_REVISION} -X ${CONTAINERD_PKG}/version.Package=${CONTAINERD_PKG} -extld $CC"
  export GOLANG=${TOOLCHAIN}/lib/golang/bin/go
  export GOPATH=${PKG_BUILD}/.gopath
  export GOROOT=${TOOLCHAIN}/lib/golang
  export PATH=${PATH}:${GOROOT}/bin

  mkdir -p ${PKG_BUILD}/.gopath
  if [ -d ${PKG_BUILD}/vendor ]; then
    mv ${PKG_BUILD}/vendor ${PKG_BUILD}/.gopath/src
  fi

  ln -fs ${PKG_BUILD} ${PKG_BUILD}/.gopath/src/github.com/containerd/containerd
}

make_target() {
  mkdir -p bin
  ${GOLANG} build -v -o bin/containerd      -a -tags "static_build no_btrfs" -ldflags "${LDFLAGS}" ./cmd/containerd
  ${GOLANG} build -v -o bin/containerd-shim -a -tags "static_build no_btrfs" -ldflags "${LDFLAGS}" ./cmd/containerd-shim
}
