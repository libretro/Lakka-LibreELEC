#!/bin/bash

# Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


# description: "NVIDIA bluetooth/wifi init script"

if [ -f "/proc/bluetooth/sleep/lpm" ] ; then
	echo 1 > /proc/bluetooth/sleep/lpm
fi

if [ -f "/var/run/nvbcm" ] ; then
	. /var/run/nvbcm
fi

if [ -e "/usr/sbin/brcm_patchram_plus" ] ; then
	if [ "$BCMCHIP" = "0x4329" ]; then
		exec /usr/sbin/brcm_patchram_plus \
			--enable_hci --scopcm=0,2,0,0,0,0,0,0,0,0 \
			--baudrate 3000000 --patchram /lib/firmware/bcm4329.hcd \
			--enable_lpm --tosleep=50000 /dev/ttyTHS2
	elif [ "$BCMCHIP" = "0x4330" ]; then
		exec /usr/sbin/brcm_patchram_plus \
			--enable_hci --use_baudrate_for_download \
			--scopcm=0,2,0,0,0,0,0,0,0,0 --baudrate 3000000 \
			--patchram /lib/firmware/bcm4330.hcd --no2bytes \
			--enable_lpm --tosleep=50000 /dev/ttyTHS2
	elif [ "$BCMCHIP" = "0x4324" ]; then
		exec /usr/sbin/brcm_patchram_plus \
			--enable_hci --use_baudrate_for_download \
			--scopcm=0,2,0,0,0,0,0,0,0,0 --baudrate 3000000 \
			--patchram /lib/firmware/bcm4324.hcd --no2bytes \
			--enable_lpm --tosleep=50000 /dev/ttyTHS2
	elif [ "$BCMCHIP" = "0x4354" ]; then
		exec /usr/sbin/brcm_patchram_plus \
			--enable_hci --use_baudrate_for_download \
			--scopcm=0,2,0,0,0,0,0,0,0,0 --baudrate 3000000 \
			--patchram /lib/firmware/bcm4354.hcd --no2bytes \
			--enable_lpm --tosleep=50000 /dev/ttyTHS3
	elif [ "$BCMCHIP" = "0x4356" ]; then
		exec /usr/sbin/brcm_patchram_plus \
			--enable_hci --use_baudrate_for_download \
			--scopcm=0,2,0,0,0,0,0,0,0,0 --baudrate 3000000 \
			--patchram /lib/firmware/bcm4356.hcd --no2bytes \
			--enable_lpm --tosleep=50000 /dev/ttyTHS4
	fi
fi
