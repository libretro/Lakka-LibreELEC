# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mali-odroidgo2"
PKG_VERSION="c3b4a820e1cfd8e049c5321808c29713c25e2cd0"
PKG_SHA256="0594dbcd730ba04cd64b87a1e66c21adcebcf98629a81c2267ddb718fc7fe875"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/libmali"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_LONGDESC="The Mali GPU library used in Rockchip Platform for Odroidgo Advance"

post_makeinstall_target() {
	# remove all the extra blobs, we only need one
	rm -rf $INSTALL/usr

	if [ "$ARCH" == "arm" ]; then
		MALI_BLOB="libmali-rk3326-gbm_arm32_r13p0_with_vulkan_and_cl.so"
	else
		MALI_BLOB="libmali-rk3326-gbm_arm64_r13p0_with_vulkan_and_cl.so"
	fi

	mkdir -p $INSTALL/usr/lib/
	cp $PKG_BUILD/$MALI_BLOB $INSTALL/usr/lib/libmali.so.1.9.0

	ln -sf libmali.so.1.9.0 $INSTALL/usr/lib/libmali.so.1
	ln -sf libmali.so.1.9.0 $INSTALL/usr/lib/libmali.so

	ln -sf libmali.so $INSTALL/usr/lib/libEGL.so
	ln -sf libmali.so $INSTALL/usr/lib/libEGL.so.1
	ln -sf libmali.so $INSTALL/usr/lib/libgbm.so
	ln -sf libmali.so $INSTALL/usr/lib/libGLESv2.so
	ln -sf libmali.so $INSTALL/usr/lib/libGLESv2.so.2
	ln -sf libmali.so $INSTALL/usr/lib/libGLESv3.so
	ln -sf libmali.so $INSTALL/usr/lib/libGLESv3.so.3
	ln -sf libmali.so $INSTALL/usr/lib/libGLESv1_CM.so.1
	ln -sf libmali.so $INSTALL/usr/lib/libGLES_CM.so.1

	cp -pr $PKG_BUILD/include $SYSROOT_PREFIX/usr
	cp $PKG_BUILD/include/GBM/gbm.h $SYSROOT_PREFIX/usr/include/gbm.h
	# This can be removed depending on the Mesa version at use
	cp $PKG_BUILD/include/KHR/mali_khrplatform.h $SYSROOT_PREFIX/usr/include/KHR/khrplatform.h
	
	mkdir -p $SYSROOT_PREFIX/usr/lib
	cp -PR $PKG_BUILD/$MALI_BLOB $SYSROOT_PREFIX/usr/lib/libmali.so

	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libEGL.so
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libEGL.so.1
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libgbm.so
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv3.so
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv3.so.3
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1
	ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLES_CM.so.1
}
