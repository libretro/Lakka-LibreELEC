PKG_NAME="retroarch"
PKG_VERSION="b9c77a48c982865597b2282123da42c29c127648"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain freetype zlib ffmpeg libass libvdpau libxkbcommon glsl_shaders slang_shaders systemd libpng fontconfig"
PKG_LONGDESC="Reference frontend for the libretro API."

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
                      HAVE_BLUETOOTH=1 \
                      HAVE_FREETYPE=1"

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles"
  if [ "${OPENGLES}" = "mesa" ] ||
     [ "${OPENGLES}" = "mali-odroidgo2" ] ||
     [ "${OPENGLES}" = "libmali" -a "${PROJECT}.${DEVICE}" != "Allwinner.A64" -a "${PROJECT}.${DEVICE}" != "Allwinner.H3" -a "${PROJECT}.${DEVICE}" != "Rockchip.RK3328" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles3 \
                                 --enable-opengles3_1 \
                                 --enable-opengles3_2"
  fi
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-opengles"
fi

if [ "${OPENGL_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengl"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL1=1"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-opengl"
fi

if [ "${VULKAN_SUPPORT}" = yes ]; then
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
  PKG_DEPENDS_TARGET+=" libXxf86vm"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-x11"
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
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-xinerama --disable-vulkan_display"
  PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-kms/--disable-kms}
  PKG_CONFIGURE_OPTS_TARGET=${PKG_CONFIGURE_OPTS_TARGET//--enable-egl/--disable-egl}
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
}

make_target() {
  make ${PKG_MAKE_OPTS_TARGET}
  make -C gfx/video_filters compiler=${CC} extra_flags="${CFLAGS}"
  make -C libretro-common/audio/dsp_filters compiler=${CC} extra_flags="${CFLAGS}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_BUILD}/retroarch ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/etc
    cp -v ${PKG_BUILD}/retroarch.cfg ${INSTALL}/etc
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
  sed -i -e "s/# libretro_directory =/libretro_directory = \"\/tmp\/cores\"/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# libretro_info_path =/libretro_info_path = \"\/tmp\/cores\"/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# rgui_browser_directory =/rgui_browser_directory =\/storage\/roms/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# content_database_path =/content_database_path =\/tmp\/database\/rdb/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# playlist_directory =/playlist_directory =\/storage\/playlists/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# savefile_directory =/savefile_directory =\/storage\/savefiles/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# savestate_directory =/savestate_directory =\/storage\/savestates/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# system_directory =/system_directory =\/tmp\/system/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# screenshot_directory =/screenshot_directory =\/storage\/screenshots/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_shader_dir =/video_shader_dir =\/tmp\/shaders/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# rgui_show_start_screen = true/rgui_show_start_screen = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# assets_directory =/assets_directory =\/tmp\/assets/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# overlay_directory =/overlay_directory =\/tmp\/overlays/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# cheat_database_path =/cheat_database_path =\/tmp\/cheats/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# cursor_directory =/cursor_directory =\/tmp\/database\/cursors/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# log_dir =/log_dir =\/storage\/logfiles/" ${INSTALL}/etc/retroarch.cfg

  if [ ! "${DEVICE}" = "Switch" ]; then
    sed -i -e "s/# menu_driver = \"rgui\"/menu_driver = \"xmb\"/" ${INSTALL}/etc/retroarch.cfg
  else
    sed -i -e "s/# menu_driver = \"rgui\"/menu_driver = \"ozone\"/" ${INSTALL}/etc/retroarch.cfg
  fi

  # Power settings
  # Use ondemand for all RPi devices (for backwards compatibility?)
  # and any battery powered device (OGA and RPi case)
  if [ "${PROJECT}" = "RPi" ] || [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    echo 'cpu_main_gov = "ondemand"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'cpu_menu_gov = "ondemand"' >> ${INSTALL}/etc/retroarch.cfg
    echo 'cpu_scaling_mode = "1"' >> ${INSTALL}/etc/retroarch.cfg
  fi

  # Quick menu
  echo "core_assets_directory =/storage/roms/downloads" >> ${INSTALL}/etc/retroarch.cfg
  echo "quick_menu_show_undo_save_load_state = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "quick_menu_show_save_core_overrides = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "quick_menu_show_save_game_overrides = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "quick_menu_show_cheats = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "quick_menu_show_overlays = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "quick_menu_show_rewind = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "quick_menu_show_latency = \"false\"" >> ${INSTALL}/etc/retroarch.cfg

  # Video
  # HACK: Temporary hack for touch in Nintendo Switch
  if [ ! "${DEVICE}" = "Switch" ]; then
    sed -i -e "s/# video_windowed_fullscreen = true/video_windowed_fullscreen = false/" ${INSTALL}/etc/retroarch.cfg
  else
    sed -i -e "s/# video_windowed_fullscreen = true/video_windowed_fullscreen = true/" ${INSTALL}/etc/retroarch.cfg
  fi
  sed -i -e "s/# video_smooth = true/video_smooth = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_aspect_ratio_auto = false/video_aspect_ratio_auto = true/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_threaded = false/video_threaded = true/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_font_path =/video_font_path =\/usr\/share\/retroarch-assets\/xmb\/monochrome\/font.ttf/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_font_size = 48/video_font_size = 32/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_filter_dir =/video_filter_dir =\/usr\/share\/video_filters/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_gpu_screenshot = true/video_gpu_screenshot = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_fullscreen = false/video_fullscreen = true/" ${INSTALL}/etc/retroarch.cfg

  # Audio
  if [ ! "${DEVICE}" = "Switch" ]; then
    sed -i -e "s/# audio_driver =/audio_driver = \"alsathread\"/" ${INSTALL}/etc/retroarch.cfg
  else
    sed -i -e "s/# audio_driver =/audio_driver = \"pulse\"/" ${INSTALL}/etc/retroarch.cfg
  fi
  sed -i -e "s/# audio_filter_dir =/audio_filter_dir =\/usr\/share\/audio_filters/" ${INSTALL}/etc/retroarch.cfg
 if [ "${PROJECT}" = "OdroidXU3" ]; then # workaround the 55fps bug
    sed -i -e "s/# audio_out_rate = 48000/audio_out_rate = 44100/" ${INSTALL}/etc/retroarch.cfg
  fi

  # Saving
  echo "savestate_thumbnail_enable = \"false\"" >> ${INSTALL}/etc/retroarch.cfg

  # Input
  if [ ! "${DEVICE}" = "Switch" ]; then
    sed -i -e "s/# input_driver = sdl/input_driver = udev/" ${INSTALL}/etc/retroarch.cfg
  else
    sed -i -e "s/# input_driver = sdl/input_driver = x/" ${INSTALL}/etc/retroarch.cfg
  fi
  sed -i -e "s/# input_max_users = 16/input_max_users = 5/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# input_autodetect_enable = true/input_autodetect_enable = true/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# joypad_autoconfig_dir =/joypad_autoconfig_dir = \/tmp\/joypads/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# input_remapping_directory =/input_remapping_directory = \/storage\/remappings/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# input_menu_toggle_gamepad_combo = 0/input_menu_toggle_gamepad_combo = 2/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# all_users_control_menu = false/all_users_control_menu = true/" ${INSTALL}/etc/retroarch.cfg

  # Menu
  if [ ! "${DEVICE}" = "Switch" ]; then
    sed -i -e "s/# menu_mouse_enable = false/menu_mouse_enable = false/" ${INSTALL}/etc/retroarch.cfg
  fi
  sed -i -e "s/# menu_core_enable = true/menu_core_enable = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# thumbnails_directory =/thumbnails_directory = \/storage\/thumbnails/" ${INSTALL}/etc/retroarch.cfg
  echo "menu_show_advanced_settings = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "menu_wallpaper_opacity = \"1.0\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "content_show_images = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "content_show_music = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "content_show_video = \"false\"" >> ${INSTALL}/etc/retroarch.cfg

  # Updater
  if [ "${ARCH}" = "arm" ]; then
    sed -i -e "s/# core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\"/core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\/nightly\/linux\/armhf\/latest\/\"/" ${INSTALL}/etc/retroarch.cfg
  fi

  # Playlists
  echo "playlist_entry_rename = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "playlist_entry_remove = \"false\"" >> ${INSTALL}/etc/retroarch.cfg

  # Generic
  if [ "${PROJECT}" = "Generic" ]; then
    echo "video_context_driver = \"khr_display\"" >> ${INSTALL}/etc/retroarch.cfg
#    echo "video_driver = \"vulkan\"" >> ${INSTALL}/etc/retroarch.cfg
  fi

  # OdroidGoAdvance
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    echo "xmb_layout = 2" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_widget_scale_auto = false" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_widget_scale_factor = 2.25" >> ${INSTALL}/etc/retroarch.cfg
  fi

  # GPICase
  if [ "${PROJECT}" = "RPi" ] && [ "${DEVICE}" = "GPICase" -o "${DEVICE}" = "Pi02GPi" ]; then
    echo "audio_device = \"default:CARD=ALSA\"" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_timedate_enable = false" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_enable_widgets = false" >> ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/input_menu_toggle_gamepad_combo = 2/input_menu_toggle_gamepad_combo = 4/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/menu_driver = \"xmb\"/menu_driver = \"rgui\"/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# aspect_ratio_index = 19/aspect_ratio_index = 21/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_out_rate = 48000/audio_out_rate = 44100/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# video_font_size = 32/video_font_size = 16/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/video_rotation = \"0\"/video_rotation = \"3\"/" ${INSTALL}/etc/retroarch.cfg

    if [ "${DEVICE}" = "GPICase" ]; then
      sed -i -e "s/video_threaded = true/video_threaded = false/" ${INSTALL}/etc/retroarch.cfg
      sed -i -e "s/# video_scale_integer = false/video_scale_integer = true/" ${INSTALL}/etc/retroarch.cfg
    fi

    if [ "${DEVICE}" = "Pi02GPi" ]; then
      echo 'input_player1_analog_dpad_mode = "3"' >> $INSTALL/etc/retroarch.cfg
    fi
  fi

  # PiBoy DMG / RetroDreamer
  if [ "${DEVICE}" = "RPi4-PiBoyDmg" -o "${DEVICE}" = "RPi4-RetroDreamer" ]; then
    echo "menu_timedate_enable = false" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_scale_factor = \"1.44\"" >> ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/input_menu_toggle_gamepad_combo = .*$/input_menu_toggle_gamepad_combo = 4/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/menu_driver = .*$/menu_driver = \"ozone\"/" ${INSTALL}/etc/retroarch.cfg
  fi

  # iMX6
  if [ "${PROJECT}" = "NXP" -a "${DEVICE}" = "iMX6" ]; then
    sed -i -e "s/# audio_device =/audio_device = \"default:CARD=DWHDMI\"/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu = false/audio_enable_menu = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_ok = false/audio_enable_menu_ok = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_cancel = false/audio_enable_menu_cancel = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_notice = false/audio_enable_menu_notice = true/" ${INSTALL}/etc/retroarch.cfg
  fi

  # Switch
  if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
    sed -i -e "s/# menu_pointer_enable = false/menu_pointer_enable = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# video_hard_sync = false/video_hard_sync = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# video_crop_overscan = true/video_crop_overscan = false/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# menu_show_online_updater = true/menu_show_online_updater = false/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# input_joypad_driver =/input_joypad_driver = udev/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/video_threaded = true/video_threaded = false/" ${INSTALL}/etc/retroarch.cfg
    
    #Set Default Joycon index to Combined Joycons.
    sed -i -e "s/# input_player1_joypad_index = 0/input_player1_joypad_index = \"2\"/" ${INSTALL}/etc/retroarch.cfg

    #Set Joypad as joypad with analog
    sed -i -e "s/# input_libretro_device_p1 =/input_libretro_device_p1 = \"5\"/" ${INSTALL}/etc/retroarch.cfg

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
