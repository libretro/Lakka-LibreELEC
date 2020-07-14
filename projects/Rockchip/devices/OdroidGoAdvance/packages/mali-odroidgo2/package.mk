# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mali-odroidgo2"
PKG_VERSION="f226e982386287a4df669e2832d9ddd613d4153b"
PKG_SHA256="cec41b7383b64fbb9fee891c9bcfaa979cb8d8b943d131a471c7fac7e16b393e"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/libmali"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_LONGDESC="The Mali GPU library used in Rockchip Platform for Odroidgo Advance"

post_makeinstall_target() {
	# remove all the extra blobs, we only need one
	rm -rf $INSTALL/usr
	
	mkdir -p $INSTALL/usr/lib/
	cp $PKG_BUILD/lib/arm-linux-gnueabihf/libmali-bifrost-g31-rxp0-gbm.so $INSTALL/usr/lib/libmali.so

	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libEGL.so
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libEGL.so.1
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libgbm.so
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libGLESv2.so
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libGLESv2.so.2
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libGLESv3.so
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libGLESv3.so.3
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libGLESv1_CM.so.1
	ln -sf /usr/lib/libmali.so $INSTALL/usr/lib/libGLES_CM.so.1

	cp -pr $PKG_BUILD/include $SYSROOT_PREFIX/usr
	cp $PKG_BUILD/include/gbm.h $SYSROOT_PREFIX/usr/include/gbm.h
	
	mkdir -p $SYSROOT_PREFIX/usr/lib
	cp -PR $PKG_BUILD/lib/arm-linux-gnueabihf/libmali-bifrost-g31-rxp0-gbm.so $SYSROOT_PREFIX/usr/lib/libmali.so

	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libEGL.so
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libEGL.so.1
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libgbm.so
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv3.so
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv3.so.3
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1
	ln -sf $SYSROOT_PREFIX/usr/lib/libmali.so $SYSROOT_PREFIX/usr/lib/libGLES_CM.so.1
}
