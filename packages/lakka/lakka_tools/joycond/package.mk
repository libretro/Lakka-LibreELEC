PKG_NAME="joycond"
PKG_DEPENDS_TARGET="toolchain cmake:host libevdev systemd"
PKG_SITE="https://github.com/DanielOgorchock/joycond"
if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
  PKG_VERSION="c83539a8995040e8daf6912dab32a11082e75acf"
  PKG_SHA256="10b043f226e49b17f1025ded37257ca096ed9fac5f22bbe91cd12cd6e7882835"
  PKG_URL="https://gitlab.com/switchroot/userspace/joycond/-/archive/linux/joycond-linux.tar.gz"
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
