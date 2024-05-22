PKG_NAME="lakka_update"
PKG_VERSION="0"
PKG_LICENSE="GPL"
PKG_LONGDESC="Shell script to wget the latest update"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v lakka-update.sh ${INSTALL}/usr/bin/lakka-update
    chmod -v +x ${INSTALL}/usr/bin/lakka-update

  if [ "${LAKKA_NIGHTLY}" = yes ]; then
    sed -e 's|^MIRROR=.*$|MIRROR=https://nightly.builds.lakka.tv/.updater|' \
        -i ${INSTALL}/usr/bin/lakka-update
  elif [ "${LAKKA_DEVBUILD}" = yes ]; then
    sed -e 's|^MIRROR=.*$|MIRROR=https://nightly.builds.lakka.tv/.devbuild|' \
        -i ${INSTALL}/usr/bin/lakka-update
  fi
}
