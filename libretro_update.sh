#!/bin/bash
LR_PKG_PATH="packages/lakka/libretro_cores"
RA_PKG_PATH="packages/lakka/retroarch_base"
PACKAGES_ALL=""
PACKAGES_EX=""
PACKAGES_UP=""
ALL_FILES=""

usage()
{
  echo ""
  echo "$0 <--all [--exclude list] | --used [--exclude list] | --packages list>"
  echo ""
  echo "Updates PKG_VERSION in package.mk of libretro and RetroArch packages to latest."
  echo ""
  echo "Parameters:"
  echo " -a --all                 Update libretro and RetroArch packages"
  echo " -c --cores               Update libretro packages shipped"
  echo " -r --retroarch           Update RetroArch packages"
  echo " -p list --packages list  Update only listed libretro / RetroArch packages"
  echo " -e list --exclude list   Provide list of packages to exclude from update"
  echo ""
}

get_lr_packages()
{
  for p in $(cd $LR_PKG_PATH && ls -d */) ; do
    PACKAGES_ALL+=" ${p//\//} "
  done
}

get_ra_packages()
{
  for p in $(cd $RA_PKG_PATH && ls -d */) ; do
    PACKAGES_ALL+=" ${p//\//} "
  done
}

get_ex_packages()
{
  x="$1"
  shift
  v="$@"
  [ "$v" = "" ] && { echo "Error: You must provide name(s) of package(s) to exclude after $x" ; exit 1 ; }
  for a in $v ; do
    if [ -f $LR_PKG_PATH/$a/package.mk -o -f $RA_PKG_PATH/$a/package.mk ] ; then
      PACKAGES_EX+=" $a "
    else
      echo "Warning: $a is not a libretro package."
    fi
  done
  [ "$PACKAGES_EX" = "" ] && { echo "No valid packages to exclude given! Aborting." ; exit 1 ; }
}

get_single_packages()
{
  x="$1"
  shift
  v="$@"
  [ "$v" = "" ] && { echo "Error: You must provide name(s) of package(s) after $x" ; exit 1 ; }
  for a in $v ; do
    if [ -f $LR_PKG_PATH/$a/package.mk -o -f $RA_PKG_PATH/$a/package.mk ] ; then
      PACKAGES_ALL+=" $a "
    else
      echo "Warning: $a is not a libretro / RetroArch package - skipping."
    fi
  done
  [ "$PACKAGES_ALL" = "" ] && { echo "No valid packages given! Aborting." ; exit 1 ; }
}

[ "$1" = "" ] && { usage ; exit ; }

case $1 in
  -a | --all )
    s=$1
    shift
    if [ "$1" != "" ] ; then
      case $1 in
        -e | --exclude )
          get_ex_packages $@
          ;;
        * )
          echo "Error: After $s use only --exclude (-e) to exclude some packages."
          exit 1
          ;;
      esac
    fi
    # Get list of all libretro and RetroArch packages
    get_lr_packages
    get_ra_packages
    ;;

  -r | --retroarch )
    s=$1
    shift
    if [ "$1" != "" ] ; then
      case $1 in
        -e | --exclude )
          get_ex_packages $@
          ;;
        * )
          echo "Error: After $s use only --exclude (-e) to exclude some packages."
          exit 1
          ;;
      esac
    fi
    # Get list of all RetroArch packages
    get_ra_packages
    ;;

  -c | --cores )
    s=$1
    shift
    if [ "$1" != "" ] ; then
      case $1 in
        -e | --exclude )
          get_ex_packages $@
          ;;
        * )
          echo "Error: After $s use only --exclude (-e) to exclude some packages."
          exit 1
          ;;
      esac
    fi
    # Get list of all libretro packages
    get_lr_packages
    ;;

  -p | --packages )
    get_single_packages $@
    ;;

  -e | --exclude )
    usage
    echo "Use $1 after -a/--all, -c/--cores or -r/--retroarch"
    exit 1
    ;;

  * )
    usage
    echo "Unknown parameter: $1"
    exit 1
    ;;
esac

if [ "$PACKAGES_EX" != "" ] ; then
  for a in $PACKAGES_EX ; do
    PACKAGES_ALL="${PACKAGES_ALL// $a /}"
  done
fi

[ -z "$(echo $PACKAGES_ALL)" ] && { echo "No packages to udpate." ; exit 1 ; }

