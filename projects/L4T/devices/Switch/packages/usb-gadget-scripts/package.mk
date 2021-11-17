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

PKG_NAME="usb-gadget-scripts"
#PKG_DEPENDS_TARGET="umtp-responder"
PKG_SHORTDESC="Nintendo Switch USB Gadget scripts, and configs"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/{usr/bin,usr/lib/systemd/system/}
    cp ${PKG_DIR}/assets/usb-gadget.sh ${INSTALL}/usr/bin/
    chmod +x ${INSTALL}/usr/bin/usb-gadget.sh
    cp ${PKG_DIR}/system.d/usb-gadget.service ${INSTALL}/usr/lib/systemd/system/
  #Enable Services
  enable_service usb-gadget.service
  enable_service usb-tty.service
}

