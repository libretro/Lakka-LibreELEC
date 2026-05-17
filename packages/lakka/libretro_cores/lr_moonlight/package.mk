PKG_NAME="lr_moonlight"
PKG_VERSION="9559c4279427442e1e48c31380ca247b0a44fd3a"
PKG_ARCH="aarch64 arm x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/GavinDarkglider/moonlight-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg opus cairo curl"
PKG_LONGDESC="Moonlight-libretro is a port of Moonlight Game Streaming Project for RetroArch platform."

# Pinned submodule revisions.
#
# moonlight-common-c at 15b55a4 is the oldest commit that exports
# LiGetLaunchUrlQueryParameters(), serverCodecModeSupport, rtspSessionUrl,
# supportedVideoFormats and VIDEO_FORMAT_MASK_10BIT -- all of which the
# Sunshine/modern-GFE protocol patch (libgamestream/client.c) needs to build.
# This is the same commit moonlight-nx uses, so it is well-tested with this
# code shape.
PKG_MOONLIGHT_COMMON_C_REV="15b55a441bf817a70ec86086d5bbba7b71a3344c"
# enet submodule of moonlight-common-c at the matching commit.
PKG_ENET_REV="c6bb0e50118d08252eee308de8412751218442d6"
# nanogui and json: keep the rock88/moonlight-libretro pins.
PKG_NANOGUI_REV="56eb83fd44745accc765171afb46a7c60abc3067"
# ext/nanovg pin recorded by rock88/nanogui at PKG_NANOGUI_REV.
PKG_NANOVG_REV="bf2320d1175122374a9b806d91e9e666c9336375"
PKG_JSON_REV="a50a14088c5c131d57f6dd6f91741da49c1ce426"
# libretro-common: master HEAD is fine, the libretro.h API and glsym sources
# are backwards-compatible. Pin if you want reproducible builds.
PKG_LIBRETRO_COMMON_REV="master"

if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
  PKG_MAKE_OPTS_TARGET="platform=lakka-switch TOOLCHAIN=${TOOLCHAIN}"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

# LibreELEC's git unpack does not fetch submodules. Pull them here, with
# the gitlinks bumped to the commits the patches expect. This runs BEFORE
# the patch step.
post_unpack() {
  local d="${PKG_BUILD}/third_party"

  # moonlight-common-c -- bumped commit + its enet submodule.
  rm -rf "${d}/moonlight-common-c"
  git clone https://github.com/moonlight-stream/moonlight-common-c.git \
    "${d}/moonlight-common-c"
  ( cd "${d}/moonlight-common-c"
    git checkout "${PKG_MOONLIGHT_COMMON_C_REV}"
    rm -rf enet
    git clone https://github.com/cgutman/enet.git enet
    ( cd enet && git checkout "${PKG_ENET_REV}" )
    rm -rf .git enet/.git
  )

  # nanogui (rock88's fork) -- pinned to the rock88/moonlight-libretro pin.
  # The build only needs nanogui itself plus its ext/nanovg nested submodule.
  # ext/glfw, ext/nanovg_metal and ext/pybind11 are NOT needed for the libretro
  # build, so don't waste time/bandwidth on them.
  rm -rf "${d}/nanogui"
  git clone https://github.com/rock88/nanogui.git "${d}/nanogui"
  ( cd "${d}/nanogui"
    git checkout "${PKG_NANOGUI_REV}"
    rm -rf ext/nanovg
    git clone https://github.com/wjakob/nanovg.git ext/nanovg
    ( cd ext/nanovg && git checkout "${PKG_NANOVG_REV}" )
    rm -rf .git ext/nanovg/.git
  )

  # nlohmann/json -- pinned to the rock88/moonlight-libretro pin.
  rm -rf "${d}/json"
  git clone https://github.com/nlohmann/json.git "${d}/json"
  ( cd "${d}/json"
    git checkout "${PKG_JSON_REV}"
    rm -rf .git
  )

  # libretro-common -- new dependency for the
  # "use-upstream-libretro-common" patch (deletes vendored src/libretro.h
  # and src/glsym/ in favour of these).
  rm -rf "${d}/libretro-common"
  git clone https://github.com/libretro/libretro-common.git \
    "${d}/libretro-common"
  ( cd "${d}/libretro-common"
    [ "${PKG_LIBRETRO_COMMON_REV}" != "master" ] && \
      git checkout "${PKG_LIBRETRO_COMMON_REV}"
    rm -rf .git
  )
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v moonlight_libretro.so ${INSTALL}/usr/lib/libretro/
    cp -v ${PKG_DIR}/assets/moonlight_libretro.info ${INSTALL}/usr/lib/libretro/
}