echo "Checking following packages: $(echo $PACKAGES_ALL)"

declare -i i=0

for p in $PACKAGES_ALL
do
  f1=$LR_PKG_PATH/$p/package.mk
  f2=$RA_PKG_PATH/$p/package.mk

  if [ -f "$f1" ] ; then
    ALL_FILES+="$f1 "
  elif [ -f "$f2" ] ; then
    ALL_FILES+="$f2 "
  else
    echo "Neither '$f1' nor '$f2' found! Will be skipped."
    continue
  fi

done

for f in $ALL_FILES ; do
  PKG_VERSION=`cat $f | sed -En "s/^PKG_VERSION=\"(.*)\"/\1/p"`
  PKG_SITE=`cat $f | sed -En "s/^PKG_SITE=\"(.*)\"/\1/p"`
  PKG_NAME=`cat $f | sed -En "s/^PKG_NAME=\"(.*)\"/\1/p"`
  PKG_GIT_CLONE_BRANCH=`cat $f | sed -En "s/^PKG_GIT_CLONE_BRANCH=\"(.*)\"/\1/p"`
  PKG_LR_UPDATE_TAG=`cat $f | sed -En "s/^PKG_LR_UPDATE_TAG=\"(.*)\"/\1/p"`
  PKG_LR_UPDATE_TAG_MASK=`cat $f | sed -En "s/^PKG_LR_UPDATE_TAG_MASK=\"(.*)\"/\1/p"`

  if [ -z "$PKG_VERSION" ] || [ -z "$PKG_SITE" ] ; then
    echo "$f: does not have PKG_VERSION or PKG_SITE"
    echo "PKG_VERSION: $PKG_VERSION"
    echo "PKG_SITE: $PKG_SITE"
    echo "Skipping update."
    continue
  fi

  if [ -n "$PKG_GIT_CLONE_BRANCH" -a "$PKG_LR_UPDATE_TAG" = "yes" ]; then
    echo "$f: WARNING: both PKG_GIT_CLONE_BRANCH and PKG_LR_UPDATE_TAG are set! Skipping update."
    continue
  fi

  UPDATE_INFO=""

  if [ -n "$PKG_GIT_CLONE_BRANCH" ]; then
    GIT_HEAD="heads/$PKG_GIT_CLONE_BRANCH"
    UPDATE_INFO="(branch $PKG_GIT_CLONE_BRANCH)"
  else
    GIT_HEAD="HEAD"
  fi

  if [ "$PKG_LR_UPDATE_TAG" = "yes" ]; then
    if [ -n "${PKG_LR_UPDATE_TAG_MASK}" ]; then
      TAG=`git ls-remote --tags $PKG_SITE "${PKG_LR_UPDATE_TAG_MASK}" 2>/dev/null | cut --delimiter='/' --fields=3 | cut --delimiter='^' --fields=1 | sort --version-sort | tail --lines=1`
    else
      TAG=`git ls-remote --tags $PKG_SITE 2>/dev/null | cut --delimiter='/' --fields=3 | cut --delimiter='^' --fields=1 | sort --version-sort | tail --lines=1`
    fi
    UPS_VERSION=`git ls-remote --tags $PKG_SITE 2>/dev/null | grep refs/tags/$TAG | tail --lines=1 | awk '{ print $1; }'`
    UPDATE_INFO="(latest tag - $TAG)"
  else
    UPS_VERSION=`git ls-remote $PKG_SITE 2>/dev/null | grep ${GIT_HEAD}$ | awk '{ print $1; }'`
  fi

  if [ "$UPS_VERSION" = "$PKG_VERSION" ]; then
    echo "$PKG_NAME is up to date ($UPS_VERSION) $UPDATE_INFO"
  elif [ "$UPS_VERSION" = "" ]; then
    echo "$PKG_NAME does not use git - nothing changed"
  else
    i+=1
    PACKAGES_UP+=" $PKG_NAME"
    echo "$PKG_NAME updated from $PKG_VERSION to $UPS_VERSION $UPDATE_INFO"
    sed -i "s/$PKG_VERSION/$UPS_VERSION/" $f
  fi

done

if [ $i -eq 0 ]; then
  echo "No packages updated."
else
  echo "$i package(s) updated:"
  echo $PACKAGES_UP
fi
