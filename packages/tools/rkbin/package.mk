# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rkbin"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"


case "${DEVICE}" in
      RK3568)
        PKG_VERSION="b0c100f1a260d807df450019774993c761beb79d"
		PKG_SHA256="c6ebf8ab556e071e3b067540e95aecff650143f0c97e129cd40c837a4f11a881"
        PKG_SITE="https://github.com/rockchip-linux/rkbin"
		PKG_URL="https://github.com/rockchip-linux/rkbin/archive/${PKG_VERSION}.tar.gz"
        ;;
      *)
        PKG_VERSION="4563e249a3f47e7fcd47a4c3769b6c05683b6e9d"
		PKG_SHA256="0b3479117700bce9afea2110c1f027b626c76d99045802218b35a53606547d60"
        PKG_URL="https://github.com/rockchip-linux/rkbin/archive/${PKG_VERSION}.tar.gz"
		PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
        ;;
    esac