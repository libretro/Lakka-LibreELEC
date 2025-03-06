PKG_NAME="lakka"
PKG_LICENSE="GPL"
PKG_SITE="https://www.lakka.tv"
PKG_DEPENDS_TARGET="systemd lakka_update retroarch joyutils sixpair empty retrorama_theme_xmb"
PKG_SECTION="virtual"
PKG_LONGDESC="Root package used to build libretro suite"

if [ "${DISABLE_LIBRETRO_OPTIONAL}" != "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${LIBRETRO_OPTIONAL}"
fi

if [ "${DISABLE_LIBRETRO_CORES}" != "yes" ]; then
  PKG_DEPENDS_TARGET+=" libretro_cores"
fi

if [ "${SAMBA_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" samba"
fi

if [ "${AVAHI_DAEMON}" = yes ]; then
  PKG_DEPENDS_TARGET+=" avahi nss-mdns"
fi

if [ "${PROJECT}" = "Generic" ]; then
  PKG_DEPENDS_TARGET+=" wii-u-gc-adapter joycond"
fi

if [ "${PROJECT}" = "RPi" ]; then
  PKG_DEPENDS_TARGET+=" rpi_disable_hdmi_service disable_wifi_powersave lg-gpio"
  if [ "${DEVICE}" != "RPiZero-GPiCase" -a "${DEVICE}" != "RPiZero2-GPiCase" ] ; then
    PKG_DEPENDS_TARGET+=" wii-u-gc-adapter wiringPi mk_arcade_joystick_rpi joycond"
  fi
  
  if [ "${DEVICE}" = "RPiZero-GPiCase" -o "${DEVICE}" = "RPiZero2-GPiCase" -o "${DEVICE}" = "RPi4-GPiCase2" -o "${DEVICE}" = "RPiZero2-GPiCase2W" ]; then
    PKG_DEPENDS_TARGET+=" gpicase_safeshutdown"
  fi
  
  if [ "${DEVICE}" = "RPi3" -o "${DEVICE}" = "RPi4" -o "${DEVICE}" = "RPi5" ]; then
    PKG_DEPENDS_TARGET+=" retroflag_picase_safeshutdown"
  fi
fi

if [ "${DEVICE}" != "Switch" -a "${DEVICE}" != "RPiZero-GPiCase" -a "${DEVICE}" != "RPiZero2-GPiCase" -a "${DEVICE}" != "RPiZero2-GPiCase2W" ]; then
  PKG_DEPENDS_TARGET+=" xbox360_controllers_shutdown"
fi

if [ "${CEC_FRAMEWORK_SUPPORT}" = yes -a ! "${PROJECT}" = "L4T" ]; then
  PKG_DEPENDS_TARGET+=" cec_mini_kb"
fi
