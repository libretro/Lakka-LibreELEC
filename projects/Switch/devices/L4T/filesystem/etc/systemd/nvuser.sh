#!/bin/bash

#
# Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
#

SCRIPT_NAME=$(basename "${0}")
if [ "$(whoami)" != "root" ]; then
	echo "${SCRIPT_NAME} - ERROR: Run this script as a root user"
	exit 1
fi

if [ -f "/etc/nvuser.conf" ]; then
	while IFS=':' read -r user uid; do
		grep -F "${user}" "/etc/group" > /dev/null
		if [ $? -eq 1 ]; then
			if [ -d "/home/${user}" ]; then
				useradd -G "sudo,video,audio,adm" -u "${uid}" \
				-s "/bin/bash" -p "$(echo "${user}" | openssl passwd -1 -stdin)" "${user}"
				cp -r "/etc/skel/." "/home/${user}"
				chown -R "${uid}:${uid}" "/home/${user}"
			else
				useradd -d "/home/${user}" -m -G "sudo,video,audio,adm" -u "${uid}" \
				-s "/bin/bash" -p "$(echo "${user}" | openssl passwd -1 -stdin)" "${user}"
			fi
		fi

		grep -F "gdm" "/etc/group" > /dev/null
		if [ $? -eq 0 ]; then
			groups "${user}" | grep -F "gdm" > /dev/null
			if [ $? -eq 1 ]; then
				addgroup "${user}" "gdm"
			fi
		fi
	done < "/etc/nvuser.conf"
fi

# Add gdm in video group in order to set correct permissions
grep -F "gdm" "/etc/group" > /dev/null
if [ $? -eq 0 ]; then
	groups "gdm" | grep -F "video" > /dev/null
	if [ $? -eq 1 ]; then
		addgroup "gdm" "video"
	fi
fi

# Force gdm login screen to use Xorg
if [ -e "/etc/gdm3/custom.conf" ]; then
	sed -i "/WaylandEnable=false/ s/^#//" "/etc/gdm3/custom.conf"
fi
