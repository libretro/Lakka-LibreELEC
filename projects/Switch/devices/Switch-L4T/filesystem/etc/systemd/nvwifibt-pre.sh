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

SUBTASK=$1

# pci subsystem for 4356 broadcom wifi/bt chip sends 0x43ec
# as device id instead of 0x4356, this if else makes it to
# follow the naming convention of the .hcd file

if [ "$2" = "0x43ec" ]; then
	BCMCHIP="0x4356"
else
	BCMCHIP=$2
fi

RET=1

if [ "$SUBTASK" = "register" ]; then
	if [ "x$BCMCHIP" != "x" ]; then
		if [ ! -f /var/run/nvbcm ]; then
			# record the type of chip
			echo "BCMCHIP=${BCMCHIP}" > /var/run/nvbcm
		fi
		RET=0
	fi
	exit $RET
fi

if [ -x /usr/sbin/brcm_patchram_plus -a -r /var/run/nvbcm -a -w /proc/bluetooth/sleep/lpm ]; then
	. /var/run/nvbcm
	for chip in 4329 4330 4324 4354 4356; do
		if [ "x0x$chip" = "x$BCMCHIP" -a -f "/lib/firmware/bcm$chip.hcd" ]; then
			RET=0
			break
		fi
	done
fi

if [ "$RET" != "0" ]; then
	stop
fi

exit $RET
