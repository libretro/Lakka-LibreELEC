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

PKG_NAME="dvb-tools"
PKG_VERSION=""
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="DVB-Tools: is a bundle of dvb tools and programs"
PKG_LONGDESC="This bundle currently includes dvb-apps, dvb-fe-tool, dvblast and w_scan."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="DVB Tools"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_DEPENDS_TARGET="toolchain \
                    dvb-apps \
                    dvb-fe-tool \
                    dvblast \
                    w_scan"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
    # dvb-apps
    cp -P $(get_build_dir dvb-apps)/util/dvbdate/dvbdate $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/dvbnet/dvbnet $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/dvbscan/dvbscan $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/dvbtraffic/dvbtraffic $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/femon/femon $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/scan/scan $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/szap/azap $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/szap/czap $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/szap/szap $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/szap/tzap $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $(get_build_dir dvb-apps)/util/zap/zap $ADDON_BUILD/$PKG_ADDON_ID/bin

    # dvb-de-tool
    cp -P $(get_build_dir dvb-fe-tool)/.$TARGET_NAME/utils/dvb/dvb-fe-tool $ADDON_BUILD/$PKG_ADDON_ID/bin

    # dvblast
    cp -P $(get_build_dir dvblast)/dvblast $ADDON_BUILD/$PKG_ADDON_ID/bin

    # w_scan
    cp -P $(get_build_dir w_scan)/.$TARGET_NAME/w_scan $ADDON_BUILD/$PKG_ADDON_ID/bin

  debug_strip $ADDON_BUILD/$PKG_ADDON_ID/bin
}
