################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="retroarch"
PKG_VERSION="9b282aa"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain alsa-lib freetype zlib retroarch-assets retroarch-overlays core-info retroarch-joypad-autoconfig lakka-update libretro-database ffmpeg libass libvdpau libxkbfile xkeyboard-config libxkbcommon joyutils sixpair empty libretro-cores glsl-shaders fontconfig"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Reference frontend for the libretro API."
PKG_LONGDESC="RetroArch is the reference frontend for the libretro API. Popular examples of implementations for this API includes videogame system emulators and game engines, but also more generalized 3D programs. These programs are instantiated as dynamic libraries. We refer to these as libretro cores."
PKG_LR_UPDATE_TAG="yes"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ ! "$PROJECT" = "L4T" ]; then
  if [ "$VULKAN_SUPPORT" = yes ]; then
    PKG_DEPENDS_TARGET+=" slang-shaders $VULKAN"
  fi
else
  PKG_DEPENDS_TARGET+=" slang-shaders vulkan-loader"
fi

if [ "$SAMBA_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" samba"
fi

if [ "$AVAHI_DAEMON" = yes ]; then
  PKG_DEPENDS_TARGET+=" avahi nss-mdns"
fi

if [ "$DISPLAYSERVER" != "no" ]; then
  PKG_DEPENDS_TARGET+=" $DISPLAYSERVER"
fi

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libXxf86vm"
fi

if [ "$DISPLAYSERVER" = "weston" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
fi

RETROARCH_GL=""

if [ "$DEVICE" = "OdroidGoAdvance" ]; then
  PKG_DEPENDS_TARGET+=" librga libpng"
  RETROARCH_GL="--enable-kms --enable-odroidgo2 --disable-x11 --disable-wayland --enable-opengles --enable-opengles3 --enable-opengles3_2 --disable-mali_fbdev"
elif [ "$OPENGL_SUPPORT" = "yes" ]; then
  RETROARCH_GL="--enable-kms"
elif [ "$OPENGLES" = "odroidc1-mali" ] || [ "$OPENGLES" = "opengl-meson" ] || [ "$OPENGLES" = "opengl-meson8" ] || [ "$OPENGLES" = "opengl-meson-t82x" ] || [ "$OPENGLES" = "allwinner-fb-mali" ]; then
  RETROARCH_GL="--enable-opengles --disable-kms --disable-x11 --enable-mali_fbdev"
elif [ "$OPENGLES" = "gpu-viv-bin-mx6q" ] || [ "$OPENGLES" = "imx-gpu-viv" ]; then
  RETROARCH_GL="--enable-opengles --disable-kms --disable-x11 --enable-vivante_fbdev"
elif [ "$OPENGLES" = "libmali" ]; then
  RETROARCH_GL="--enable-opengles --enable-kms --disable-x11 --disable-wayland"
elif [ "$OPENGLES" = "bcm2835-driver" ]; then
  RETROARCH_GL="--enable-opengles --disable-kms --disable-x11 --disable-wayland --enable-videocore --enable-dispmanx --disable-opengl --enable-egl"
elif [ "$OPENGLES" = "allwinner-mali" ]; then
  RETROARCH_GL="--enable-opengles --enable-kms --disable-x11"
elif [ "$OPENGLES" = "mesa" ]; then
  if [ "$PROJECT" = "RPi" ]; then
    RETROARCH_GL="--disable-x11 --enable-opengles --disable-videocore --enable-kms --enable-egl --disable-wayland"
    if [ "${DEVICE:0:4}" = "RPi4" ]; then
      RETROARCH_GL+=" --enable-opengles3 --enable-opengles3_1"
    fi
  else
    RETROARCH_GL="--enable-opengles --enable-kms --disable-x11"
  fi
elif [ "$OPENGLES" = "mesa" ]; then
  if [ "$PROJECT" = "Generic" ]; then
   RETROARCH_GL="--enable-opengles --enable-kms --disable-x11 --enable-egl --disable-wayland --enable-vulkan"
 fi
fi
if [ ! "$PROJECT" = "L4T" ]; then
  if [ "$VULKAN_SUPPORT" = "yes" ]; then
    RETROARCH_GL+=" --enable-vulkan"
  fi
fi
if [ "$PROJECT" = "L4T" ]; then
   RETROARCH_GL="$RETROARCH_GL --disable-egl --enable-opengl --enable-vulkan --enable-xinerama --disable-vulkan_display"
   RETROARCH_GL=${RETROARCH_GL//--enable-opengles/--disable-opengles}
   RETROARCH_GL=${RETROARCH_GL//--enable-kms/--disable-kms}
   RETROARCH_GL=${RETROARCH_GL//--enable-wayland/--disable-wayland}
   RETROARCH_GL=${RETROARCH_GL//--disable-x11/--enable-x11}
fi

RETROARCH_NEON=""

if [[ "$TARGET_FPU" =~ "neon" ]]; then
  if [ "$ARCH" = "aarch64" ]; then
    RETROARCH_NEON=""
  else
    RETROARCH_NEON="--enable-neon"
  fi
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-vg \
                           --disable-sdl \
                           --disable-sdl2 \
                           --disable-ssl \
                           $RETROARCH_GL \
                           $RETROARCH_NEON \
                           --enable-zlib \
                           --enable-freetype \
                           --enable-translate \
                           --enable-cdrom \
                           --enable-command \
                           --datarootdir=$SYSROOT_PREFIX/usr/share" # don't use host /usr/share!

if [ "$PROJECT" = "L4T" ]; then
   PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-pulse"
fi

pre_configure_target() {
  TARGET_CONFIGURE_OPTS=""
  cd $PKG_BUILD
}

pre_make_target() {
  if [ "$OPENGLES" = "bcm2835-driver" ]; then
    CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
              -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
  elif [ "$OPENGLES" = "gpu-viv-bin-mx6q" ] || [ "$OPENGLES" = "imx-gpu-viv" ]; then
    CFLAGS+=" -DLINUX -DEGL_API_FB"
  fi

  HAVE_LAKKA_NIGHTLY=""
  if [ "$LAKKA_NIGHTLY" = yes ]; then
    HAVE_LAKKA_NIGHTLY="HAVE_LAKKA_NIGHTLY=1"
  fi
  CFLAGS=${CFLAGS/"-Os"/"-O2"}
  CFLAGS=${CFLAGS/"-O3"/"-O2"}
}

make_target() {
  if [ "$DEVICE" = "Switch" ]; then
    make V=1 HAVE_LAKKA=1 HAVE_LAKKA_SWITCH=1 HAVE_ZARCH=0 HAVE_WIFI=1 HAVE_BLUETOOTH=1 HAVE_FREETYPE=1 $HAVE_LAKKA_NIGHTLY
  else
    make V=1 HAVE_LAKKA=1 HAVE_ZARCH=0 HAVE_WIFI=1 HAVE_BLUETOOTH=1 HAVE_FREETYPE=1 $HAVE_LAKKA_NIGHTLY
  fi
  make -C gfx/video_filters compiler=$CC extra_flags="$CFLAGS"
  make -C libretro-common/audio/dsp_filters compiler=$CC extra_flags="$CFLAGS"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/etc
    cp $PKG_BUILD/retroarch $INSTALL/usr/bin
    cp $PKG_BUILD/retroarch.cfg $INSTALL/etc
  mkdir -p $INSTALL/usr/share/video_filters
    cp $PKG_BUILD/gfx/video_filters/*.so $INSTALL/usr/share/video_filters
    cp $PKG_BUILD/gfx/video_filters/*.filt $INSTALL/usr/share/video_filters
  mkdir -p $INSTALL/usr/share/audio_filters
    cp $PKG_BUILD/libretro-common/audio/dsp_filters/*.so $INSTALL/usr/share/audio_filters
    cp $PKG_BUILD/libretro-common/audio/dsp_filters/*.dsp $INSTALL/usr/share/audio_filters

  # General configuration
  sed -i -e "s/# libretro_directory =/libretro_directory = \"\/tmp\/cores\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# libretro_info_path =/libretro_info_path = \"\/tmp\/cores\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# rgui_browser_directory =/rgui_browser_directory =\/storage\/roms/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# content_database_path =/content_database_path =\/tmp\/database\/rdb/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# playlist_directory =/playlist_directory =\/storage\/playlists/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# savefile_directory =/savefile_directory =\/storage\/savefiles/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# savestate_directory =/savestate_directory =\/storage\/savestates/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# system_directory =/system_directory =\/tmp\/system/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# screenshot_directory =/screenshot_directory =\/storage\/screenshots/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_shader_dir =/video_shader_dir =\/tmp\/shaders/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# rgui_show_start_screen = true/rgui_show_start_screen = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# assets_directory =/assets_directory =\/tmp\/assets/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# overlay_directory =/overlay_directory =\/tmp\/overlays/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# cheat_database_path =/cheat_database_path =\/tmp\/database\/cht/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# cursor_directory =/cursor_directory =\/tmp\/database\/cursors/" ${INSTALL}/etc/retroarch.cfg
  sed -i -e "s/# recording_output_directory =/recording_output_directory =\/storage\/recordings/" ${INSTALL}/etc/retroarch.cfg
  echo 'log_dir = "/storage/logfiles"' >> ${INSTALL}/etc/retroarch.cfg

  if [ ! "$DEVICE" = "Switch" ]; then
    sed -i -e "s/# menu_driver = \"rgui\"/menu_driver = \"xmb\"/" $INSTALL/etc/retroarch.cfg
  else
    sed -i -e "s/# menu_driver = \"rgui\"/menu_driver = \"ozone\"/" $INSTALL/etc/retroarch.cfg
  fi

  # Power settings
  # Use ondemand for all RPi devices (for backwards compatibility?)
  # and any battery powered device (OGA and RPi case)
  if [ "$PROJECT" = "RPi" ] || [ "$DEVICE" = "OdroidGoAdvance" ]; then
    echo 'cpu_main_gov = "ondemand"' >> $INSTALL/etc/retroarch.cfg
    echo 'cpu_menu_gov = "ondemand"' >> $INSTALL/etc/retroarch.cfg
    echo 'cpu_scaling_mode = "1"' >> $INSTALL/etc/retroarch.cfg
  fi

  # Quick menu
  echo "core_assets_directory =/storage/roms/downloads" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_undo_save_load_state = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_save_core_overrides = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_save_game_overrides = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_cheats = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_overlays = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_rewind = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_latency = \"false\"" >> $INSTALL/etc/retroarch.cfg

  # Video
  # HACK: Temporary hack for touch in Nintendo Switch
  if [ ! "$DEVICE" = "Switch" ]; then
    sed -i -e "s/# video_windowed_fullscreen = true/video_windowed_fullscreen = false/" $INSTALL/etc/retroarch.cfg
  else
    sed -i -e "s/# video_windowed_fullscreen = true/video_windowed_fullscreen = true/" $INSTALL/etc/retroarch.cfg
  fi
  sed -i -e "s/# video_smooth = true/video_smooth = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_aspect_ratio_auto = false/video_aspect_ratio_auto = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_threaded = false/video_threaded = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_font_path =/video_font_path =\/usr\/share\/retroarch-assets\/xmb\/monochrome\/font.ttf/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_font_size = 48/video_font_size = 32/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_filter_dir =/video_filter_dir =\/usr\/share\/video_filters/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_gpu_screenshot = true/video_gpu_screenshot = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_fullscreen = false/video_fullscreen = true/" $INSTALL/etc/retroarch.cfg

  # Audio
  if [ ! "$DEVICE" = "Switch" ]; then
    sed -i -e "s/# audio_driver =/audio_driver = \"alsathread\"/" $INSTALL/etc/retroarch.cfg
  else
    sed -i -e "s/# audio_driver =/audio_driver = \"pulse\"/" $INSTALL/etc/retroarch.cfg
  fi
  sed -i -e "s/# audio_filter_dir =/audio_filter_dir =\/usr\/share\/audio_filters/" $INSTALL/etc/retroarch.cfg
 if [ "$PROJECT" = "OdroidXU3" ]; then # workaround the 55fps bug
    sed -i -e "s/# audio_out_rate = 48000/audio_out_rate = 44100/" $INSTALL/etc/retroarch.cfg
  fi

  # Saving
  echo "savestate_thumbnail_enable = \"false\"" >> $INSTALL/etc/retroarch.cfg

  # Input
  if [ ! "$DEVICE" = "Switch" ]; then
    sed -i -e "s/# input_driver = sdl/input_driver = udev/" $INSTALL/etc/retroarch.cfg
  else
    sed -i -e "s/# input_driver = sdl/input_driver = x/" $INSTALL/etc/retroarch.cfg
  fi
  sed -i -e "s/# input_max_users = 16/input_max_users = 5/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_autodetect_enable = true/input_autodetect_enable = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# joypad_autoconfig_dir =/joypad_autoconfig_dir = \/tmp\/joypads/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_remapping_directory =/input_remapping_directory = \/storage\/remappings/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_menu_toggle_gamepad_combo = 0/input_menu_toggle_gamepad_combo = 2/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# all_users_control_menu = false/all_users_control_menu = true/" $INSTALL/etc/retroarch.cfg

  # Menu
  if [ ! "$DEVICE" = "Switch" ]; then
    sed -i -e "s/# menu_mouse_enable = false/menu_mouse_enable = false/" $INSTALL/etc/retroarch.cfg
  fi
  sed -i -e "s/# menu_core_enable = true/menu_core_enable = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# thumbnails_directory =/thumbnails_directory = \/storage\/thumbnails/" $INSTALL/etc/retroarch.cfg
  echo "menu_show_advanced_settings = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "menu_wallpaper_opacity = \"1.0\"" >> $INSTALL/etc/retroarch.cfg
  echo "content_show_images = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "content_show_music = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "content_show_video = \"false\"" >> $INSTALL/etc/retroarch.cfg

  # Updater
  if [ "$ARCH" = "arm" ]; then
    sed -i -e "s/# core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\"/core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\/nightly\/linux\/armhf\/latest\/\"/" $INSTALL/etc/retroarch.cfg
  fi

  # Playlists
  echo "playlist_entry_rename = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "playlist_entry_remove = \"false\"" >> $INSTALL/etc/retroarch.cfg

  # Generic
  if [ "$PROJECT" = "Generic" ]; then
    echo "video_context_driver = \"khr_display\"" >> $INSTALL/etc/retroarch.cfg
#    echo "video_driver = \"vulkan\"" >> $INSTALL/etc/retroarch.cfg
  fi

  if [ "$DEVICE" = "OdroidGoAdvance" ]; then
    echo "xmb_layout = 2" >> $INSTALL/etc/retroarch.cfg
    echo "menu_widget_scale_auto = false" >> $INSTALL/etc/retroarch.cfg
    echo "menu_widget_scale_factor = 2.25" >> $INSTALL/etc/retroarch.cfg
  fi

  # GPICase
  if [ "$PROJECT" = "RPi" ] && [ "$DEVICE" = "GPICase" -o "$DEVICE" = "Pi02GPi" ]; then
    echo "audio_device = \"default:CARD=ALSA\"" >> $INSTALL/etc/retroarch.cfg
    echo "menu_timedate_enable = false" >> $INSTALL/etc/retroarch.cfg
    echo "menu_enable_widgets = false" >> $INSTALL/etc/retroarch.cfg
    sed -i -e "s/input_menu_toggle_gamepad_combo = 2/input_menu_toggle_gamepad_combo = 4/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/menu_driver = \"xmb\"/menu_driver = \"rgui\"/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# aspect_ratio_index = 19/aspect_ratio_index = 21/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# audio_out_rate = 48000/audio_out_rate = 44100/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# video_font_size = 32/video_font_size = 16/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/video_rotation = \"0\"/video_rotation = \"3\"/" $INSTALL/etc/retroarch.cfg

    if [ "$DEVICE" = "GPICase" ]; then
      sed -i -e "s/# video_scale_integer = false/video_scale_integer = true/" $INSTALL/etc/retroarch.cfg
      sed -i -e "s/video_threaded = true/video_threaded = false/" $INSTALL/etc/retroarch.cfg
    fi

    if [ "$DEVICE" = "Pi02GPi" ]; then
      echo 'input_player1_analog_dpad_mode = "3"' >> $INSTALL/etc/retroarch.cfg
    fi
  fi

  if [ "$DEVICE" = "RPi4-PiBoyDmg" -o "$DEVICE" = "RPi4-RetroDreamer" ]; then
    echo "menu_timedate_enable = false" >> $INSTALL/etc/retroarch.cfg
    echo "menu_scale_factor = \"1.44\"" >> $INSTALL/etc/retroarch.cfg
    sed -i -e "s/input_menu_toggle_gamepad_combo = .*$/input_menu_toggle_gamepad_combo = 4/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/menu_driver = .*$/menu_driver = \"ozone\"/" $INSTALL/etc/retroarch.cfg
  fi

  if [ "$PROJECT" = "NXP" -a "$DEVICE" = "iMX6" ]; then
    sed -i -e "s/# audio_device =/audio_device = \"default:CARD=DWHDMI\"/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu = false/audio_enable_menu = true/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_ok = false/audio_enable_menu_ok = true/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_cancel = false/audio_enable_menu_cancel = true/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# audio_enable_menu_notice = false/audio_enable_menu_notice = true/" $INSTALL/etc/retroarch.cfg
  fi

  # Switch
  if [ "$PROJECT" = "L4T" -a "$DEVICE" = "Switch" ]; then
    sed -i -e "s/# menu_pointer_enable = false/menu_pointer_enable = true/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# video_hard_sync = false/video_hard_sync = true/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# video_crop_overscan = true/video_crop_overscan = false/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# menu_show_online_updater = true/menu_show_online_updater = false/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/# input_joypad_driver =/input_joypad_driver = udev/" $INSTALL/etc/retroarch.cfg
    sed -i -e "s/video_threaded = true/video_threaded = false/" $INSTALL/etc/retroarch.cfg
    
    #Set Default Joycon index to Combined Joycons.
    sed -i -e "s/# input_player1_joypad_index = 0/input_player1_joypad_index = \"2\"/" $INSTALL/etc/retroarch.cfg

    #Set Joypad as joypad with analog
    sed -i -e "s/# input_libretro_device_p1 =/input_libretro_device_p1 = \"5\"/" $INSTALL/etc/retroarch.cfg
  fi
 
  # System overlay
  mkdir -p $INSTALL/usr/share/retroarch-system
    touch $INSTALL/usr/share/retroarch-system/.placeholder
}

post_install() {
  # link default.target to retroarch.target
  ln -sf retroarch.target $INSTALL/usr/lib/systemd/system/default.target

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
  mkdir -p $INSTALL/usr/lib/retroarch
    cp $PKG_DIR/scripts/retroarch-config $INSTALL/usr/lib/retroarch
}
