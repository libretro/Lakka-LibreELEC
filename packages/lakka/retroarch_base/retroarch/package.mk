PKG_NAME="retroarch"
PKG_VERSION="9b282aa742b6c3d2f2925ae5a12e2cd7c6b6ad38"
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
                           --datarootdir=${SYSROOT_PREFIX}/usr/share" # don't use host /usr/share!

PKG_MAKE_OPTS_TARGET="V=1 \
                      HAVE_LAKKA=1 \
                      HAVE_HAVE_ZARCH=0 \
                      HAVE_WIFI=1 \
                      HAVE_BLUETOOTH=1 \
                      HAVE_FREETYPE=1"

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles"
  if [[ ${DEVICE} =~ ^RPi4.* ]] || [ ${DEVICE} = "RK3288" ] || [ "${DEVICE}" = "RK3399" ] || [ "${DEVICE}" = "Odin" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles3 \
                                 --enable-opengles3_1"
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
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-vulkan"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-vulkan"
fi

if [ "${SAMBA_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" samba"
fi

if [ "${AVAHI_DAEMON}" = yes ]; then
  PKG_DEPENDS_TARGET+=" avahi nss-mdns"
fi

if [ "${DISPLAYSERVER}" != "no" ]; then
  PKG_DEPENDS_TARGET+=" ${DISPLAYSERVER}"
fi

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libXxf86vm libXv"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-x11 --enable-xinerama"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-x11"
fi

if [ "${DISPLAYSERVER}" = "weston" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
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

if [ "${LAKKA_NIGHTLY}" = yes ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_LAKKA_NIGHTLY=1"
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
  mkdir -p ${INSTALL}/usr/share/video_filters
    cp -v ${PKG_BUILD}/gfx/video_filters/*.so ${INSTALL}/usr/share/video_filters
    cp -v ${PKG_BUILD}/gfx/video_filters/*.filt ${INSTALL}/usr/share/video_filters
  mkdir -p ${INSTALL}/usr/share/audio_filters
    cp -v ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.so ${INSTALL}/usr/share/audio_filters
    cp -v ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.dsp ${INSTALL}/usr/share/audio_filters
  mkdir -p ${INSTALL}/usr/lib/retroarch
    cp -v ${PKG_DIR}/scripts/retroarch-config ${INSTALL}/usr/lib/retroarch

  # System overlay
  mkdir -p ${INSTALL}/usr/share/retroarch-system
    touch ${INSTALL}/usr/share/retroarch-system/.placeholder

  # General configuration
  mkdir -p ${INSTALL}/etc
  echo 'libretro_directory = "/tmp/cores"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'libretro_info_path = "/tmp/cores"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'rgui_browser_directory = "/storage/roms"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'content_database_path = "/tmp/database/rdb"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'playlist_directory = "/storage/playlists"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'savefile_directory = "/storage/savefiles"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'savestate_directory = "/storage/savestates"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'system_directory = "/tmp/system"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'screenshot_directory = "/storage/screenshots"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_shader_dir = "/tmp/shaders"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'rgui_show_start_screen = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'assets_directory = "/tmp/assets"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'overlay_directory = "/tmp/overlays"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'cheat_database_path = "/tmp/cheats"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'cursor_directory = "/tmp/database/cursors"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'log_dir = "/storage/logfiles"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'recording_output_directory = "/storage/recordings"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'menu_driver = "xmb"' >> ${INSTALL}/etc/retroarch.cfg

  # Power settings
  # Use ondemand for all RPi devices (for backwards compatibility?)
  # and any battery powered device (OGA and RPi case)
  if [ "${PROJECT}" = "RPi" ] || [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    echo 'cpu_main_gov = "ondemand"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'cpu_menu_gov = "ondemand"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'cpu_scaling_mode = "1"' >> ${INSTALL}/etc/retroarch.cfg
  fi

  # Quick menu
  echo 'core_assets_directory = "/storage/roms/downloads"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'quick_menu_show_undo_save_load_state = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'quick_menu_show_save_core_overrides = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'quick_menu_show_save_game_overrides = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'quick_menu_show_cheats = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'quick_menu_show_overlays = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'quick_menu_show_rewind = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'quick_menu_show_latency = "false"' >> ${INSTALL}/etc/retroarch.cfg

  # Video
  echo 'video_windowed_fullscreen = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_smooth = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_aspect_ratio_auto = "true"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_threaded = "true"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_font_path = "/usr/share/retroarch-assets/xmb/monochrome/font.ttf"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_font_size = "32"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_filter_dir = "/usr/share/video_filters"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_gpu_screenshot = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'video_fullscreen = "true"' >> ${INSTALL}/etc/retroarch.cfg

  # Audio
  echo 'audio_driver = "alsathread"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'audio_filter_dir = "/usr/share/audio_filters"' >> ${INSTALL}/etc/retroarch.cfg

  if [ "${PROJECT}" = "OdroidXU3" ]; then # workaround the 55fps bug
    echo 'audio_out_rate = "44100"' >> ${INSTALL}/etc/retroarch.cfg
  fi

  # Saving
  echo 'savestate_thumbnail_enable = "false"' >> ${INSTALL}/etc/retroarch.cfg

  # Input
  echo 'input_driver = "udev"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'input_max_users = "5"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'input_autodetect_enable = "true"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'joypad_autoconfig_dir = "/tmp/joypads"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'input_remapping_directory = "/storage/remappings"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'input_menu_toggle_gamepad_combo = "2"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'all_users_control_menu = "true"' >> ${INSTALL}/etc/retroarch.cfg

  # Menu
  echo 'menu_core_enable = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'thumbnails_directory = "/storage/thumbnails"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'menu_show_advanced_settings = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'menu_wallpaper_opacity = "1.0"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'content_show_images = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'content_show_music = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'content_show_video = "false"' >> ${INSTALL}/etc/retroarch.cfg

  # Playlists
  echo 'playlist_entry_rename = "false"' >> ${INSTALL}/etc/retroarch.cfg
  echo 'playlist_entry_remove = "false"' >> ${INSTALL}/etc/retroarch.cfg

  # Generic
  if [ "${PROJECT}" = "Generic" ]; then
    echo 'video_context_driver = "khr_display"' >> ${INSTALL}/etc/retroarch.cfg
    #echo 'video_driver = "vulkan"' >> ${INSTALL}/etc/retroarch.cfg
  fi

  # OdroidGoAdvance
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    echo 'xmb_layout = "2"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'menu_widget_scale_auto = "false"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'menu_widget_scale_factor = "2.25"' >> ${INSTALL}/etc/retroarch.cfg
  fi

  # GPICase
  if [ "${PROJECT}" = "RPi" ] && [ "${DEVICE}" = "GPICase" -o "${DEVICE}" = "Pi02GPi" ]; then
    sed -i -e 's|^input_menu_toggle_gamepad_combo =.*|input_menu_toggle_gamepad_combo = "4"|' ${INSTALL}/etc/retroarch.cfg
    sed -i -e 's|^menu_driver =.*|menu_driver = "rgui"|' ${INSTALL}/etc/retroarch.cfg
    echo 'audio_device = "default:CARD=ALSA"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'menu_timedate_enable = "false"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'menu_enable_widgets = "false"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'aspect_ratio_index = "21"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'audio_out_rate = "44100"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'video_font_size = "16"' >> ${INSTALL}/etc/retroarch.cfg

    if [ "${DEVICE}" = "GPICase" ]; then
      sed -i -e 's|^video_threaded =.*|video_threaded = "false"|' ${INSTALL}/etc/retroarch.cfg
      echo 'video_scale_integer = "true"' >> ${INSTALL}/etc/retroarch.cfg
    fi

    if [ "${DEVICE}" = "Pi02GPi" ]; then
      echo 'input_player1_analog_dpad_mode = "3"' >> $INSTALL/etc/retroarch.cfg
    fi
  fi

  # PiBoy DMG / RetroDreamer
  if [ "${DEVICE}" = "RPi4-PiBoyDmg" -o "${DEVICE}" = "RPi4-RetroDreamer" ]; then
    echo 'menu_timedate_enable = "false"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'menu_scale_factor = "1.44"' >> ${INSTALL}/etc/retroarch.cfg
    sed -i -e 's|^input_menu_toggle_gamepad_combo =.*|input_menu_toggle_gamepad_combo = "4"|' ${INSTALL}/etc/retroarch.cfg
    sed -i -e 's|^menu_driver =.*|menu_driver = "ozone"|' ${INSTALL}/etc/retroarch.cfg
  fi

  # iMX6
  if [ "${PROJECT}" = "NXP" -a "${DEVICE}" = "iMX6" ]; then
    echo 'audio_device = "default:CARD=DWHDMI"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'audio_enable_menu = "true"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'audio_enable_menu_ok = "true"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'audio_enable_menu_cancel = "true"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'audio_enable_menu_notice = "true"' >> ${INSTALL}/etc/retroarch.cfg
  fi

  # Switch
  if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ] || [ "${PROJECT}" = "Ayn" -a "${DEVICE}" = "Odin" ]; then
    echo 'menu_mouse_enable = "false"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'menu_pointer_enable = "true"'>> ${INSTALL}/etc/retroarch.cfg
    echo 'video_hard_sync = "true"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'video_crop_overscan = "false"' >> ${INSTALL}/etc/retroarch.cfg

    if [ ! "${PROJECT}" = "Ayn" -a ! "${DEVICE}" = "Odin" ]; then
      echo 'input_joypad_driver = "udev"' >> ${INSTALL}/etc/retroarch.cfg
    fi

    sed -i -e 's|^input_driver =.*|input_driver= "x"|' ${INSTALL}/etc/retroarch.cfg
    sed -i -e 's|^video_smooth =.*|video_smooth = "true"|' ${INSTALL}/etc/retroarch.cfg
    sed -i -e 's|^menu_driver =.*|menu_driver = "ozone"|' ${INSTALL}/etc/retroarch.cfg

    if [ ! "${PROJECT}" = "Ayn" -a ! "${DEVICE}" = "Odin" ]; then
      #Set Default Joycon index to Combined Joycons.
      echo 'input_player1_joypad_index = "2"' >> ${INSTALL}/etc/retroarch.cfg

      #Set Joypad as joypad with analog
      echo 'input_libretro_device_p1 = "5"' >> ${INSTALL}/etc/retroarch.cfg
    else
      echo 'video_driver = "glcore"' >> ${INSTALL}/etc/retroarch.cfg
      sed -i -e 's|^audio_driver =.*|audio_driver = "pulse"|' ${INSTALL}/etc/retroarch.cfg
    fi

    #HACK: Temporary hack for touchscreen
    sed -i -e 's|^video_windowed_fullscreen =.*|video_windowed_fullscreen = "true"|' ${INSTALL}/etc/retroarch.cfg
  fi

  # sort the options in config file
  sort ${INSTALL}/etc/retroarch.cfg > ${INSTALL}/etc/retroarch-sorted.cfg
  mv ${INSTALL}/etc/retroarch-sorted.cfg ${INSTALL}/etc/retroarch.cfg
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
