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

PKG_NAME="network-tools"
PKG_VERSION=""
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="A bundle of network tools and programs"
PKG_LONGDESC="This bundle currently includes bwm-ng, iftop, iperf, irssi, iw, lftp, ncftp, ngrep, nmap, rsync, sshfs, tcpdump, udpxy and wireless_tools."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Network Tools"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES=""

PKG_AUTORECONF="no"

PKG_DEPENDS_TARGET="toolchain \
                    bwm-ng \
                    iftop \
                    iperf \
                    irssi \
                    iw \
                    lftp \
                    ncftp \
                    ngrep \
                    nmap \
                    rsync \
                    sshfs \
                    tcpdump \
                    udpxy \
                    wireless_tools"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    # bwm-ng
    cp -P $(get_build_dir bwm-ng)/.$TARGET_NAME/src/bwm-ng $ADDON_BUILD/$PKG_ADDON_ID/bin

    # iftop
    cp -P $(get_build_dir iftop)/.$TARGET_NAME/iftop $ADDON_BUILD/$PKG_ADDON_ID/bin

    # iperf
    cp -P $(get_build_dir iperf)/.$TARGET_NAME/src/iperf3 $ADDON_BUILD/$PKG_ADDON_ID/bin
    ln -s iperf3 $ADDON_BUILD/$PKG_ADDON_ID/bin/iperf

    # irssi
    cp -P $(get_build_dir irssi)/.$TARGET_NAME/src/fe-text/irssi $ADDON_BUILD/$PKG_ADDON_ID/bin

    # iw
    cp -P $(get_build_dir iw)/iw $ADDON_BUILD/$PKG_ADDON_ID/bin

    # lftp
    cp -P $(get_build_dir lftp)/.$TARGET_NAME/src/lftp $ADDON_BUILD/$PKG_ADDON_ID/bin

    # ncftp
    cp -P $(get_build_dir ncftp)/.$TARGET_NAME/bin/ncftp $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir ncftp)/.$TARGET_NAME/bin/ncftpbatch $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir ncftp)/.$TARGET_NAME/bin/ncftpget $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir ncftp)/.$TARGET_NAME/bin/ncftpls $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir ncftp)/.$TARGET_NAME/bin/ncftpput $ADDON_BUILD/$PKG_ADDON_ID/bin

    # ngrep
    cp -P $(get_build_dir ngrep)/.$TARGET_NAME/ngrep $ADDON_BUILD/$PKG_ADDON_ID/bin

    # nmap
    cp -P $(get_build_dir nmap)/nmap $ADDON_BUILD/$PKG_ADDON_ID/bin

    # rsync
    cp -P $(get_build_dir rsync)/.$TARGET_NAME/rsync $ADDON_BUILD/$PKG_ADDON_ID/bin

    # sshfs
    cp -P $(get_build_dir sshfs)/.$TARGET_NAME/sshfs $ADDON_BUILD/$PKG_ADDON_ID/bin

    # tcpdump
    cp -P $(get_build_dir tcpdump)/.$TARGET_NAME/tcpdump $ADDON_BUILD/$PKG_ADDON_ID/bin

    # udpxy
    cp -P $(get_build_dir udpxy)/udpxy $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # wireless_tools
    cp -P $(get_build_dir wireless_tools)/iwmulticall $ADDON_BUILD/$PKG_ADDON_ID/bin
    ln -s iwmulticall $ADDON_BUILD/$PKG_ADDON_ID/bin/iwconfig
    ln -s iwmulticall $ADDON_BUILD/$PKG_ADDON_ID/bin/iwgetid
    ln -s iwmulticall $ADDON_BUILD/$PKG_ADDON_ID/bin/iwlist
    ln -s iwmulticall $ADDON_BUILD/$PKG_ADDON_ID/bin/iwspy
    ln -s iwmulticall $ADDON_BUILD/$PKG_ADDON_ID/bin/iwpriv

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
