#!/bin/sh

SCRIPTPATH=$(dirname $0)
PKG_NAME=ffmpeg
eval $(grep "^PKG_VERSION" $SCRIPTPATH/../../../packages/multimedia/$PKG_NAME/package.mk)
PKG_BASE=$PKG_VERSION

if [ ! -d .git ]; then
  echo "ERROR: current path is not a git repository"
  exit 1
fi

git format-patch $PKG_BASE --no-signature --stdout > $SCRIPTPATH/../../../packages/multimedia/$PKG_NAME/patches/${PKG_NAME}-99.1011-Add-support-for-Rockchip-Media-Process-Platform.patch
