#!/bin/bash

# Copyright (c) 2012-2013, NVIDIA CORPORATION.  All rights reserved.
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

# do not use "set -e" as we want script to continue for logging purposes

SCRIPT_NAME=`basename $0`
EXTENDED_INFO=0
SAVED_FLAGS=$@
LOG_FILENAME=nvidia-bug-report-tegra.log
LOG_FILE_LOCATION=${HOME}/${LOG_FILENAME}
DISTRIBUTION_NAME=""
DISTRO_VERSION_FILES="
/etc/issue
/etc/redhat-release
/etc/redhat_version
/etc/fedora-release
/etc/slackware-release
/etc/slackware-version
/etc/debian_release
/etc/debian_version
/etc/mandrake-release
/etc/yellowdog-release
/etc/sun-release
/etc/release
/etc/gentoo-release
"

function addtosysteminfotxt {
	TXT_TO_ADD="$1"

	echo "${TXT_TO_ADD}" >> ${LOG_FILE_LOCATION}
	echo "" >> ${LOG_FILE_LOCATION}
	echo "" >> ${LOG_FILE_LOCATION}
}

function usage_bug_report_message {
	echo "Please include the '$LOG_FILE_LOCATION' log file when reporting"
	echo "your bug via the NVIDIA Developer Zone forums (see https://devtalk.nvidia.com)"
	echo "or by sending email to 'linux-tegra-bugs@nvidia.com'."
}

function add_file_info_to_log {
        FILE_LIST=("/proc/cpuinfo" "/proc/interrupts" "/proc/meminfo" \
                        "/proc/modules" "/proc/iomem" "/proc/partitions" \
                        "/proc/vmstat" "/sys/kernel/debug/clock/clock_tree" \
                        "/sys/kernel/debug/tegra_dma" \
                        "/sys/kernel/debug/tegra_gpio" "/sys/kernel/debug/tegra_pinmux" \
                         "/sys/kernel/debug/tegra_pinmux_drive" )

        for file in "${FILE_LIST[@]}"
        do
                if [ -e "${file}" ]; then
                        echo "____________________________________________"                    \
                                >> ${LOG_FILE_LOCATION}
                        echo "='${file}' information=" >> ${LOG_FILE_LOCATION}
                        addtosysteminfotxt "$(cat ${file})"
                fi
        done
}

# show the usages text
function usage {
	echo "Use: $SCRIPT_NAME [--extended-info|-e] [--output-file|-o] [--help|-h]"
	echo ""
	usage_bug_report_message
	echo ""
cat <<EOF
    NVIDIA 'Linux for Tegra' bug reporting shell script.
    Options are:
    --extended-info|-e
                   output additional debug info to logfile
    --output-file|-o <file>
                   Write output to <file>.
                   Default: write to nvidia-bug-report-tegra.log
    --help|-h
                   show this help
EOF
}

# parse arguments
while [ "$1" != "" ]; do
    case $1 in
        -o | --output-file )    if [ -z $2 ]; then
                                    usage
                                    exit 1
                                elif [ "$(echo "$2" | cut -c 1)" = "-" ]; then
                                    echo "Warning: Questionable filename"\
                                         "\"$2\": possible missing argument?"
                                fi
                                LOG_FILE_LOCATION="$2"
                                shift
                                ;;
        -e | --extended-info )  EXTENDED_INFO=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done


#
# Start of script
#

# check that we are root (needed for accessing kernel log files at
# /sys/kernel/debug and also on ChromeOS for ifconfig -a)

if [ `id -u` -ne 0 ]; then
	echo "ERROR: Please run ${SCRIPT_NAME} as root."
	exit 1
fi

# now that we now we are root user, we can access this
CPUIDLE_LIST=$(ls /sys/kernel/debug/cpuidle)

# move any old log file out of the way
if [ -f "${LOG_FILE_LOCATION}" ]; then
	echo "Previous log present at:"
	echo "        ${LOG_FILE_LOCATION}"
	echo "Backing up older log at:"
	echo "        ${LOG_FILE_LOCATION}.old.$(date -r ${LOG_FILE_LOCATION} +%Y%m%d%H%M%S)"
	mv ${LOG_FILE_LOCATION} ${LOG_FILE_LOCATION}.old.$(date -r ${LOG_FILE_LOCATION} +%Y%m%d%H%M%S)
	echo ""
	echo ""
fi

# make sure what we can write to the log file
touch ${LOG_FILE_LOCATION} 2> /dev/null

if [ $? -ne 0 ]; then
	echo ""
	echo "ERROR: ${LOG_FILE_LOCATION} not writable; please use a location"
	echo "       where you have write permission so that the ${LOG_FILE_LOCATION}"
	echo "       file can be written."
	echo ""
	exit 1
fi

# print a start message to stdout
echo ""
echo "${SCRIPT_NAME} will now collect information about your"
echo "system and create the file '${LOG_FILE_LOCATION}'"
echo "It may take several seconds to run."
echo ""
usage_bug_report_message
echo ""
echo -n "Running ${SCRIPT_NAME}...";
echo ""

