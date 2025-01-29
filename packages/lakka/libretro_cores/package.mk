PKG_NAME="libretro_cores"
PKG_LICENSE="GPL"
PKG_SITE="https://www.lakka.tv"
PKG_SECTION="virtual"
PKG_LONGDESC="Root package used to select libretro cores"

# List of libretro cores
LIBRETRO_CORES="\
                2048 \
                81 \
                a5200 \
                atari800 \
                beetle_bsnes \
                beetle_lynx \
                beetle_ngp \
                beetle_pce \
                beetle_pce_fast \
                beetle_pcfx \
                beetle_psx \
                beetle_saturn \
                beetle_supafaust \
                beetle_supergrafx \
                beetle_vb \
                beetle_wswan \
                blastem \
                bluemsx \
                bnes \
                boom3 \
                bsnes \
                bsnes2014 \
                bsnes_hd \
                bsnes_mercury \
                cannonball \
                cap32 \
                chailove \
                citra \
                craft \
                crocods \
                daphne \
                desmume \
                desmume_2015 \
                dinothawr \
                dirksimple \
                dolphin \
                dosbox \
                dosbox_core \
                dosbox_pure \
                dosbox_svn \
                easyrpg \
                emux_sms\
                ecwolf \
                ep128emu \
                fake_08 \
                fbalpha2012 \
                fbneo \
                fceumm \
                flycast \
                fmsx \
                freechaf \
                freeintv \
                fuse_libretro \
                gambatte \
                gearboy \
                gearsystem \
                genesis_plus_gx \
                genesis_plus_gx_wide \
                geolith \
                gme \
                gpsp \
                gw_libretro \
                handy \
                hatari \
                higan_sfc \
                higan_sfc_balanced \
                jaxe \
                jumpnbump \
                kronos \
                lowres_nx \
                lr_moonlight \
                lutro \
                mame \
                mame2000 \
                mame2003_plus \
                mame2010 \
                mame2015 \
                melonds \
                meowpc98 \
                mesen \
                mesen_s \
                mgba \
                mgba_fork \
                mojozork \
                mrboom \
                mu \
                mupen64plus_next \
                neocd \
                nestopia \
                np2kai \
                numero \
                nxengine \
                o2em \
                openlara \
                opera \
                parallel_n64 \
                pcsx2 \
                pcsx_rearmed \
                picodrive \
                play \
                pocketcdg \
                pokemini \
                potator \
                ppsspp \
                prboom \
                prosystem \
                puae \
                puae2021 \
                px68k \
                quasi88 \
                quicknes \
                race \
                reminiscence \
                retro8 \
                same_cdi \
                sameboy \
                sameduck \
                scummvm \
                snes9x \
                snes9x2002 \
                snes9x2005 \
                snes9x2005_plus \
                snes9x2010 \
                stella \
                stella2014 \
                superbroswar \
                swanstation \
                tgbdual \
                theodore \
                thepowdertoy \
                tic80 \
                tyrquake \
                uae4arm \
                uzem \
                vbam \
                vecx \
                vice \
                vircon32 \
                virtualjaguar \
                vitaquake2 \
                vitaquake3 \
                wasm4 \
                xmil \
                xrick \
                yabasanshiro \
                yabause \
               "

# disable cores based on PROJECT/DEVICE
if [ "${PROJECT}" = "RPi" ]; then
  if [ "${DEVICE}" = "RPi" -o "${DEVICE}" = "RPiZero-GPiCase" ]; then
    EXCLUDE_LIBRETRO_CORES+="\
                             beetle_bsnes \
                             beetle_psx \
                             beetle_saturn \
                             beetle_vb \
                             bk_emulator \
                             bsnes \
                             bsnes2014 \
                             bsnes_hd \
                             bsnes_mercury \
                             citra \
                             desmume \
                             desmume_2015 \
                             dolphin \
                             dosbox \
                             dosbox_core \
                             dosbox_pure \
                             dosbox_svn \
                             fbneo \
                             flycast \
                             genesis_plus_gx \
                             higan_sfc \
                             higan_sfc_balanced \
                             kronos \
                             mame \
                             mame2003_plus \
                             mame2010 \
                             mame2015 \
                             melonds \
                             meowpc98 \
                             mesen \
                             mesen_s \
                             mupen64plus_next \
                             openlara \
                             opera \
                             parallel_n64 \
                             play \
                             ppsspp \
                             puae \
                             same_cdi \
                             snes9x \
                             snes9x2005_plus \
                             snes9x2010 \
                             swanstation \
                             uae4arm \
                             vbam \
                             virtualjaguar \
                             vircon32 \
                             vitaquake2 \
                             yabasanshiro \
                             yabause \
                            "
  elif [ "${DEVICE}" = "RPi2" ]; then
    EXCLUDE_LIBRETRO_CORES+=" play"
  elif [ "${DEVICE}" = "RPiZero2-GPiCase" ]; then
    EXCLUDE_LIBRETRO_CORES+=" kronos openlara play ppsspp vircon32 swanstation"
  fi
elif [ "${PROJECT}" = "Generic" -a "${ARCH}" = "i386" ]; then
  EXCLUDE_LIBRETRO_CORES+=" fake_08 openlara"
elif [ "${PROJECT}" = "Ayn" -a "${DEVICE}" = "Odin" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight"
elif [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
  EXCLUDE_LIBRETRO_CORES+=" stella"
fi

# disable cores that are only for specific targets
# fbalpha2012 and mame2000 only for RPi/RPiZero-GPiCase
if [ "${PROJECT}" != "RPi" ]; then
  EXCLUDE_LIBRETRO_CORES+=" fbalpha2012 mame2000"
elif [ "${DEVICE}" != "RPi" -a "${DEVICE}" != "RPiZero-GPiCase" ]; then
  EXCLUDE_LIBRETRO_CORES+=" fbalpha2012 mame2000"
fi
# boom3 and vitaquake for now only for Switch
if [ "${PROJECT}" != "L4T" -a "${DEVICE}" != "Switch" ]; then
  EXCLUDE_LIBRETRO_CORES+=" boom3 vitaquake3"
fi

# lr_moonlight only for Switch
if [ "${PROJECT}" != "L4T" -a "${DEVICE}" != "Switch" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight"
fi

# lr_moonlight does not currently build for Switch because of newer OpenSSL package (older package is not compatible with ffmpeg)
if [ "${DEVICE}" = "Switch" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight"
fi

# disable cores that do not build for OPENGLES
if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  EXCLUDE_LIBRETRO_CORES+=" kronos"
fi

# exclude some cores at build time via env EXCLUDE_LIBRETRO_CORES="..." passed to make
if [ -n "${EXCLUDE_LIBRETRO_CORES}" ]; then
  for core in ${EXCLUDE_LIBRETRO_CORES} ; do
    LIBRETRO_CORES="${LIBRETRO_CORES// ${core} /}"
  done
fi

# override above with custom list via env CUSTOM_LIBRETRO_CORES="..." passed to make
if [ -n "${CUSTOM_LIBRETRO_CORES}" ]; then
  LIBRETRO_CORES="${CUSTOM_LIBRETRO_CORES}"
fi

# temporary disabled due to build error with gcc14  for all targets except Switch (uses older gcc)
if [ ! "${PROJECT}" = "L4T" -a ! "${DEVICE}" = "Switch" ]; then
  for core in citra dolphin ecwolf np2kai pcsx2 same_cdi ; do
    LIBRETRO_CORES="${LIBRETRO_CORES// ${core} /}"
  done
fi

# finally set package dependencies
PKG_DEPENDS_TARGET="${LIBRETRO_CORES}"
