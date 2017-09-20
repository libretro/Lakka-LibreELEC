#!/bin/sh

SCRIPTPATH=$(dirname $0)
PKG_NAME=kodi
eval $(grep "^PKG_VERSION" $SCRIPTPATH/../../../packages/mediacenter/$PKG_NAME/package.mk)
PKG_BASE=$PKG_VERSION

if [ ! -d .git ]; then
  echo "ERROR: current path is not a git repository"
  exit 1
fi

rm -v 00*.patch
git format-patch $PKG_BASE --no-signature

mkdir -p $SCRIPTPATH/../patches/$PKG_NAME
rm -v $SCRIPTPATH/../patches/$PKG_NAME/${PKG_NAME}-00*.patch

for f in 00*.patch; do
  mv -fv $f $SCRIPTPATH/../patches/$PKG_NAME/${PKG_NAME}-$f
done
