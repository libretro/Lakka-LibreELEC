# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="containerd"
PKG_VERSION="c4446665cb9c30056f4998ed953e6d4ff22c7c39" # v1.2.0
PKG_SHA256="0bd3370f769c25f077445b77266a0afba6fe60b9caa443153e604d8727f2a891"
PKG_LICENSE="APL"
PKG_SITE="https://containerd.tools/"
PKG_URL="https://github.com/containerd/containerd/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_LONGDESC="A daemon to control runC, built for performance and density."
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
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=$CFLAGS
  # Update CONTAINERD_VERSION if you update the PKG_VERSION
  export CONTAINERD_VERSION=v1.2.0
  export CONTAINERD_REVISION=$PKG_VERSION
  export CONTAINERD_PKG=github.com/containerd/containerd
  export LDFLAGS="-w -extldflags -static -X ${CONTAINERD_PKG}/version.Version=${CONTAINERD_VERSION} -X ${CONTAINERD_PKG}/version.Revision=${CONTAINERD_REVISION} -X ${CONTAINERD_PKG}/version.Package=${CONTAINERD_PKG} -extld $CC"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD/.gopath
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  mkdir -p $PKG_BUILD/.gopath
  if [ -d $PKG_BUILD/vendor ]; then
    mv $PKG_BUILD/vendor $PKG_BUILD/.gopath/src
  fi

  ln -fs $PKG_BUILD $PKG_BUILD/.gopath/src/github.com/containerd/containerd
}

make_target() {
  mkdir -p bin
  $GOLANG build -v -o bin/containerd      -a -tags "static_build no_btrfs" -ldflags "$LDFLAGS" ./cmd/containerd
  $GOLANG build -v -o bin/containerd-shim -a -tags "static_build no_btrfs" -ldflags "$LDFLAGS" ./cmd/containerd-shim
}