echo ""
echo "Creating logfile:"
echo "        ${LOG_FILE_LOCATION}"
echo ""

# print prologue to the log file
echo "____________________________________________"                    >  ${LOG_FILE_LOCATION}
echo ""                                                                >> ${LOG_FILE_LOCATION}
echo "Start of NVIDIA bug report for Tegra log file.  Please send this">> ${LOG_FILE_LOCATION}
echo "report along with a description of your bug, to"                 >> ${LOG_FILE_LOCATION}
echo "linux-tegra-bugs@nvidia.com."                                    >> ${LOG_FILE_LOCATION}
echo ""                                                                >> ${LOG_FILE_LOCATION}
echo "command line flags: ${SAVED_FLAGS}"                              >> ${LOG_FILE_LOCATION}
echo ""                                                                >> ${LOG_FILE_LOCATION}

# print date in logfile
date >> ${LOG_FILE_LOCATION}
echo "" >> ${LOG_FILE_LOCATION}
echo "" >> ${LOG_FILE_LOCATION}

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "=kernel version=" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(uname -r)"

#
# kernel K340 and later have board information on the next 4 items available
#
echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "=Any board specific information will be listed below (if available)=" >> ${LOG_FILE_LOCATION}
# SoC Family: e.g Tegra2, Tegra3, TegraXXX etc.
if [ -r "/sys/bus/soc/devices/soc0/family" ] ; then
	echo "/sys/bus/soc/devices/soc0/family:" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /sys/bus/soc/devices/soc0/family)"
fi

# SoC Machine: e.g Cardu, ventana, etc.
if [ -r "/sys/bus/soc/devices/soc0/machine" ] ; then
	echo "/sys/bus/soc/devices/soc0/machine:" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /sys/bus/soc/devices/soc0/machine)"
fi

# SoC Revision: e.g A02, A03P etc.
if [ -r "/sys/bus/soc/devices/soc0/revision" ] ; then
	echo "/sys/bus/soc/devices/soc0/revision:" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /sys/bus/soc/devices/soc0/revision)"
fi

# SoC soc_id: e.g string format is like Revision:SKU:PackageID etc.
if [ -r "/sys/bus/soc/devices/soc0/soc_id" ] ; then
	echo "/sys/bus/soc/devices/soc0/soc_id:" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /sys/bus/soc/devices/soc0/soc_id)"
fi

echo "" >> ${LOG_FILE_LOCATION}
echo "" >> ${LOG_FILE_LOCATION}

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "='uname -a' information=" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(uname -a)"

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "=kernel command line" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(cat /proc/cmdline)"

if [ -e "/etc/lsb-release" ] ; then
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "=/etc/lsb-release information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /etc/lsb-release)"
	DISTRIBUTION_NAME=$(cat /etc/lsb-release | grep "DISTRIB_ID" | cut -d '=' -f 2)
	if [ $(cat /etc/lsb-release | grep "CHROMEOS_RELEASE_NAME=Chromium OS" -c) = 1 ] ; then
		DISTRIBUTION_NAME="Chromium OS"
	fi
fi

LSUSB=`which lsusb || true`
if [ ! -x "${LSUSB}" ] ; then
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "You may wish to install lsusb for detailed usb log information." | tee -a ${LOG_FILE_LOCATION}
	if [ "${DISTRIBUTION_NAME}" = "Ubuntu" ] ; then
		echo "This can be done by running the following line:" | tee -a ${LOG_FILE_LOCATION}
		echo "sudo apt-get install usbutils" | tee -a ${LOG_FILE_LOCATION}
	fi

	echo "" >> ${LOG_FILE_LOCATION} | tee -a ${LOG_FILE_LOCATION}
	echo "" >> ${LOG_FILE_LOCATION} | tee -a ${LOG_FILE_LOCATION}
else
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "='lsusb' information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(lsusb)"
fi

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "='df -h' device space information=" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(df -h)"

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "='ifconfig -a' information=" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(ifconfig -a)"

if [ -e "/etc/nv_tegra_release" ] ; then
	# inside this "if" means system is L4T or has L4T drivers present

	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "=NVIDIA L4T /etc/nv_tegra_release information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /etc/nv_tegra_release)"

	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "=NVIDIA L4T /etc/nv_tegra_release Validation check=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(sha1sum -c /etc/nv_tegra_release 2> /dev/null)"
fi

add_file_info_to_log

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "='ls -lah /sys/bus/i2c/devices/' information=" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(ls -lah /sys/bus/i2c/devices/)"

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "='ls -1 /sys/bus/i2c/drivers' information=" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(ls -1 /sys/bus/i2c/drivers)"

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "='lsmod' information=" >> ${LOG_FILE_LOCATION}
addtosysteminfotxt "$(lsmod)"

