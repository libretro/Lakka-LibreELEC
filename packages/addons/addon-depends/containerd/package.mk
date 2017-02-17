################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
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

PKG_NAME="containerd"
PKG_VERSION="aa8187d"
PKG_ARCH="any"
PKG_LICENSE="APL"
PKG_SITE="https://containerd.tools/"
PKG_URL="https://github.com/docker/containerd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="system"
PKG_SHORTDESC="containerd is a daemon to control runC"
PKG_LONGDESC="containerd is a daemon to control runC, built for performance and density. containerd leverages runC's advanced features such as seccomp and user namespace support as well as checkpoint and restore for cloning and live migration of containers."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

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
        cortex-a7)
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
  export LDFLAGS="-w -extldflags -static -X github.com/docker/containerd.GitCommit=${PKG_VERSION} -extld $CC"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD.gopath:$PKG_BUILD/vendor/
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  ln -fs $PKG_BUILD $PKG_BUILD/vendor/src/github.com/docker/containerd
}

make_target() {
  mkdir -p bin
  $GOLANG build -v -o bin/containerd      -a -tags "static_build" -ldflags "$LDFLAGS" ./containerd
  $GOLANG build -v -o bin/containerd-shim -a -tags "static_build" -ldflags "$LDFLAGS" ./containerd-shim
}

makeinstall_target() {
  :
}
