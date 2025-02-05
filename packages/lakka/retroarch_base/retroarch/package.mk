PKG_NAME="retroarch"
PKG_VERSION="ab3b175848fa6cd8b2340809631e30bc0fe1d136"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain freetype zlib ffmpeg libass libvdpau libxkbcommon glsl_shaders slang_shaders systemd libpng fontconfig"
PKG_LONGDESC="Reference frontend for the libretro API."
PKG_LR_UPDATE_TAG="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-vg \
                           --disable-sdl \
                           --disable-sdl2 \
                           --disable-ssl \
                           --enable-zlib \
                           --enable-freetype \
                           --enable-translate \
                           --enable-cdrom \
                           --enable-command \
                           --enable-kms \
                           --enable-egl \
                           --enable-ssl \
                           --enable-builtinmbedtls \
                           --datarootdir=${SYSROOT_PREFIX}/usr/share" # don't use host /usr/share!

PKG_MAKE_OPTS_TARGET="V=1 \
                      HAVE_LAKKA=1 \
                      HAVE_LAKKA_PROJECT="${DEVICE:-${PROJECT}}.${ARCH}" \
                      HAVE_LAKKA_SERVER="${LAKKA_UPDATE_SERVER_URL}" \
                      HAVE_CHEEVOS=1 \
                      HAVE_HAVE_ZARCH=0 \
                      HAVE_WIFI=1 \
                      HAVE_BLUETOOTH=1 \
                      HAVE_CLOUDSYNC=1 \
                      HAVE_SSL=1 \
                      HAVE_BUILTINMBEDTLS=1 \
                      HAVE_FREETYPE=1"

if [ "${PROJECT}" = "RPi" ]; then
  if [ "${DEVICE}" = "RPi3" -o "${DEVICE}" = "RPi4" -o "${DEVICE}" = "RPi5" -o "${DEVICE: -10}" = "-Composite" ]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_RETROFLAG=1"
  fi
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles"
  if [ "${DEVICE:0:4}" =  "RPi4" ] || [ "${DEVICE:0:4}" = "RPi5" ] || [ "${DEVICE}" = "RK3288" ] || [ "${DEVICE}" = "RK3399" ] || [ "${PROJECT}" = "Generic" ] || [ "${DEVICE}" = "Odin" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles3 \
                                 --enable-opengles3_1"
    if [ "${PROJECT}" = "Generic" ]; then
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles3_2"
    fi
  fi
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-opengles"
fi

if [ "${OPENGL_SUPPORT}" = yes -a ! "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengl"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL1=1"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-opengl"
fi

if [ "${VULKAN_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_VULKAN=1"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-vulkan"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-vulkan"
fi

if [ "${DISPLAYSERVER}" != "no" ]; then
  PKG_DEPENDS_TARGET+=" ${DISPLAYSERVER}"
fi

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libXxf86vm"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-x11 --enable-xinerama"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-x11"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
  PKG_MAKE_OPTS_TARGET+=" HAVE_WAYLAND=1"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-wayland"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-wayland"
fi

if [ "${PULSEAUDIO_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-pulse"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-pulse"
fi

if [ "${ALSA_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" alsa-lib"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-alsa"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-alsa"
fi

if [[ "${TARGET_FPU}" =~ "neon" ]]; then
  if [ "${ARCH}" = "arm" ]; then
    PKG_CONFIGURE_OPTS+=" --enable-neon"
  fi
fi

if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
  PKG_DEPENDS_TARGET+=" librga"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-odroidgo2"
fi

if [ "${OPENGLES}" = "bcm2835-driver" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-videocore --enable-dispmanx"
  PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-kms/--disable-kms}
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-videocore"
fi

if [ "${PROJECT}" = "L4T" ]; then
  PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-kms/--disable-kms}
  #EGL break gl1 support so if opengl enabled, force disable egl/gles
  if [ "${OPENGL_SUPPORT}" = yes ]; then
    PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-egl/--disable-egl}
    PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-opengles3_1/}
    PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-opengles3_2/}
    PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-opengles3/}
    PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-opengles/}
  fi

  if [ "${DEVICE}" = "Switch" ]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_LAKKA_SWITCH=1"
  fi
fi

pre_configure_target() {
  TARGET_CONFIGURE_OPTS=""
  cd ${PKG_BUILD}
}

