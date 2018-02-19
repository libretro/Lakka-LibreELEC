#!/bin/bash

FW_TARGET_DIR=$1

# The following files will be installed by brcmfmac_sdio-firmware-rpi instead
rm -fr $FW_TARGET_DIR/brcm/brcmfmac43430*-sdio.bin
rm -fr $FW_TARGET_DIR/brcm/brcmfmac43455*-sdio.bin

exit 0
