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
                anarch \
                ardens \
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
                dice \
                dinothawr \
                dirksimple \
                dolphin \
                dosbox \
                dosbox_core \
                dosbox_pure \
                dosbox_svn \
                doukutsu_rs \
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
                holani \
                jaxe \
                jumpnbump \
                kronos \
                lowres_nx \
                lr_moonlight \
                lrps2 \
                lutro \
                m2000 \
                mame \
                mame2000 \
                mame2003_plus \
                mame2010 \
                mame2015 \
                melonds \
                melondsds \
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
                noods \
                np2kai \
                numero \
                nxengine \
                o2em \
                openlara \
                opera \
                panda3ds \
                parallel_n64 \
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
                pzretro \
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
                tamalibretro \
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
                virtualxt \
                vitaquake2 \
                vitaquake3 \
                wasm4 \
                xmil \
                xrick \
                yabasanshiro \
                yabause \
               "

# List of libretro cores to start compiling as
# early as possible, as they take longer to compile
EARLY_START_LR_CORES="\
                      mame \
                      scummvm \
                      mame2015 \
                      mame2010 \
                      same_cdi \
                      vice \
                      dolphin \
                      ppsspp \
                      panda3ds \
                      fbneo \
                     "

# put early start cores to the front of the list
# first remove them, to avoid duplicates
for core in ${EARLY_START_LR_CORES} ; do
  LIBRETRO_CORES="${LIBRETRO_CORES// ${core} /}"
done

# prepend the list
LIBRETRO_CORES="${EARLY_START_LR_CORES} ${LIBRETRO_CORES}"

# override above with custom list via env CUSTOM_LIBRETRO_CORES="core1 core2"
# passed to make
if [ -n "${CUSTOM_LIBRETRO_CORES}" ]; then
  LIBRETRO_CORES="${CUSTOM_LIBRETRO_CORES}"
fi

# disable cores that do not build for OPENGLES
if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  EXCLUDE_LIBRETRO_CORES+=" kronos"
fi

# disable cores based on PROJECT/DEVICE
if [ "${PROJECT}" = "Allwinner" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
                            vitaquake3"

elif [ "${PROJECT}" = "Amlogic" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
                            vitaquake3"

elif [ "${PROJECT}" = "Ayn" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
                            vitaquake3"

elif [ "${PROJECT}" = "Generic" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
			    vitaquake3"

elif [ "${PROJECT}" = "L4T" ]; then
  EXCLUDE_LIBRETRO_CORES+=" citra \
                            lr_moonlight \
                            mame \
                            melondsds \
                            np2kai \
                            panda3ds \
                            stella"

elif [ "${PROJECT}" = "NXP" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
                            vitaquake3"

elif [ "${PROJECT}" = "Rockchip" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
                            vitaquake3"

elif [ "${PROJECT}" = "RPi" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
                            vitaquake3"

  if [ "${DEVICE}" = "RPi" -o "${DEVICE}" = "RPiZero-GPiCase" ]; then
    EXCLUDE_LIBRETRO_CORES+=" beetle_bsnes \
                              beetle_psx \
                              beetle_saturn \
                              beetle_vb \
                              bk_emulator \
                              boom3 \
                              bsnes \
                              bsnes2014 \
                              bsnes_hd \
                              bsnes_mercury \
                              desmume \
                              desmume_2015 \
                              dice \
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
                              mame \
                              mame2003_plus \
                              mame2010 \
                              mame2015 \
                              melonds \
                              melondsds \
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
                              yabause"

  elif [ "${DEVICE}" = "RPi2" ]; then
    EXCLUDE_LIBRETRO_CORES+=" play"

  elif [ "${DEVICE}" = "RPiZero2-GPiCase" ]; then
    EXCLUDE_LIBRETRO_CORES+=" boom3 \
                              openlara \
                              play \
                              ppsspp \
                              vircon32 \
                              swanstation \
                              yabasanshiro"
  fi

elif [ "${PROJECT}" = "Samsung" ]; then
  EXCLUDE_LIBRETRO_CORES+=" lr_moonlight \
                            vitaquake3"
fi

# disable cores that require rust until rust:host works for arm and i386
if [ "${TARGET_ARCH}" = "arm" -o "${TARGET_ARCH}" = "i386" ]; then
  EXCLUDE_LIBRETRO_CORES+=" doukutsu_rs \
                            holani"
fi

# exclude some cores at build time via env EXCLUDE_LIBRETRO_CORES="core1 core2"
# passed to make and cores added to the env above
if [ -n "${EXCLUDE_LIBRETRO_CORES}" ]; then
  for core in ${EXCLUDE_LIBRETRO_CORES} ; do
    LIBRETRO_CORES="${LIBRETRO_CORES// ${core} /}"
  done
fi

# temporary disabled due to build error
for core in np2kai ; do
  LIBRETRO_CORES="${LIBRETRO_CORES// ${core} /}"
done

# finally set package dependencies
PKG_DEPENDS_TARGET="${LIBRETRO_CORES}"
