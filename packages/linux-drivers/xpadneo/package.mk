PKG_NAME="xpadneo"
PKG_VERSION="0.9.1"
PKG_SHA256="1f3617b0689d93877a706a52037649d6cad011cf70491b5b43da015a02312058"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/atar-axis/xpadneo"
PKG_URL="$PKG_SITE/archive/refs/tags/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Advanced Linux Driver for Xbox One Wireless Gamepad"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make -C $(kernel_path) M=$PKG_BUILD/hid-xpadneo/src modules
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/kernel/drivers/hid
    cp -v $PKG_BUILD/hid-xpadneo/src/*.ko $INSTALL/$(get_full_module_dir)/kernel/drivers/hid/

  mkdir -p $INSTALL/usr/lib/udev/rules.d
    cp -v $PKG_BUILD/hid-xpadneo/etc-udev-rules.d/*.rules $INSTALL/usr/lib/udev/rules.d/

  mkdir -p $INSTALL/usr/lib/modprobe.d
    cp -v $PKG_BUILD/hid-xpadneo/etc-modprobe.d/*.conf $INSTALL/usr/lib/modprobe.d/
    echo "options hid_xpadneo trigger_rumble_mode=2" >> $INSTALL/usr/lib/modprobe.d/xpadneo.conf
}
