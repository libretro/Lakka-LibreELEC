# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libvdpau"
PKG_VERSION="1.4"
PKG_SHA256="4258824c5a4555ef31de0a7d82b3caf19e75a16a13949f1edafc5f6fb2d33f30"
PKG_LICENSE="MIT"
PKG_SITE="https://wiki.freedesktop.org/www/Software/VDPAU/"
PKG_URL="https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/${PKG_VERSION}/libvdpau-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libX11 xorgproto libXext"
PKG_LONGDESC="VDPAU is the Video Decode and Presentation API for UNIX."

PKG_MESON_OPTS_TARGET="-Ddocumentation=false \
                       -Ddri2=true \
                       -Dmoduledir=/usr/lib/vdpau"
