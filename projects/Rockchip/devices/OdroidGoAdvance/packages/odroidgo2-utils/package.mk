# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="odroidgo2-utils"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain evtest"
PKG_LONGDESC="Support scripts for the ODROID-GO Advance"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
	mkdir -p $INSTALL/usr/bin
	cp $(get_build_dir evtest)/.${TARGET_NAME}/evtest $INSTALL/usr/bin
	cp headphone_sense.sh $INSTALL/usr/bin
}

post_install() {  
	enable_service odroidgoa-utils.service
}
