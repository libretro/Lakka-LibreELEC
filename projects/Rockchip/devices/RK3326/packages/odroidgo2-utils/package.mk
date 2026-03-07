# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="odroidgo2-utils"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Support scripts for the ODROID-GO Advance"

post_install() {  
	enable_service odroidgoa-utils.service
}
