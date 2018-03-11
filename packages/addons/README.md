#add-on package.mk skeleton
This file shows a skeleton example of an add-on package.mk with content notes. Except for the license header, any lines prefixed with `#` are optional and may be omitted if not required.

```shell
################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="myprogram"                               # same as the folder name
PKG_VERSION="1.0.1"                                # version or 7 digit-hash
PKG_REV="100"                                      # currently we start at 100 to solve OE update problems
PKG_ARCH="any"                                     # for available architectures, see LE/config/arch.* files
# PKG_ADDON_PROJECTS="any !RPi1 !Amlogic"          # for available projects or devices, see projects subdirectory (note: Use RPi for RPi project, and RPi1 for RPi device)
PKG_LICENSE="GPL"                                  # program licenses, see licenses subdirectory for a list
PKG_SITE="http://www.site.org"
PKG_URL="http://www.site.org/$PKG_VERSION.tar.xz"  # for github see the other packages, prefer tar.xz over .gz
# PKG_SOURCE_DIR="somename-${PKG_VERSION}*"        # if the folder inside the zip is different to the pkg name
PKG_DEPENDS_TARGET="toolchain curl"                # dependencies that are needed that the addon builds
PKG_SECTION="service"                              # service, tools, virtual, driver, driver.remote ...
PKG_SHORTDESC="Addon name: sort description"       # Addon: is a program that does this and that
PKG_LONGDESC="Addon name ($PKG_VERSION): detailed description"
PKG_TOOLCHAIN="auto"                               # auto, meson, cmake, cmake-make, configure, make, ninja, autotools, manual

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Addon name"                        # proper name of the addon that is shown at the repo
PKG_ADDON_TYPE="xbmc.service"                      # see LE/config/addon/ for other possibilities
# PKG_ADDON_PROVIDES="executable"                  # http://kodi.wiki/view/addon.xml#.3Cprovides.3E_element
PKG_ADDON_REPOVERSION="8.0"                        # for what main version it should be compatible
# PKG_ADDON_REQUIRES="some.addon:0.0.0"            # http://kodi.wiki/view/addon.xml#.3Crequires.3E
# PKG_MAINTAINER="John Doe (email)"                # if you want to be know as maintainer for a addon
```
