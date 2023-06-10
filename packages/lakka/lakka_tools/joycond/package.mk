PKG_NAME="joycond"
PKG_DEPENDS_TARGET="toolchain cmake:host libevdev systemd"
PKG_SITE="https://github.com/DanielOgorchock/joycond"
if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
  PKG_VERSION="2bcdbed65b4829d9bb359bff7db4df3b822dc7a1"
  PKG_SHA256="9bafe7867dad22394e0133ef4fd828932891d50271aabbd03b49374496cdec0b"
  PKG_URL="https://gitlab.com/switchroot/userspace/joycond/-/archive/2bcdbed65b4829d9bb359bff7db4df3b822dc7a1/joycond-2bcdbed65b4829d9bb359bff7db4df3b822dc7a1.tar.gz"
else
  PKG_VERSION="2d3f553060291f1bfee2e49fc2ca4a768b289df8"
  PKG_SHA256="34ba2a4ffd35f2b2bbebd8ce47d17f2238d991bc6262653d0617b28f864e4b63"
  PKG_URL="https://github.com/DanielOgorchock/joycond/archive/${PKG_VERSION}.tar.gz"
fi
PKG_LONGDESC="Joycon service"

PKG_TOOLCHAIN="cmake-make"

post_makeinstall_target() {
  rm -r ${INSTALL}/etc/modules-load.d
  mv -v ${INSTALL}/lib/* ${INSTALL}/usr/lib/ && rmdir ${INSTALL}/lib
  mv -v ${INSTALL}/etc/systemd ${INSTALL}/usr/lib/systemd
  mkdir -p ${INSTALL}/usr/lib/udev
    mv -v ${INSTALL}/usr/lib/rules.d ${INSTALL}/usr/lib/udev/
  sed -e 's|^WorkingDirectory=.*$|WorkingDirectory=/var|g' \
      -i ${INSTALL}/usr/lib/systemd/system/joycond.service
}

post_install() {
  enable_service joycond.service
}
