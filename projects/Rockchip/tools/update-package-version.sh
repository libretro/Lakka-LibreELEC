#!/bin/bash

SCRIPTPATH=$(dirname $0)

function update_pkg_version {
  PKG_NAME=$1
  PKG_REPO=$2
  PKG_BRANCH=$3
  PKG_PATH=$SCRIPTPATH/../packages/$PKG_NAME/package.mk

  echo "$PKG_NAME ($PKG_BRANCH @ $PKG_REPO)"

  if [ "$PKG_NAME" = "linux" ]; then
    PKG_PATH=$SCRIPTPATH/../../../packages/$PKG_NAME/package.mk
    eval $(grep "^  rockchip-4.4)" $PKG_PATH -A1 | grep PKG_VERSION)
  else
    eval $(grep "^PKG_VERSION" $PKG_PATH)
  fi

  if [ -z "$PKG_VERSION" ]; then
    echo "ERROR: PKG_VERSION is empty"
    exit 1
  fi

  echo " PKG_VERSION=$PKG_VERSION"

  if [ "$PKG_NAME" = "linux" ]; then
    GIT_REV=$(git ls-remote --heads $PKG_REPO $PKG_BRANCH | cut -c1-8)
  else
    GIT_REV=$(git ls-remote --heads $PKG_REPO $PKG_BRANCH | cut -c1-7)
  fi

  if [ -z "$GIT_REV" ]; then
    echo "ERROR: GIT_REV is empty"
    exit 1
  fi

  echo " GIT_REV=$GIT_REV"

  if [ "$PKG_VERSION" != "$GIT_REV" ]; then
    echo "Updating package.mk"
    sed -i "s/PKG_VERSION=\"$PKG_VERSION\"/PKG_VERSION=\"$GIT_REV\"/" $PKG_PATH
  fi

  echo
}

update_pkg_version linux https://github.com/rockchip-linux/kernel.git release-4.4
update_pkg_version rkbin https://github.com/rockchip-linux/rkbin.git master
update_pkg_version u-boot https://github.com/rockchip-linux/u-boot.git release
update_pkg_version rkmpp https://github.com/rockchip-linux/mpp.git release
update_pkg_version mali-rockchip https://github.com/rockchip-linux/libmali.git rockchip
