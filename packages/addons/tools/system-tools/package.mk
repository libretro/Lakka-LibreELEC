################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="system-tools"
PKG_VERSION=""
PKG_REV="104"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="A bundle of system tools and programs"
PKG_LONGDESC="This bundle currently includes autossh, diffutils, dtach, efibootmgr, evtest, fdupes, file, getscancodes, hddtemp, hd-idle, hid_mapper, i2c-tools, inotify-tools, jq, lm_sensors, lshw, mc, mrxvt, mtpfs, nmon, p7zip, patch, pv, screen, strace, unrar and usb-modeswitch."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="System Tools"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES=""

PKG_AUTORECONF="no"

PKG_DEPENDS_TARGET="toolchain \
                    autossh \
                    diffutils \
                    dtach \
                    efibootmgr \
                    evtest \
                    fdupes \
                    file \
                    getscancodes \
                    hddtemp \
                    hd-idle \
                    hid_mapper \
                    i2c-tools \
                    inotify-tools \
                    jq \
                    lm_sensors \
                    lshw \
                    mc \
                    mrxvt \
                    mtpfs \
                    nmon \
                    p7zip \
                    patch \
                    pv \
                    screen \
                    strace \
                    unrar \
                    usb-modeswitch"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib/
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/data/
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    # autossh
    cp -P $(get_build_dir autossh)/.$TARGET_NAME/autossh $ADDON_BUILD/$PKG_ADDON_ID/bin

    # diffutils
    cp -P $(get_build_dir diffutils)/.$TARGET_NAME/src/cmp $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir diffutils)/.$TARGET_NAME/src/diff $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir diffutils)/.$TARGET_NAME/src/diff3 $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir diffutils)/.$TARGET_NAME/src/sdiff $ADDON_BUILD/$PKG_ADDON_ID/bin

    # dtach
    cp -P $(get_build_dir dtach)/.$TARGET_NAME/dtach $ADDON_BUILD/$PKG_ADDON_ID/bin

    # efibootmgr
    cp -P $(get_build_dir efibootmgr)/src/efibootmgr/efibootmgr $ADDON_BUILD/$PKG_ADDON_ID/bin 2>/dev/null || :

    # evtest
    cp -P $(get_build_dir evtest)/.$TARGET_NAME/evtest $ADDON_BUILD/$PKG_ADDON_ID/bin

    # fdupes
    cp -P $(get_build_dir fdupes)/fdupes $ADDON_BUILD/$PKG_ADDON_ID/bin

    # file
    cp -P $(get_build_dir file)/.$TARGET_NAME/src/file $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir file)/.$TARGET_NAME/magic/magic.mgc $ADDON_BUILD/$PKG_ADDON_ID/data

    # getscancodes
    cp -P $(get_build_dir getscancodes)/getscancodes $ADDON_BUILD/$PKG_ADDON_ID/bin

    # hddtemp
    cp -P $(get_build_dir hddtemp)/.$TARGET_NAME/src/hddtemp $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir hddtemp)/debian/hddtemp.db $ADDON_BUILD/$PKG_ADDON_ID/data

    # hd-idle
    cp -P $(get_build_dir hd-idle)/hd-idle $ADDON_BUILD/$PKG_ADDON_ID/bin

    # hid_mapper
    cp -P $(get_build_dir hid_mapper)/hid_mapper $ADDON_BUILD/$PKG_ADDON_ID/bin

    # i2c-tools
    cp -P $(get_build_dir i2c-tools)/tools/i2cdetect $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir i2c-tools)/tools/i2cdump $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir i2c-tools)/tools/i2cget $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir i2c-tools)/tools/i2cset $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir i2c-tools)/py-smbus/build/lib.linux-*/smbus.so $ADDON_BUILD/$PKG_ADDON_ID/lib

    # inotify-tools
    cp -P $(get_build_dir inotify-tools)/.$TARGET_NAME/src/inotifywait $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir inotify-tools)/.$TARGET_NAME/src/inotifywatch $ADDON_BUILD/$PKG_ADDON_ID/bin

    # jq
    cp -P $(get_build_dir jq)/.$TARGET_NAME/jq $ADDON_BUILD/$PKG_ADDON_ID/bin

    # lm_sensors
    cp -P $(get_build_dir lm_sensors)/prog/sensors/sensors $ADDON_BUILD/$PKG_ADDON_ID/bin 2>/dev/null || :

    # lshw
    cp -P $(get_build_dir lshw)/src/lshw $ADDON_BUILD/$PKG_ADDON_ID/bin

    # mc
    cp -Pa $(get_build_dir mc)/.install_pkg/usr/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
    cp -Pa $(get_build_dir mc)/.install_pkg/storage/.kodi/addons/virtual.system-tools/* $ADDON_BUILD/$PKG_ADDON_ID

    # mrxvt
    cp -P $(get_build_dir mrxvt)/.$TARGET_NAME/src/mrxvt $ADDON_BUILD/$PKG_ADDON_ID/bin 2>/dev/null || :

    # mtpfs
    cp -P $(get_build_dir mtpfs)/.$TARGET_NAME/mtpfs $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # nmon
    cp -P $(get_build_dir nmon)/nmon $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # p7zip
    cp -P $(get_build_dir p7zip)/bin/7z.so $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -PR $(get_build_dir p7zip)/bin/Codecs $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir p7zip)/bin/7z $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir p7zip)/bin/7za $ADDON_BUILD/$PKG_ADDON_ID/bin

    # patch
    cp -P $(get_build_dir patch)/.$TARGET_NAME/src/patch $ADDON_BUILD/$PKG_ADDON_ID/bin

    # pv
    cp -P $(get_build_dir pv)/.$TARGET_NAME/pv $ADDON_BUILD/$PKG_ADDON_ID/bin

    # screen
    cp -P $(get_build_dir screen)/screen $ADDON_BUILD/$PKG_ADDON_ID/bin

    # strace
    cp -P $(get_build_dir strace)/.$TARGET_NAME/strace $ADDON_BUILD/$PKG_ADDON_ID/bin

    # unrar
    cp -P $(get_build_dir unrar)/unrar $ADDON_BUILD/$PKG_ADDON_ID/bin

    # usb-modeswitch
    cp -P $(get_build_dir usb-modeswitch)/usb_modeswitch $ADDON_BUILD/$PKG_ADDON_ID/bin

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
