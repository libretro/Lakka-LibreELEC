#!/bin/bash
FILES=packages/libretro/*/package.mk
for f in $FILES
do
  PKG_VERSION=`cat $f | sed -En "s/PKG_VERSION=\"(.*)\"/\1/p"`
  PKG_SITE=`cat $f | sed -En "s/PKG_SITE=\"(.*)\"/\1/p"`
  PKG_NAME=`cat $f | sed -En "s/PKG_NAME=\"(.*)\"/\1/p"`
  if [ -z "$PKG_VERSION" ] || [ -z "$PKG_SITE" ] ; then
    echo "$f: does not have PKG_VERSION or PKG_SITE"
    echo "PKG_VERSION: $PKG_VERSION"
    echo "PKG_SITE: $PKG_SITE"
    echo "Skipping update."
    continue
  fi
  UPS_VERSION=`git ls-remote $PKG_SITE | grep HEAD | awk '{ print substr($1,1,7) }'`
  if [ "$UPS_VERSION" == "$PKG_VERSION" ]; then
    echo "$PKG_NAME is up to date (local: $PKG_VERSION / remote: $UPS_VERSION)"
  else
  echo "$PKG_NAME is outdated (local: $PKG_VERSION / remote: $UPS_VERSION)"
    sed -i "s/$PKG_VERSION/$UPS_VERSION/" $f
  fi
done
