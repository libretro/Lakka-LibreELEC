# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="docker"
PKG_VERSION="18.06.1"
PKG_SHA256="153cb489033686260dfe7a42acbdd1753d56f7a9c2d7ad90633f0c8cce563b23"
PKG_REV="119"
PKG_ARCH="any"
PKG_ADDON_PROJECTS="any !WeTek_Core !WeTek_Play"
PKG_LICENSE="ASL"
PKG_SITE="http://www.docker.com/"
PKG_URL="https://github.com/docker/docker-ce/archive/v${PKG_VERSION}-ce.tar.gz"
PKG_DEPENDS_TARGET="toolchain sqlite go:host containerd runc libnetwork tini systemd"
PKG_SECTION="service/system"
PKG_SHORTDESC="Docker is an open-source engine that automates the deployment of any application as a lightweight, portable, self-sufficient container that will run virtually anywhere."
PKG_LONGDESC="Docker containers can encapsulate any payload, and will run consistently on and between virtually any server. The same container that a developer builds and tests on a laptop will run at scale, in production*, on VMs, bare-metal servers, OpenStack clusters, public instances, or combinations of the above."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Docker"
PKG_ADDON_TYPE="xbmc.service"

configure_target() {
  export DOCKER_BUILDTAGS="daemon \
                           autogen \
                           exclude_graphdriver_devicemapper \
                           exclude_graphdriver_aufs \
                           exclude_graphdriver_btrfs \
                           journald"

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
  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld $CC"
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOPATH=$PKG_BUILD/.gopath_cli:$PKG_BUILD/.gopath
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  mkdir -p $PKG_BUILD/.gopath
  mkdir -p $PKG_BUILD/.gopath_cli

  PKG_ENGINE_PATH=$PKG_BUILD/components/engine
  PKG_CLI_PATH=$PKG_BUILD/components/cli

  if [ -d $PKG_ENGINE_PATH/vendor ]; then
    mv $PKG_ENGINE_PATH/vendor $PKG_BUILD/.gopath/src
  fi

  if [ -d $PKG_CLI_PATH/vendor ]; then
    mv $PKG_CLI_PATH/vendor $PKG_BUILD/.gopath_cli/src
  fi

  cp -rf $PKG_BUILD/.gopath/src/* $PKG_BUILD/.gopath_cli/src

  mkdir -p $PKG_BUILD/.gopath_cli/src/github.com/docker/docker/builder
  cp -rf $PKG_ENGINE_PATH/builder/* $PKG_BUILD/.gopath_cli/src/github.com/docker/docker/builder

  if [ ! -L $PKG_BUILD/.gopath/src/github.com/docker/docker ];then
    ln -fs $PKG_ENGINE_PATH $PKG_BUILD/.gopath/src/github.com/docker/docker
  fi

  if [ ! -L $PKG_BUILD/.gopath_cli/src/github.com/docker/cli ];then
    ln -fs $PKG_CLI_PATH $PKG_BUILD/.gopath_cli/src/github.com/docker/cli
  fi

  # used for docker version
  export GITCOMMIT=${PKG_VERSION}-ce
  export VERSION=${PKG_VERSION}-ce
  export BUILDTIME="$(date --utc)"

  cd $PKG_ENGINE_PATH
  bash hack/make/.go-autogen
  cd $PKG_BUILD
}

make_target() {
  mkdir -p bin
  PKG_CLI_FLAGS="-X 'github.com/docker/cli/cli.Version=${VERSION}'"
  PKG_CLI_FLAGS="${PKG_CLI_FLAGS} -X 'github.com/docker/cli/cli.GitCommit=${GITCOMMIT}'"
  PKG_CLI_FLAGS="${PKG_CLI_FLAGS} -X 'github.com/docker/cli/cli.BuildTime=${BUILDTIME}'"
  $GOLANG build -v -o bin/docker -a -tags "$DOCKER_BUILDTAGS" -ldflags "$LDFLAGS ${PKG_CLI_FLAGS}" ./components/cli/cmd/docker
  $GOLANG build -v -o bin/dockerd -a -tags "$DOCKER_BUILDTAGS" -ldflags "$LDFLAGS" ./components/engine/cmd/dockerd
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $PKG_BUILD/bin/docker $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $PKG_BUILD/bin/dockerd $ADDON_BUILD/$PKG_ADDON_ID/bin

    # containerd
    cp -P $(get_build_dir containerd)/bin/containerd $ADDON_BUILD/$PKG_ADDON_ID/bin/docker-containerd
    cp -P $(get_build_dir containerd)/bin/containerd-shim $ADDON_BUILD/$PKG_ADDON_ID/bin/docker-containerd-shim

    # libnetwork
    cp -P $(get_build_dir libnetwork)/bin/docker-proxy $ADDON_BUILD/$PKG_ADDON_ID/bin/docker-proxy

    # runc
    cp -P $(get_build_dir runc)/bin/runc $ADDON_BUILD/$PKG_ADDON_ID/bin/docker-runc

    # tini
    cp -P $(get_build_dir tini)/.$TARGET_NAME/tini-static $ADDON_BUILD/$PKG_ADDON_ID/bin/docker-init
}
