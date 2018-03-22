################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="adafruit-libraries"
PKG_VERSION=""
PKG_REV="105"
PKG_ARCH="any"
PKG_ADDON_PROJECTS="RPi"
PKG_LICENSE="MIT"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="Adafruit_Python_ADS1x15 Adafruit_Python_ADXL345 Adafruit_Python_BMP Adafruit_Python_CharLCD Adafruit_Python_DHT Adafruit_Python_GPIO Adafruit_Python_LED_Backpack Adafruit_Python_LSM303 Adafruit_Python_MCP3008 Adafruit_Python_MCP4725 Adafruit_Python_PCA9685 Adafruit_Python_PureIO Adafruit_Python_SI1145 Adafruit_Python_SSD1306 Adafruit_Python_TCS34725 Adafruit_Python_VCNL40xx Adafruit_Python_WS2801"
PKG_SECTION="virtual"
PKG_SHORTDESC="A bundle of libraries from Adafruit"
PKG_LONGDESC="This bundle currently includes Adafruit_ADS1x15, Adafruit_ADXL345, Adafruit_BMP, Adafruit_CharLCD, Adafruit_DHT, Adafruit_GPIO, Adafruit_LED_Backpack, Adafruit_LSM303, Adafruit_MCP3008, Adafruit_MCP4725, Adafruit_PCA9685, Adafruit_PureIO, Adafruit_SI1145, Adafruit_SSD1306, Adafruit_TCS34725, Adafruit_VCNL40xx and Adafruit_WS2801 python modules"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Adafruit Libraries"
PKG_ADDON_TYPE="xbmc.python.module"
PKG_ADDON_REQUIRES="virtual.rpi-tools:8.0.102"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
    cp -PR $(get_build_dir Adafruit_Python_ADS1x15)/Adafruit_ADS1x15           $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_ADXL345)/Adafruit_ADXL345           $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_BMP)/Adafruit_BMP                   $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_CharLCD)/Adafruit_CharLCD           $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_DHT)/build/lib.linux-*/Adafruit_DHT $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_GPIO)/Adafruit_GPIO                 $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_LED_Backpack)/Adafruit_LED_Backpack $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_LSM303)/Adafruit_LSM303             $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_MCP3008)/Adafruit_MCP3008           $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_MCP4725)/Adafruit_MCP4725           $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_PCA9685)/Adafruit_PCA9685           $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_PureIO)/Adafruit_PureIO             $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_SI1145)/SI1145                      $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_SSD1306)/Adafruit_SSD1306           $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_TCS34725)/Adafruit_TCS34725         $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_VCNL40xx)/Adafruit_VCNL40xx         $ADDON_BUILD/$PKG_ADDON_ID/lib/
    cp -PR $(get_build_dir Adafruit_Python_WS2801)/Adafruit_WS2801             $ADDON_BUILD/$PKG_ADDON_ID/lib/
}
