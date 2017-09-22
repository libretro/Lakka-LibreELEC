#!/bin/bash
FILES=packages/libretro/*/package.mk
for f in $FILES
do
  source $f
  UPS_VERSION=`git ls-remote $PKG_SITE | grep HEAD | awk '{ print substr($1,1,7) }'`
  if [ "$UPS_VERSION" == "$PKG_VERSION" ]; then
    echo "$PKG_NAME is up to date"
  else
    echo "$PKG_NAME is outdated"
    sed -i "s/$PKG_VERSION/$UPS_VERSION/" $f
  fi
done
