#!/bin/bash
# -*- tab-width: 4; sh-indentation: 4; sh-basic-offset: 4; indent-tabs-mode: t; -*-
#
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
#
# PHS: L4T system setup and general setup for thermal zones.
#
# Fail early, fail fast.
# set -e
# Also be verbose about the failing command should we exit early due
# to the -e flag. As an exception, do silence any prints during the +e
# flag.
# set -E
# trap 'set -o | egrep -q "^errexit[[:space:]]+on" && \
# echo "*** ERROR:${BASH_SOURCE}:${BASH_LINENO}: \
# script aborting due to failing exit status from: \"${BASH_COMMAND}\""' ERR
# Check for root privileges
[ "$(id -u)" == "0" ] || { echo >&2 "*** ERROR: $0 must run as root"; exit 1; }
# PHS runs as this user.
#
# TODO: this should be 'daemon' or something more unprivileged but
# that change depends on tweaking a lot of sysfs node permissions.
phsuser=root
# We expect to find 'nvsetprop' in /usr/sbin/
PATH="${PATH}:/usr/sbin"
mkdir -p "/run/nvphs/properties"
chmod 0775 "/run/nvphs" "/run/nvphs/properties"
chown "${phsuser}" "/run/nvphs" "/run/nvphs/properties"
mkdir -p "/var/lib/nvphs"
chmod 0775 "/var/lib/nvphs"
chown "${phsuser}" "/var/lib/nvphs"
# These commands will fail on thermal zones missing some of the
# referenced nodes. Lift -e to avoid exiting unnecessarily.
# set +e
# Thermal zones:
# Make the name (type) of the thermal zone readable by nvphsd.
# Make temperature (temp) readable by nvphsd.
# Make trip points (trip_point_*) writable by nvphsd.
for tz in /sys/class/thermal/thermal_zone*
do
	if [ -e "${tz}" ]; then
		chown "${phsuser}" "${tz}/type" 2> /dev/null
		chmod 0444 "${tz}/type" 2> /dev/null
		chown "${phsuser}" "${tz}/temp" 2> /dev/null
		chmod 0444 "${tz}/temp" 2> /dev/null
		chown "${phsuser}" "${tz}"/trip_point_*_temp 2> /dev/null
		chmod 0664 "${tz}"/trip_point_*_temp 2> /dev/null
		chown "${phsuser}" "${tz}"/trip_point_*_hyst 2> /dev/null
		chmod 0664 "${tz}"/trip_point_*_hyst 2> /dev/null
	fi
done
# set -e
exit 0