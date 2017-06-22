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

PKG_NAME="runc"
PKG_VERSION="9df8b30"
PKG_ARCH="any"
PKG_LICENSE="APL"
PKG_SITE="https://github.com/opencontainers/runc"
PKG_URL="https://github.com/opencontainers/runc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="system"
PKG_SHORTDESC="runc is a CLI tool for spawning and running containers according to the OCI specification"
PKG_LONGDESC="runc is a CLI tool for spawning and running containers according to the OCI specification"

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
  export LDFLAGS="-w -extldflags -static -X main.gitCommit=${PKG_VERSION} -X main.version=$(cat ./VERSION) -extld $CC"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD.gopath:$PKG_BUILD/Godeps/_workspace/
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  ln -fs $PKG_BUILD $PKG_BUILD/Godeps/_workspace/src/github.com/opencontainers/runc
}

make_target() {
  mkdir -p bin
  $GOLANG build -v -o bin/runc -a -tags "cgo static_build" -ldflags "$LDFLAGS" ./
}

makeinstall_target() {
  :
}
