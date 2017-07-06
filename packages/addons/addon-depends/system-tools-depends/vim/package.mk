################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vim"
PKG_VERSION="8.0.0684"
PKG_ARCH="any"
PKG_LICENSE="VIM"
PKG_SITE="http://www.vim.org/"
PKG_URL="https://github.com/vim/vim/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_SECTION="tools"
PKG_SHORTDESC="vim: VI IMproved"
PKG_LONGDESC="Vim is a highly configurable text editor built to enable efficient text editing."
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="vim_cv_getcwd_broken=no \
                           vim_cv_memmove_handles_overlap=yes \
                           vim_cv_stat_ignores_slash=yes \
                           vim_cv_terminfo=yes \
                           vim_cv_tgent=zero \
                           vim_cv_toupper_broken=no \
                           vim_cv_tty_group=world \
                           vim_cv_tty_mode=0620 \
                           ac_cv_sizeof_int=4 \
                           ac_cv_small_wchar_t=no \
			   --enable-selinux=no \
                           --enable-gui=no \
                           --with-compiledby=LibreELEC \
                           --with-features=huge \
                           --with-tlib=ncurses \
                           --without-x"

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
  export LIBS="-lcurses -lterminfo"
}

make_target() {
  :
}
