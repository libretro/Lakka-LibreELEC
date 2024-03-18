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

if [ "${PROJECT}" = "RPi" ]; then
  PKG_DEPENDS_TARGET+=" rpi_disable_hdmi_service disable_wifi_powersave RPi.GPIO"
  if [ "${DEVICE}" != "GPICase" -a "${DEVICE}" != "Pi02GPi" -a "${DEVICE}" != "RPiZero2-GPiCASE2W" ] ; then
    PKG_DEPENDS_TARGET+=" wii-u-gc-adapter wiringPi mk_arcade_joystick_rpi joycond"
  fi
  
  if [ "${DEVICE}" = "GPICase" -o "${DEVICE}" = "Pi02GPi" -o "${DEVICE}" = "RPi4-GPICase2" -o "${DEVICE}" = "RPiZero2-GPiCASE2W" ]; then
    PKG_DEPENDS_TARGET+=" gpicase_safeshutdown"
    if [ "${DEVICE}" = "GPICase" -o "${DEVICE}" = "Pi02GPi" ]; then
      PKG_DEPENDS_TARGET+=" gpicase_change_audio_device"
    fi
  fi
fi

if [ "${DEVICE}" != "Switch" -a "${DEVICE}" != "GPICase" -a "${DEVICE}" != "Pi02GPi" -a "${DEVICE}" != "RPiZero2-GPiCASE2W" ]; then
  PKG_DEPENDS_TARGET+=" xbox360_controllers_shutdown"
fi

if [ "${CEC_FRAMEWORK_SUPPORT}" = yes -a ! "${PROJECT}" = "L4T" ]; then
  PKG_DEPENDS_TARGET+=" cec_mini_kb"
fi
