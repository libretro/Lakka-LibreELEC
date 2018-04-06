################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Mateusz Krzak (kszaquitto@gmail.com)
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

PKG_NAME="aml-s9xx-device-trees"
PKG_VERSION="097d287"
PKG_LICENSE="OSS"
PKG_URL="https://github.com/kszaq/s905-device-trees/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="s905-device-trees-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"

PKG_AUTORECONF="no"

EXTRA_TREES=(gxbb_p201.dtb gxl_p212_1g.dtb gxl_p212_2g.dtb gxbb_p200_1G_wetek_hub.dtb gxbb_p200_2G_wetek_play_2.dtb gxm_q200_2g.dtb gxm_q201_1g.dtb gxm_q201_2g.dtb)

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-elf:host"
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$PATH
  TARGET_PREFIX=aarch64-elf-
fi

make_target() {

  pushd $BUILD/linux-$(kernel_version) > /dev/null

  mkdir -p $TARGET_IMG

  DTB_LIST=""

  # Complete device trees
  for f in $PKG_BUILD/*.dts; do
    DTB_NAME="$(basename $f .dts).dtb"
    cp -f $f arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/
    DTB_LIST="$DTB_LIST $DTB_NAME"
  done

  # Kernel-tree trees
  for f in ${EXTRA_TREES[@]}; do
    DTB_LIST="$DTB_LIST $f"

    LE_DT_ID="${f/.dtb/}"
    SOURCE_FILE="arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$LE_DT_ID.dts"
    # Remove "le-dt-id" if exists
    sed -i "/le-dt-id/d" $SOURCE_FILE
    # Add "le-dtb-id"
    echo -e "/ {\n\tle-dt-id = \"$LE_DT_ID\";\n};" >> $SOURCE_FILE
  done

  # Compile device trees
  LDFLAGS="" make $DTB_LIST
  mv arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/*.dtb $PKG_BUILD

  popd > /dev/null
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
  cp -PR $PKG_BUILD/*.dtb $INSTALL/usr/share/bootloader
}
