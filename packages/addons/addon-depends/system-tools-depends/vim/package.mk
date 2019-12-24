# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vim"
PKG_VERSION="8.1.2384"
PKG_SHA256="f17462971e577063552cd4dbbebeb84e77a9fb47cd40c6234969e7672aebcd59"
PKG_LICENSE="VIM"
PKG_SITE="http://www.vim.org/"
PKG_URL="https://github.com/vim/vim/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Vim is a highly configurable text editor built to enable efficient text editing."

PKG_CONFIGURE_OPTS_TARGET="vim_cv_getcwd_broken=no \
                           vim_cv_memmove_handles_overlap=yes \
                           vim_cv_stat_ignores_slash=yes \
                           vim_cv_terminfo=yes \
                           vim_cv_tgetent=zero \
                           vim_cv_toupper_broken=no \
                           vim_cv_tty_group=world \
                           vim_cv_tty_mode=0620 \
                           ac_cv_sizeof_int=4 \
                           ac_cv_small_wchar_t=no \
                           --datarootdir=/storage/.kodi/addons/virtual.system-tools/data \
                           --disable-nls \
                           --enable-selinux=no \
                           --enable-gui=no \
                           --with-compiledby=LibreELEC \
                           --with-features=huge \
                           --with-tlib=ncurses \
                           --without-x"

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
}

make_target() {
  :
}

post_makeinstall_target() {
  (
  cd $INSTALL/storage/.kodi/addons/virtual.system-tools/data/vim/vim*
  rm -r doc tutor gvimrc_example.vim
  mv vimrc_example.vim ../vimrc
  )
}
