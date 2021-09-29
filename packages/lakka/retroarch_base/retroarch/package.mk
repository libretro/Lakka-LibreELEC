PKG_NAME="retroarch"
PKG_VERSION="c226bd8"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain freetype zlib ffmpeg libass libvdpau libxkbcommon glsl_shaders systemd libpng"
PKG_SHORTDESC="Reference frontend for the libretro API."

PKG_CONFIGURE_OPTS_TARGET="--disable-vg \
                           --disable-sdl \
                           --disable-sdl2 \
                           --disable-ssl \
                           --enable-zlib \
                           --enable-freetype \
                           --enable-translate \
                           --enable-cdrom \
                           --enable-kms \
                           --disable-x11 \
                           --disable-wayland \
                           --disable-mali_fbdev \
                           --disable-videocore \
                           --disable-oss \
                           --disable-tinyalsa \
                           --datarootdir=${SYSROOT_PREFIX}/usr/share" # don't use host /usr/share!

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles"
fi

if [ "${OPENGL_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${VULKAN_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN} slang_shaders"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-vulkan"
fi

if [ "${PROJECT}" = "Rockchip" -a "${DEVICE}" = "OdroidGoAdvance" ]; then
  PKG_DEPENDS_TARGET+=" librga"
fi

if [ "${ALSA_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" alsa"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-alsa"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-alsa"
fi

if [ "${PULSEAUDIO_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-pulse"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-pulse"
fi

if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-odroidgo2 \
                               --enable-opengles3"
fi

if [ "${OPENGLES}" = "mesa" -a "${PROJECT}" = "RPi" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-egl"
fi

if [[ "${TARGET_FPU}" =~ "neon" ]]; then
  if [ ! "${ARCH}" = "aarch64" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-neon"
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

  if [ "${LAKKA_NIGHTLY}" = "yes" ]; then
    CFLAGS+=" -DHAVE_LAKKA_NIGHTLY"
  fi
}

make_target() {
  make V=1 HAVE_LAKKA=1 HAVE_ZARCH=0 HAVE_BLUETOOTH=1
  make -C gfx/video_filters compiler=${CC} extra_flags="${CFLAGS}"
  make -C libretro-common/audio/dsp_filters compiler=${CC} extra_flags="${CFLAGS}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp ${PKG_BUILD}/retroarch ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/etc
    cp ${PKG_BUILD}/retroarch.cfg ${INSTALL}/etc
  mkdir -p ${INSTALL}/usr/share/video_filters
    cp ${PKG_BUILD}/gfx/video_filters/*.so ${INSTALL}/usr/share/video_filters
    cp ${PKG_BUILD}/gfx/video_filters/*.filt ${INSTALL}/usr/share/video_filters
  mkdir -p ${INSTALL}/usr/share/audio_filters
    cp ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.so ${INSTALL}/usr/share/audio_filters
    cp ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.dsp ${INSTALL}/usr/share/audio_filters

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
  sed -i -e "s/# cheat_database_path =/cheat_database_path =\/tmp\/database\/cht/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# menu_driver = \"rgui\"/menu_driver = \"xmb\"/" ${INSTALL}/etc/retroarch.cfg

  # Power settings
  # Use ondemand for all RPi devices (for backwards compatibility?)
  if [ "${PROJECT}" == "RPi" ]; then
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
  sed -i -e "s/# video_windowed_fullscreen = true/video_windowed_fullscreen = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_smooth = true/video_smooth = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_aspect_ratio_auto = false/video_aspect_ratio_auto = true/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_threaded = false/video_threaded = true/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_font_path =/video_font_path =\/usr\/share\/retroarch-assets\/xmb\/monochrome\/font.ttf/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_font_size = 48/video_font_size = 32/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_filter_dir =/video_filter_dir =\/usr\/share\/video_filters/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_gpu_screenshot = true/video_gpu_screenshot = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# video_fullscreen = false/video_fullscreen = true/" ${INSTALL}/etc/retroarch.cfg

  # Audio
  sed -i -e "s/# audio_filter_dir =/audio_filter_dir =\/usr\/share\/audio_filters/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# audio_driver =/audio_driver = \"alsathread\"/" ${INSTALL}/etc/retroarch.cfg

  # Saving
  echo "savestate_thumbnail_enable = \"false\"" >> ${INSTALL}/etc/retroarch.cfg

  # Input
  sed -i -e "s/# input_driver = sdl/input_driver = udev/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# input_max_users = 16/input_max_users = 5/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# input_autodetect_enable = true/input_autodetect_enable = true/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# joypad_autoconfig_dir =/joypad_autoconfig_dir = \/tmp\/joypads/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# input_remapping_directory =/input_remapping_directory = \/storage\/remappings/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# input_menu_toggle_gamepad_combo = 0/input_menu_toggle_gamepad_combo = 2/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# all_users_control_menu = false/all_users_control_menu = true/" ${INSTALL}/etc/retroarch.cfg

  # Menu
  sed -i -e "s/# menu_mouse_enable = false/menu_mouse_enable = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# menu_core_enable = true/menu_core_enable = false/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# thumbnails_directory =/thumbnails_directory = \/storage\/thumbnails/" ${INSTALL}/etc/retroarch.cfg
  echo "menu_show_advanced_settings = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "menu_wallpaper_opacity = \"1.0\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "content_show_images = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "content_show_music = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "content_show_video = \"false\"" >> ${INSTALL}/etc/retroarch.cfg

  # Updater
  if [ "${ARCH}" == "arm" ]; then
    sed -i -e "s/# core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\"/core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\/nightly\/linux\/armhf\/latest\/\"/" ${INSTALL}/etc/retroarch.cfg
  fi

  # Playlists
  echo "playlist_entry_rename = \"false\"" >> ${INSTALL}/etc/retroarch.cfg
  echo "playlist_entry_remove = \"false\"" >> ${INSTALL}/etc/retroarch.cfg

  # Generic
  if [ "${PROJECT}" = "Generic" -a "${VULKAN_SUPPORT}" = yes ]; then
    echo "video_context_driver = \"khr_display\"" >> ${INSTALL/etc}/retroarch.cfg
  fi

  # OdroidGoAdvance
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    echo "xmb_layout = 2" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_widget_scale_auto = false" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_widget_scale_factor = 2.25" >> ${INSTALL}/etc/retroarch.cfg
  fi

  # GPICase
  if [ "${PROJECT}" = "RPi" -a "${DEVICE}" = "GPICase" ]; then
    echo "audio_device = \"default:CARD=ALSA\"" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_timedate_enable = false" >> ${INSTALL}/etc/retroarch.cfg
    echo "menu_driver = \"rgui\"" >> ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/input_menu_toggle_gamepad_combo = 2/input_menu_toggle_gamepad_combo = 4/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/video_threaded = true/video_threaded = false/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# aspect_ratio_index = 19/aspect_ratio_index = 21/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_out_rate = 48000/audio_out_rate = 44100/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# video_font_size = 32/video_font_size = 16/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# video_scale_integer = false/video_scale_integer = true/" ${INSTALL}/etc/retroarch.cfg
  fi

  # iMX6
  if [ "${PROJECT}" = "NXP" -a "${DEVICE}" = "iMX6" ]; then
    sed -i -e "s/# audio_device =/audio_device = \"default:CARD=DWHDMI\"/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu = false/audio_enable_menu = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_ok = false/audio_enable_menu_ok = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_cancel = false/audio_enable_menu_cancel = true/" ${INSTALL}/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_notice = false/audio_enable_menu_notice = true/" ${INSTALL}/etc/retroarch.cfg
  fi
}

post_install() {  
  # link default.target to retroarch.target
  ln -sf retroarch.target ${INSTALL}/usr/lib/systemd/system/default.target
  
  enable_service retroarch-autostart.service
  enable_service retroarch.service
  enable_service tmp-cores.mount
  enable_service tmp-joypads.mount
  enable_service tmp-database.mount
  enable_service tmp-assets.mount
  enable_service tmp-shaders.mount
  enable_service tmp-overlays.mount
  enable_service tmp-system.mount
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/retroarch
    cp -v ${PKG_DIR}/scripts/retroarch-config ${INSTALL}/usr/lib/retroarch
}
