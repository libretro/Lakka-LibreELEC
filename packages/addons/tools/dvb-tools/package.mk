# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvb-tools"
PKG_VERSION="1.0"
PKG_REV="105"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_SHORTDESC="DVB-Tools: is a bundle of dvb tools and programs"
PKG_LONGDESC="This bundle currently includes blindscan-s2, dvb-apps, dvblast, dvbsnoop, mumudvb, szap-s2, tune-s2, t2scan and w_scan."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="DVB Tools"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_DEPENDS_TARGET="toolchain \
                    blindscan-s2 \
                    dvb-apps \
                    dvblast \
                    dvbsnoop \
                    mumudvb \
                    szap-s2 \
                    tune-s2 \
                    t2scan \
                    w_scan"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/

    # blindscan-s2
    cp -P $(get_build_dir blindscan-s2)/blindscan-s2 $ADDON_BUILD/$PKG_ADDON_ID/bin

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

    # dvblast
    cp -P $(get_build_dir dvblast)/dvblast $ADDON_BUILD/$PKG_ADDON_ID/bin

    # dvbsnoop
    cp -P $(get_build_dir dvbsnoop)/.$TARGET_NAME/src/dvbsnoop $ADDON_BUILD/$PKG_ADDON_ID/bin

    # mumudvb
    cp -P $(get_build_dir mumudvb)/.$TARGET_NAME/src/mumudvb $ADDON_BUILD/$PKG_ADDON_ID/bin

    # szap-s2
    cp -P $(get_build_dir szap-s2)/szap-s2 $ADDON_BUILD/$PKG_ADDON_ID/bin

    # tune-s2
    cp -P $(get_build_dir tune-s2)/tune-s2 $ADDON_BUILD/$PKG_ADDON_ID/bin

    # t2scan
    cp -P $(get_build_dir t2scan)/.$TARGET_NAME/t2scan $ADDON_BUILD/$PKG_ADDON_ID/bin

    # w_scan
    cp -P $(get_build_dir w_scan)/.$TARGET_NAME/w_scan $ADDON_BUILD/$PKG_ADDON_ID/bin
}
