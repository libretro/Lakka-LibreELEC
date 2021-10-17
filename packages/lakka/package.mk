PKG_NAME="lakka"
PKG_LICENSE="GPL"
PKG_SITE="https://www.lakka.tv"
PKG_DEPENDS_TARGET="systemd lakka_update retroarch joyutils sixpair empty"
PKG_SECTION="virtual"
PKG_LONGDESC="Root package used to build libretro suite"

if [ "${DISABLE_LIBRETRO_OPTIONAL}" != "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${LIBRETRO_OPTIONAL}"
fi

if [ "${DISABLE_LIBRETRO_CORES}" != "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${LIBRETRO_CORES}"
fi

if [ "${AVAHI_DAEMON}" = yes ]; then
  PKG_DEPENDS_TARGET+=" nss-mdns"
fi

if [ "${PROJECT}" = "Generic" ]; then
  PKG_DEPENDS_TARGET+=" wii-u-gc-adapter joycond"
fi

if [ "${PROJECT}" = "L4T" ]; then
  PKG_DEPENDS_TARGET+=" L4T"
fi

if [ "${PROJECT}" = "RPi" ]; then
  PKG_DEPENDS_TARGET+=" rpi_disable_hdmi_service"
  if [ "${DEVICE}" != "GPICase" ] ; then
    PKG_DEPENDS_TARGET+=" wii-u-gc-adapter wiringPi mk_arcade_joystick_rpi joycond"
  fi
  
  if [ "${DEVICE}" = "GPICase" ]; then
    PKG_DEPENDS_TARGET+=" gpicase_safeshutdown"
  fi
fi
