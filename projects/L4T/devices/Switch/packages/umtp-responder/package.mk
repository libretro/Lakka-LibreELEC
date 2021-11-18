PKG_NAME="umtp-responder"
PKG_VERSION="e140e559edc914976e10bcab13d37a56c4c505b2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/viveris/uMTP-Responder/"
PKG_URL="https://github.com/viveris/uMTP-Responder.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Simple MTP responder for linux devices"
PKG_TOOLCHAIN="make"

make_target() {
  make
}

makeinstall_target() {
  if [ -d "${INSTALL}" ]; then
    rm -r ${INSTALL}
  fi
  mkdir -p ${INSTALL}/{usr/bin,etc/umtprd}
    cp ${PKG_BUILD}/umtprd ${INSTALL}/usr/bin/
    cp ${PKG_BUILD}/conf/umtprd.conf ${INSTALL}/etc/umtprd/
    sed -i "s/@DISTRO@/${DISTRO}/g" ${INSTALL}/etc/umtprd/umtprd.conf
}