for i in ${CPUIDLE_LIST} ; do
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "='/sys/kernel/debug/cpuidle/$i' information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /sys/kernel/debug/cpuidle/$i)"
done

# go through the list of distro version/release information
for i in ${FIND_LISTING} ; do
        if [ -e "$i" ] ; then
		echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
		echo "='$i' information=" >> ${LOG_FILE_LOCATION}
		addtosysteminfotxt "$(cat $i)"
	fi
done

# may not be present if X has not been started
if [ -e "/var/log/Xorg.0.log" ] ; then
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "='/var/log/Xorg.0.log' information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /var/log/Xorg.0.log)"

	# ChromiumOS has a config directory not an xorg.conf
	if [ "${DISTRIBUTION_NAME}" != "Chromium OS" ] ; then
		# include a copy of the "xorg.conf" file
		echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
		echo "='Xorg.conf' information=" >> ${LOG_FILE_LOCATION}
		XORG_CONF_LOCATION=$(cat /var/log/Xorg.0.log | grep "Using config file" | cut -f 2 -d \")
		addtosysteminfotxt "$(cat ${XORG_CONF_LOCATION})"
	fi

	# only outputs data if DISPLAY=: is set
	if [ ! -z "$DISPLAY" ] ; then
		XSET=`which xset || true`
		if [ -x "${XSET}" ] ; then
			echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
			echo "='xset -q' information=" >> ${LOG_FILE_LOCATION}

			xset -q >> ${LOG_FILE_LOCATION}
			# The xset process is still there.
			echo "" >> ${LOG_FILE_LOCATION}
			echo "" >> ${LOG_FILE_LOCATION}
		fi
	fi

	XDPYINFO=`which xdpyinfo || true`
	if [ ! -x "${XDPYINFO}" ] ; then
		echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
		echo "You may wish to install xdpyinfo for additional X information." | tee -a ${LOG_FILE_LOCATION}
		if [ "${DISTRIBUTION_NAME}" = "Ubuntu" ] ; then
			echo "This can be done by running the following line:" | tee -a ${LOG_FILE_LOCATION}
			echo "sudo apt-get install x11-xserver-utils" | tee -a ${LOG_FILE_LOCATION}
		fi

		echo "" >> ${LOG_FILE_LOCATION} | tee -a ${LOG_FILE_LOCATION}
		echo "" >> ${LOG_FILE_LOCATION} | tee -a ${LOG_FILE_LOCATION}
	else
		echo "='xdpyinfo' information=" >> ${LOG_FILE_LOCATION}
		xdpyinfo >> ${LOG_FILE_LOCATION}
		echo "" >> ${LOG_FILE_LOCATION}
		echo "" >> ${LOG_FILE_LOCATION}
	fi
fi

if [ -e "/var/log/kern.log" ] ; then
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "='/var/log/kern.log' information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /var/log/kern.log)"
fi

echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
echo "='dmesg' information=" >> ${LOG_FILE_LOCATION}
dmesg >> ${LOG_FILE_LOCATION}
echo "" >> ${LOG_FILE_LOCATION}
echo "" >> ${LOG_FILE_LOCATION}

GUNZIP=`which gunzip || true`
if [ ! -x "${GUNZIP}" ] ; then
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "='/proc/config.gz' information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(gunzip < /proc/config.gz)"
fi

if [ "${DISTRIBUTION_NAME}" = "Chromium OS" ] ; then
	if [ ! -z "$(cat /var/log/boot.log)" ] ; then
		echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
		echo "='/var/log/boot.log' information=" >> ${LOG_FILE_LOCATION}
		addtosysteminfotxt "$(cat /var/log/boot.log)"
	fi

	if [ ! -z "$(cat /var/log/faillog)" ] ; then
		echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
		echo "='/var/log/faillog' information=" >> ${LOG_FILE_LOCATION}
		addtosysteminfotxt "$(cat /var/log/faillog)"
	fi

	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "='/var/log/ui/ui.LATEST' information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /var/log/ui/ui.LATEST)"

	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "='/var/log/chrome/chrome' information=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(cat /var/log/chrome/chrome)"
fi

if [ "${EXTENDED_INFO}" = "1" ] ; then
	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "=Checking if ping at www.nvidia.com responds=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(ping -c 1 www.nvidia.com)"

	echo "____________________________________________"                    >> ${LOG_FILE_LOCATION}
	echo "=Detailed list of all running processes=" >> ${LOG_FILE_LOCATION}
	addtosysteminfotxt "$(ps -AF)"
fi



# print epilogue to log file
echo ""                                                                >> ${LOG_FILE_LOCATION}
echo "End of NVIDIA bug report log file."                              >> ${LOG_FILE_LOCATION}


# Done

echo ""
echo ""
echo "Complete."
echo ""
echo "The file ${LOG_FILE_LOCATION} has been created; please send this report,"
echo "along with a description of your bug, to linux-tegra-bugs@nvidia.com."
echo ""