pre_make_target() {
  if [ "${OPENGLES}" = "bcm2835-driver" ]; then
    CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
              -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
  fi
  CFLAGS=${CFLAGS/"-Os"/"-O2"}
  CFLAGS=${CFLAGS/"-O3"/"-O2"}
}

make_target() {
  make ${PKG_MAKE_OPTS_TARGET}
  make -C gfx/video_filters compiler=${CC} extra_flags="${CFLAGS}"
  make -C libretro-common/audio/dsp_filters compiler=${CC} extra_flags="${CFLAGS}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_BUILD}/retroarch ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/lakka-*.sh ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/share/video_filters
    cp -v ${PKG_BUILD}/gfx/video_filters/*.so ${INSTALL}/usr/share/video_filters
    cp -v ${PKG_BUILD}/gfx/video_filters/*.filt ${INSTALL}/usr/share/video_filters
  mkdir -p ${INSTALL}/usr/share/audio_filters
    cp -v ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.so ${INSTALL}/usr/share/audio_filters
    cp -v ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.dsp ${INSTALL}/usr/share/audio_filters
  mkdir -p ${INSTALL}/usr/lib/retroarch
    cp -v ${PKG_DIR}/scripts/retroarch-config ${INSTALL}/usr/lib/retroarch

  # System overlay
  mkdir -p ${INSTALL}/usr/share/retroarch/system
    touch ${INSTALL}/usr/share/retroarch/system/.placeholder

  # General configuration
  local ra_config=${INSTALL}/etc/retroarch.cfg
  mkdir -p ${INSTALL}/etc
    cp ${PKG_DIR}/config/retroarch.cfg ${ra_config}

  # Power settings
  # Use ondemand for all RPi devices (for backwards compatibility?)
  # and any battery powered device (OGA and RPi case)
  if [ "${PROJECT}" = "RPi" ] || [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    sed -i ${ra_config} -e 's|^cpu_main_gov = .*|cpu_main_gov = "ondemand"|'
    sed -i ${ra_config} -e 's|^cpu_menu_gov = .*|cpu_menu_gov = "ondemand"|'
    sed -i ${ra_config} -e 's|^cpu_scaling_mode = .*|cpu_scaling_mode = "1"|'
  fi

  if [ "${PROJECT}" = "Samsung" -a "${DEVICE}" = "Exynos" ]; then
    # workaround the 55fps bug
    sed -i ${ra_config} -e 's|^audio_out_rate = .*|audio_out_rate = "44100"|'
  fi

  # OdroidGoAdvance
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    sed -i ${ra_config} -e 's|^xmb_layout = .*|xmb_layout = "2"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_auto = .*|menu_widget_scale_auto = "false"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_factor = .*|menu_widget_scale_factor = "2.250000"|'
  fi

  # RPiZero/RPiZero2 + GPiCase (1st Gen Retroflag GPiCase)
  if [ "${DEVICE}" = "RPiZero-GPiCase" -o "${DEVICE}" = "RPiZero2-GPiCase" ]; then
    sed -i ${ra_config} -e 's|^input_menu_toggle_gamepad_combo = .*|input_menu_toggle_gamepad_combo = "4"|'
    sed -i ${ra_config} -e 's|^menu_driver = .*|menu_driver = "rgui"|'
    sed -i ${ra_config} -e 's|^aspect_ratio_index = .*|aspect_ratio_index = "21"|'
    sed -i ${ra_config} -e 's|^audio_device = .*|audio_device = "default:CARD=Headphones"|'
    sed -i ${ra_config} -e 's|^audio_out_rate = .*|audio_out_rate = "44100"|'
    sed -i ${ra_config} -e 's|^menu_enable_widgets = .*|menu_enable_widgets = "false"|'
    sed -i ${ra_config} -e 's|^menu_timedate_enable = .*|menu_timedate_enable = "false"|'
    sed -i ${ra_config} -e 's|^video_font_size = .*|video_font_size = "16.000000"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_auto = .*|menu_widget_scale_auto = "false"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_factor = .*|menu_widget_scale_factor = "1.750000"|'

    if [ "${DEVICE}" = "RPiZero-GPiCase" ]; then
      sed -i ${ra_config} -e 's|^video_threaded = .*|video_threaded = "false"|'
      sed -i ${ra_config} -e 's|^video_scale_integer = .*|video_scale_integer = "true"|'
    fi

    if [ "${DEVICE}" = "RPiZero2-GPiCase" ]; then
      sed -i ${ra_config} -e 's|^input_player1_analog_dpad_mode = .*|input_player1_analog_dpad_mode = "3"|'
    fi
  fi

  # RPi Compute Module 4 + GPiCase2 (2nd Gen Retroflag GPiCase)
  if [ "${DEVICE}" = "RPi4-GPiCase2" ]; then
    sed -i ${ra_config} -e 's|^audio_device = .*|audio_device = "default:CARD=Device"|'
    sed -i ${ra_config} -e 's|^audio_out_rate = .*|audio_out_rate = "44100"|'
    sed -i ${ra_config} -e 's|^xmb_layout = .*|xmb_layout = "2"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_auto = .*|menu_widget_scale_auto = "false"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_factor = .*|menu_widget_scale_factor = "1.750000"|'
  fi

  # RPiZero2 + GPiCase2W (3rd Gen Retroflag GPiCase)
  if [ "${DEVICE}" = "RPiZero2-GPiCase2W" ]; then
    sed -i ${ra_config} -e 's|^audio_device = .*|audio_device = "default:CARD=Headphone"|'
    sed -i ${ra_config} -e 's|^audio_out_rate = .*|audio_out_rate = "44100"|'
    sed -i ${ra_config} -e 's|^xmb_layout = .*|xmb_layout = "2"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_auto = .*|menu_widget_scale_auto = "false"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_factor = .*|menu_widget_scale_factor = "1.750000"|'
  fi

  # PiBoy DMG / RetroDreamer
  if [ "${DEVICE}" = "RPi4-PiBoyDmg" -o "${DEVICE}" = "RPi4-RetroDreamer" ]; then
    sed -i ${ra_config} -e 's|^menu_timedate_enable = .*|menu_timedate_enable = "false"|'
    sed -i ${ra_config} -e 's|^menu_scale_factor = .*|menu_scale_factor = "1.440000"|'
    sed -i ${ra_config} -e 's|^input_menu_toggle_gamepad_combo = .*|input_menu_toggle_gamepad_combo = "4"|'
    sed -i ${ra_config} -e 's|^menu_driver = .*|menu_driver = "ozone"|'
  fi

  # RPi-Composite
  if [ "${PROJECT}" = "RPi" -a "${DEVICE: -10}" = "-Composite" ]; then
    # copy font
    mkdir -p ${INSTALL}/usr/share/retroarch/assets
      cp -rv ${PKG_DIR}/files-composite/assets/* ${INSTALL}/usr/share/retroarch/assets
    # copy shaders
    mkdir -p ${INSTALL}/usr/share/retroarch/shaders
      cp -rv ${PKG_DIR}/files-composite/shaders/* ${INSTALL}/usr/share/retroarch/shaders
      # keep only relevant shader presets and shaders
      if [ "${DEVICE:0:4}" = "RPi5" ]; then
        rm -v ${INSTALL}/usr/share/retroarch/shaders/RPi-Composite/rpi3-4.{glslp,slangp}
        rm -v ${INSTALL}/usr/share/retroarch/shaders/RPi-Composite/shaders/rpi3-4-composite-mmgb-vudiq.{glsl,slang}
      else
        rm -v ${INSTALL}/usr/share/retroarch/shaders/RPi-Composite/rpi5.{glslp,slangp}
        rm -v ${INSTALL}/usr/share/retroarch/shaders/RPi-Composite/shaders/rpi5-composite-mmgb-vudiq.{glsl,slang}
      fi
    # copy global shader presets
    mkdir -p ${INSTALL}/etc/retroarch/config
    if [ "${DEVICE:0:4}" = "RPi5" ]; then
      cp -v ${PKG_DIR}/files-composite/global-rpi5.glslp ${INSTALL}/etc/retroarch/config/global.glslp
      cp -v ${PKG_DIR}/files-composite/global-rpi5.slangp ${INSTALL}/etc/retroarch/config/global.slangp
    else
      cp -v ${PKG_DIR}/files-composite/global-rpi34.glslp ${INSTALL}/etc/retroarch/config/global.glslp
      cp -v ${PKG_DIR}/files-composite/global-rpi34.slangp ${INSTALL}/etc/retroarch/config/global.slangp
    fi
    # extract core configs
    unzip ${PKG_DIR}/files-composite/config/core_configs.zip -d ${INSTALL}/etc/retroarch/config
    # set dynamic recompiler on RPi3/4 for Mupen64plus-next
    if [ "${DEVICE:0:4}" != "RPi5" ]; then
      sed -i ${INSTALL}/etc/retroarch/config/Mupen64Plus-Next/Mupen64Plus-Next.opt \
          -e 's|^mupen64plus-cpucore = .*|mupen64plus-cpucore = "dynamic_recompiler"|'
    fi
    # use specific font for composite
    sed -i ${ra_config} -e 's|^xmb_font = .*|xmb_font = "/tmp/assets/xmb/xmb_pixel_mmgb.ttf"|'
    sed -i ${ra_config} -e 's|^video_font_path = .*|video_font_path = "/tmp/assets/xmb/xmb_pixel_mmgb.ttf"|'
    # offset the xmb title to be within visible screen area
    sed -i ${ra_config} -e 's|^menu_xmb_title_margin = .*|menu_xmb_title_margin = "8"|'
    sed -i ${ra_config} -e 's|^menu_xmb_title_margin_horizontal_offset = .*|menu_xmb_title_margin_horizontal_offset = "3"|'
    # show advanced settings
    sed -i ${ra_config} -e 's|^menu_show_advanced_settings = .*|menu_show_advanced_settings = "true"|'
    # show save core/game overrides menu
    sed -i ${ra_config} -e 's|^quick_menu_show_save_core_overrides = .*|quick_menu_show_save_core_overrides = "true"|'
    sed -i ${ra_config} -e 's|^quick_menu_show_save_game_overrides = .*|quick_menu_show_save_game_overrides = "true"|'
    # hide menu sublabels - they are not legible anyway
    sed -i ${ra_config} -e 's|^menu_show_sublabels = .*|menu_show_sublabels = "false"|'
    # enable shaders
    sed -i ${ra_config} -e 's|^video_shader_enable = .*|video_shader_enable = "true"|'
    # turn on integer scaling
    sed -i ${ra_config} -e 's|^video_scale_integer = .*|video_scale_integer = "true"|'
    # rgui options
    sed -i ${ra_config} -e 's|^rgui_aspect_ratio_lock = .*|rgui_aspect_ratio_lock = "2"|'
    sed -i ${ra_config} -e 's|^menu_linear_filter = .*|menu_linear_filter = "true"|'
    # hide RetroArch version - core name in bottom right corner
    sed -i ${ra_config} -e 's|^menu_core_enable = .*|menu_core_enable = "false"|'
    # set widget scale / disable auto scaling
    sed -i ${ra_config} -e 's|^menu_widget_scale_auto = .*|menu_widget_scale_auto = "false"|'
    sed -i ${ra_config} -e 's|^menu_widget_scale_factor = .*|menu_widget_scale_factor = "1.150000"|'
    # turn off some distracting notifications
    sed -i ${ra_config} -e 's|^notification_show_cheats_applied = .*|notification_show_cheats_applied = "false"|'
    sed -i ${ra_config} -e 's|^notification_show_config_override_load = .*|notification_show_config_override_load = "false"|'
    sed -i ${ra_config} -e 's|^notification_show_disk_control = .*|notification_show_disk_control = "false"|'
    sed -i ${ra_config} -e 's|^notification_show_patch_applied = .*|notification_show_patch_applied = "false"|'
    sed -i ${ra_config} -e 's|^notification_show_refresh_rate = .*|notification_show_refresh_rate = "false"|'
    sed -i ${ra_config} -e 's|^notification_show_remap_load = .*|notification_show_remap_load = "false"|'
    # Set audio to headphone jack for Pi3/4, Pi 5 must use USB soundcard for analog audio out
    if listcontains "${DEVICE:0:4}" "(RPi3|RPi4)"; then
      sed -i ${ra_config} -e 's|^audio_device = .*|audio_device = "default:CARD=Headphones"|'
    fi
    # Force this resolution for RPi5 to start in the right one
    if [ "${DEVICE:0:4}" = "RPi5" ]; then
      sed -i ${ra_config} -e 's|^video_fullscreen_x = .*|video_fullscreen_x = "721"|'
      sed -i ${ra_config} -e 's|^video_fullscreen_y = .*|video_fullscreen_y = 480""|'
    fi
    # disable threaded video on RPi4 and RPi5
    if [ "${DEVICE:0:4}" = "RPi4" -o "${DEVICE:0:4}" = "RPi5" ]; then
      sed -i ${ra_config} -e 's|^video_threaded = .*|video_threaded = "false"|'
    fi
    # set video driver to glcore on RPi4/5
    if listcontains "${DEVICE:0:4}" "(RPi4|RPi5)"; then
      sed -i ${ra_config} -e 's|^video_driver = .*|video_driver = "glcore"|'
    fi
  fi

  # iMX6
  if [ "${PROJECT}" = "NXP" -a "${DEVICE}" = "iMX6" ]; then
    sed -i ${ra_config} -e 's|^audio_device = .*|audio_device = "default:CARD=DWHDMI"|'
    sed -i ${ra_config} -e 's|^audio_enable_menu = .*|audio_enable_menu = "true"|'
    sed -i ${ra_config} -e 's|^audio_enable_menu_ok = .*|audio_enable_menu_ok = "true"|'
    sed -i ${ra_config} -e 's|^audio_enable_menu_cancel = .*|audio_enable_menu_cancel = "true"|'
    sed -i ${ra_config} -e 's|^audio_enable_menu_notice = .*|audio_enable_menu_notice = "true"|'
  fi

  # Switch
  if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ] || [ "${PROJECT}" = "Ayn" -a "${DEVICE}" = "Odin" ]; then
    sed -i ${ra_config} -e 's|^menu_pointer_enable = .*|menu_pointer_enable = "true"|'
    sed -i ${ra_config} -e 's|^video_crop_overscan = .*|video_crop_overscan = "false"|'

    if [ ! "${PROJECT}" = "Ayn" -a ! "${DEVICE}" = "Odin" ]; then
      sed -i ${ra_config} -e 's|^video_hard_sync = .*|video_hard_sync = "true"|'
    fi

    sed -i ${ra_config} -e 's|^input_driver = .*|input_driver = "x"|'
    sed -i ${ra_config} -e 's|^video_smooth = .*|video_smooth = "true"|'
    sed -i ${ra_config} -e 's|^menu_driver = .*|menu_driver = "ozone"|'

    if [ ! "${PROJECT}" = "Ayn" -a ! "${DEVICE}" = "Odin" ]; then
      #Set Joypad as joypad with analog
      sed -i ${ra_config} -e 's|^input_device_p1 = .*|input_device_p1 = "5"|'
    else
      sed -i ${ra_config} -e 's|^video_river = .*|video_driver = "glcore"|'
      sed -i ${ra_config} -e 's|^audio_driver = .*|audio_driver = "pulse"|'
      sed -i ${ra_config} -e 's|^video_vsync = .*|video_vsync = "false"|'
    fi

    #HACK: Temporary hack for touchscreen
    sed -i ${ra_config} -e 's|^video_windowed_fullscreen = .*|video_windowed_fullscreen = "true"|'
  fi

  # create default environment file
  echo "HOME=/storage" >> ${INSTALL}/usr/lib/retroarch/retroarch-env.conf
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    echo "DISPLAY=:0.0" >> ${INSTALL}/usr/lib/retroarch/retroarch-env.conf
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    echo "WAYLAND_DISPLAY='wayland-1'" >> ${INSTALL}/usr/lib/retroarch/retroarch-env.conf
    echo "SWAYSOCK='/var/run/0-runtime-dir/sway-ipc.0.sock'" >> ${INSTALL}/usr/lib/retroarch/retroarch-env.conf
    echo "XDG_RUNTIME_DIR='/var/run/0-runtime-dir'" >> ${INSTALL}/usr/lib/retroarch/retroarch-env.conf
  fi
}

post_install() {
  enable_service retroarch.target
  enable_service tmp-cores.mount
  enable_service tmp-joypads.mount
  enable_service tmp-database.mount
  enable_service tmp-assets.mount
  enable_service tmp-shaders.mount
  enable_service tmp-overlays.mount
  enable_service tmp-system.mount
  enable_service retroarch-autostart.service
  enable_service retroarch.service
}
