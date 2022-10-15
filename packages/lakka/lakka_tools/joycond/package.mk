PKG_NAME="joycond"
PKG_DEPENDS_TARGET="toolchain cmake:host libevdev systemd"
PKG_SITE="https://github.com/DanielOgorchock/joycond"
if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
  PKG_VERSION="031f04311a912514cea9deb020512ee6d7063398"
  PKG_SHA256="c2681b1f7723acf0e51e318be3194202e3a77627c78aa39e0a70797d0155dcba"
  PKG_URL="https://gitlab.com/switchroot/userspace/joycond/-/archive/c48187fcdacda1b139297e4944a149125e0800b2/joycond-c48187fcdacda1b139297e4944a149125e0800b2.tar.gz"
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
