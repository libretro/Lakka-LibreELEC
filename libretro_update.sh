#!/bin/bash
LR_PKG_PATH="packages/lakka/libretro_cores"
RA_PKG_PATH="packages/lakka/retroarch_base"
RA_PACKAGES=" retroarch  retroarch_assets  retroarch_joypad_autoconfig  retroarch_overlays  libretro_database  core_info  glsl_shaders  slang_shaders"

usage()
{
  echo ""
  echo "$0 <--all [--exclude list] | --used [--exclude list] | --packages list>"
  echo ""
  echo "Updates PKG_VERSION in package.mk of libretro packages to latest."
  echo ""
  echo "Parameters:"
  echo " -a --all                 Update all libretro core and retroarch packages (including those not shipped)"
  echo " -u --used                Update libretro core / retroarch packages shipped with Lakka"
  echo " -r --retroarch           Update retroarch packages shipped with Lakka"
  echo " -c --cores               Update libretro core packages shipped with Lakka"
  echo " -p list --packages list  Update only listed libretro core / retroarch packages"
  echo " -e list --exclude list   Provide list of packages to exclude from update"
  echo ""
}

[ "$1" = "" ] && { usage ; exit ; }

case $1 in
  -a | --all )
    s=$1
    shift
    if [ "$1" != "" ] ; then
      case $1 in
        -e | --exclude )
          PACKAGES_EX=""
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
          ;;
        * )
          echo "Error: After $s use only --exclude (-e) to exclude some packages."
          exit 1
          ;;
      esac
    fi
    # Get list of all libretro and retroarch packages
    for p in $(cd $LR_PKG_PATH && ls) ; do
      PACKAGES_ALL+=" $p "
    done
    for p in $(cd $RA_PKG_PATH && ls) ; do
      PACKAGES_ALL+=" $p "
    done
    ;;
  -u | --used )
    s=$1
    shift
    if [ "$1" != "" ] ; then
      case $1 in
        -e | --exclude )
          PACKAGES_EX=""
          x="$1"
          shift
          v="$@"
          [ "$v" = "" ] && { echo "Error: You must provide name(s) of package(s) to exclude after $x" ; exit 1 ; }
          for a in $v ; do
            if [ -f $LR_PKG_PATH/$a/package.mk -o -f $RA_PKG_PATH/$a/package.mk ] ; then
              PACKAGES_EX+=" $a "
            else
              echo "Warning: $a is not a libretro/retroarch package - cannot exclude."
            fi
          done
          [ "$PACKAGES_EX" = "" ] && { echo "No valid packages to exclude given! Aborting." ; exit 1 ; }
          ;;
        * )
          echo "Error: After $s use only --exclude (-e) to exclude some packages."
          exit 1
          ;;
      esac
    fi
    # Get list of cores, which are shipped with Lakka:
    OPTIONS_FILE="distributions/Lakka/options"
    [ -f "$OPTIONS_FILE" ] && source "$OPTIONS_FILE" || { echo "$OPTIONS_FILE: not found! Aborting." ; exit 1 ; }
    [ -z "$LIBRETRO_CORES" ] && { echo "LIBRETRO_CORES: empty. Aborting!" ; exit 1 ; }
    # List of all libretro packages to update:
    PACKAGES_ALL=" $RA_PACKAGES $LIBRETRO_CORES "
    ;;
  -r | --retroarch )
    s=$1
    shift
    if [ "$1" != "" ] ; then
      case $1 in
        -e | --exclude )
          PACKAGES_EX=""
          x="$1"
          shift
          v="$@"
          [ "$v" = "" ] && { echo "Error: You must provide name(s) of package(s) to exclude after $x" ; exit 1 ; }
          for a in $v ; do
            if [ -f $RA_PKG_PATH/$a/package.mk ] ; then
              PACKAGES_EX+=" $a "
            else
              echo "Warning: $a is not a retroarch package - cannot exclude."
            fi
          done
          [ "$PACKAGES_EX" = "" ] && { echo "No valid packages to exclude given! Aborting." ; exit 1 ; }
          ;;
        * )
          echo "Error: After $s use only --exclude (-e) to exclude some packages."
          exit 1
          ;;
      esac
    fi
    PACKAGES_ALL=" $RA_PACKAGES "
    ;;
  -c | --cores )
    s=$1
    shift
    if [ "$1" != "" ] ; then
      case $1 in
        -e | --exclude )
          PACKAGES_EX=""
          x="$1"
          shift
          v="$@"
          [ "$v" = "" ] && { echo "Error: You must provide name(s) of package(s) to exclude after $x" ; exit 1 ; }
          for a in $v ; do
            if [ -f $LR_PKG_PATH/$a/package.mk ] ; then
              PACKAGES_EX+=" $a "
            else
              echo "Warning: $a is not a libretro core package - cannot exclude."
            fi
          done
          [ "$PACKAGES_EX" = "" ] && { echo "No valid packages to exclude given! Aborting." ; exit 1 ; }
          ;;
        * )
          echo "Error: After $s use only --exclude (-e) to exclude some packages."
          exit 1
          ;;
      esac
    fi
    # Get list of cores, which are shipped with Lakka:
    OPTIONS_FILE="distributions/Lakka/options"
    [ -f "$OPTIONS_FILE" ] && source "$OPTIONS_FILE" || { echo "$OPTIONS_FILE: not found! Aborting." ; exit 1 ; }
    [ -z "$LIBRETRO_CORES" ] && { echo "LIBRETRO_CORES: empty. Aborting!" ; exit 1 ; }
    PACKAGES_ALL=" $LIBRETRO_CORES "
    ;;
  -p | --packages )
    PACKAGES_ALL=""
    x="$1"
    shift
    v="$@"
    [ "$v" = "" ] && { echo "Error: You must provide name(s) of package(s) after $x" ; exit 1 ; }
    for a in $v ; do
      if [ -f $LR_PKG_PATH/$a/package.mk -o -f $RA_PKG_PATH/$a/package.mk ] ; then
        PACKAGES_ALL+=" $a "
      else
        echo "Warning: $a is not a libretro core / retroarch package - skipping."
      fi
    done
    [ "$PACKAGES_ALL" = "" ] && { echo "No valid packages given! Aborting." ; exit 1 ; }
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
echo "Checking following packages: "$PACKAGES_ALL
declare -i i=0
ALL_FILES=""
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
  PKG_GIT_BRANCH=`cat $f | sed -En "s/^PKG_GIT_CLONE_BRANCH=\"(.*)\"/\1/p"`
  PKG_LR_UPDATE_TAG=`cat $f | sed -En "s/^PKG_LR_UPDATE_TAG=\"(.*)\"/\1/p"`
  if [ -z "$PKG_VERSION" ] || [ -z "$PKG_SITE" ] ; then
    echo "$f: does not have PKG_VERSION or PKG_SITE"
    echo "PKG_VERSION: $PKG_VERSION"
    echo "PKG_SITE: $PKG_SITE"
    echo "Skipping update."
    continue
  fi
  UPDATE_INFO=""
  if [ -n "$PKG_GIT_BRANCH" ]; then
    GIT_HEAD="heads/$PKG_GIT_BRANCH"
    UPDATE_INFO="(branch $PKG_GIT_BRANCH"
  else
    GIT_HEAD="HEAD"
  fi
  if [ "$PKG_LR_UPDATE_TAG" = "yes" ]; then
    UPS_VERSION=`git ls-remote --sort='v:refname' --tags $PKG_SITE '*.*.*' 2>/dev/null | tail -n 1 | awk '{ print $1; }'`
    [ -z "$UPDATE_INFO" ] && UPDATE_INFO="(latest x.x.x tag" || UPDATE_INFO+=" + latest x.x.x tag"
  else
    UPS_VERSION=`git ls-remote $PKG_SITE 2>/dev/null | grep ${GIT_HEAD}$ | awk '{ print $1; }'`
  fi
  [ -n "$UPDATE_INFO" ] && UPDATE_INFO+=")"
  if [ "$UPS_VERSION" = "$PKG_VERSION" ]; then
    echo "$PKG_NAME is up to date ($UPS_VERSION) $UPDATE_INFO"
  elif [ "$UPS_VERSION" = "" ]; then
    echo "$PKG_NAME does not use git - nothing changed"
  else
    i+=1
    echo "$PKG_NAME updated from $PKG_VERSION to $UPS_VERSION $UPDATE_INFO"
    sed -i "s/$PKG_VERSION/$UPS_VERSION/" $f
  fi
done
echo "$i package(s) updated."
