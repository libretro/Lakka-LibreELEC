#!/bin/bash

#
# Copyright (c) 2016-2019, NVIDIA CORPORATION.  All rights reserved.
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

SCRIPT_NAME=$(basename "${0}")
if [ "$(whoami)" != "root" ]; then
	echo "${SCRIPT_NAME} - ERROR: Run this script as a root user"
	exit 1
fi

# power state
if [ -e /sys/power/state ]; then
	chmod 0666 /sys/power/state
fi

# Set minimum cpu freq.
if [ -e /sys/devices/soc0/family ]; then
	CHIP="`cat /sys/devices/soc0/family`"
	if [[ ${CHIP} =~ "Tegra21" ]]; then
		SOCFAMILY="tegra210"
	fi

	if [ -e /sys/devices/soc0/machine ]; then
		machine=`cat /sys/devices/soc0/machine`
	fi
elif [ -e "/proc/device-tree/compatible" ]; then
	if [ -e /proc/device-tree/model ]; then
		machine="`cat /proc/device-tree/model`"
	fi
	CHIP="`cat /proc/device-tree/compatible`"
	if [[ ${CHIP} =~ "tegra186" ]]; then
		SOCFAMILY="tegra186"
	elif [[ ${CHIP} =~ "tegra210" ]]; then
		SOCFAMILY="tegra210"
	elif [[ ${CHIP} =~ "tegra194" ]]; then
		SOCFAMILY="tegra194"
	fi
fi

if [ "$SOCFAMILY" = "tegra194" ]; then
	sudo bash -c "ln -sf /etc/X11/xorg.conf.t194_ref /etc/X11/xorg.conf"
elif [ "$machine" = "jetson_tx1" ] || [ "$machine" = "jetson_e" ]; then
	sudo bash -c "ln -sf /etc/X11/xorg.conf.jetson_e /etc/X11/xorg.conf"
fi

if [ "$SOCFAMILY" = "Tegra13" ] &&
	[ -e /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq ]; then
	bash \
		-c "echo -n 510000 > \
		/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq"
fi

# CPU hotplugging
# Bug 200220039 disables cluster switching for T210
if [ "$SOCFAMILY" != "tegra210" ]; then
	if [ -d /sys/kernel/tegra_auto_cluster_switch ] ; then
		echo 500 > /sys/kernel/tegra_auto_cluster_switch/down_delay_msec
		echo 1 > /sys/kernel/tegra_auto_cluster_switch/enable
	elif [ -d /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet ] ; then
		echo 500 > /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/down_delay
		echo 1 > /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/enable
	elif [ -w /sys/module/cpu_tegra3/parameters/auto_hotplug ] ; then
		# compatibility for prior kernels without cpuquiet support
		echo 1 > /sys/module/cpu_tegra3/parameters/auto_hotplug
	fi
fi

# Remove the spawning of ondemand service
if [ -e "/etc/systemd/system/multi-user.target.wants/ondemand.service" ]; then
	rm -f "/etc/systemd/system/multi-user.target.wants/ondemand.service"
fi

# lp2 idle state
if [ -e /sys/module/cpuidle/parameters/power_down_in_idle ] ; then
	echo "Y" > /sys/module/cpuidle/parameters/power_down_in_idle
elif [ -e /sys/module/cpuidle/parameters/lp2_in_idle ] ; then
	# compatibility for prior kernels
	echo "Y" > /sys/module/cpuidle/parameters/lp2_in_idle
fi

# mmc read ahead size
if [ -e /sys/block/mmcblk0/queue/read_ahead_kb ]; then
	echo 2048 > /sys/block/mmcblk0/queue/read_ahead_kb
fi

if [ -e /sys/block/mmcblk1/queue/read_ahead_kb ]; then
	echo 2048 > /sys/block/mmcblk1/queue/read_ahead_kb
fi

CPU_INTERACTIVE_GOV=0
CPU_SCHEDUTIL_GOV=0

if [ -e /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors ]; \
	then
	read governors < \
		/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors

	case $governors in
		*interactive*)
			CPU_INTERACTIVE_GOV=1
		;;
	esac

	case $governors in
		*schedutil*)
			 CPU_SCHEDUTIL_GOV=1
        ;;
    esac
fi

if [[ ! -e "/sys/kernel/debug/bpmp/debug" && -e "/sys/kernel/debug/bpmp/mount" ]]; then
	cat "/sys/kernel/debug/bpmp/mount"
fi

case $SOCFAMILY in
	tegra210 | tegra186 | tegra194)
		if [ $CPU_SCHEDUTIL_GOV -eq 1 ]; then
			for scaling_governor in \
				/sys/devices/system/cpu/cpu[0-7]/cpufreq/scaling_governor; do
				echo schedutil > $scaling_governor
			done
			if [ -e /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us ]; \
				then
				echo 2000 > \
					/sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
			fi
			if [ -e /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us ]; then
				echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us
			fi
			if [ -e /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us ]; then
				echo 500 > /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us
			fi
			if [ -e /sys/devices/system/cpu/cpufreq/schedutil/capacity_margin ]; then
				echo 1024 > /sys/devices/system/cpu/cpufreq/schedutil/capacity_margin
			fi
		elif [ $CPU_INTERACTIVE_GOV -eq 1 ]; then
			for scaling_governor in \
				/sys/devices/system/cpu/cpu[0-7]/cpufreq/scaling_governor; do
				echo interactive > $scaling_governor
			done
		fi
		;;
	*)
		;;
esac

if [ "$SOCFAMILY" = "tegra186" ]; then
	if [[ -d "/sys/kernel/debug/bpmp/debug/clk/nafll_se/" ]]; then
		echo 1 > /sys/kernel/debug/bpmp/debug/clk/nafll_se/mrq_rate_locked
		cat /sys/kernel/debug/bpmp/debug/clk/nafll_se/min_rate > \
			/sys/kernel/debug/bpmp/debug/clk/nafll_se/rate
	fi

	if [ -f "/sys/devices/17000000.gp10b/railgate_enable" ]; then
		echo 0 > /sys/devices/17000000.gp10b/railgate_enable
	fi

fi

# create /etc/nvpmodel.conf symlink
if [ ! -e "/etc/nvpmodel.conf" ]; then
	conf_file=""
	if [ "${SOCFAMILY}" = "tegra186" ]; then
		if [ "${machine}" = "storm" ]; then
			use_case_model="`cat /proc/device-tree/use_case_model`"
			if [ "${use_case_model}" = "ucm1" ]; then
				conf_file="/etc/nvpmodel/nvpmodel_t186_storm_ucm1.conf"
			elif [ "${use_case_model}" = "ucm2" ]; then
				conf_file="/etc/nvpmodel/nvpmodel_t186_storm_ucm2.conf"
			fi
		else
			conf_file="/etc/nvpmodel/nvpmodel_t186.conf"
		fi
	elif [ "${SOCFAMILY}" = "tegra194" ]; then
		conf_file="/etc/nvpmodel/nvpmodel_t194.conf"
	elif [ "${SOCFAMILY}" = "tegra210" ]; then
		if [ "${machine}" = "jetson-nano" ]; then
			conf_file="/etc/nvpmodel/nvpmodel_t210_jetson-nano.conf"
		else
			conf_file="/etc/nvpmodel/nvpmodel_t210.conf"
		fi
	fi

	if [ "${conf_file}" != "" ]; then
		if [ -e "${conf_file}" ]; then
			ln -sf "${conf_file}" /etc/nvpmodel.conf
		else
			echo "${SCRIPT_NAME} - WARNING: file ${conf_file} not found!"
		fi
	fi
fi

# Lock SE clock at MinFreq to reduce vdd_soc power
if [ "${SOCFAMILY}" = "tegra194" ]; then
	if [ -d "/sys/kernel/debug/bpmp/debug/clk/nafll_se" ]; then
		echo 1 > /sys/kernel/debug/bpmp/debug/clk/nafll_se/mrq_rate_locked
		cat /sys/kernel/debug/bpmp/debug/clk/nafll_se/min_rate > \
			/sys/kernel/debug/bpmp/debug/clk/nafll_se/rate
	fi
fi

# Ensure libglx.so is not overwritten by a distribution update of Xorg
# Alternatively, package management tools could be used to prevent updates
ARCH=`/usr/bin/dpkg --print-architecture`
if [ "x${ARCH}" = "xarm64" ]; then
	LIB_DIR="/usr/lib/aarch64-linux-gnu"
fi

# Disable lazy vfree pages
if [ -e "/proc/sys/vm/lazy_vfree_pages" ]; then
	echo 0 > "/proc/sys/vm/lazy_vfree_pages"
fi

# WAR for https://bugs.launchpad.net/ubuntu/+source/mesa/+bug/1776499
# When DISABLE_MESA_EGL="1" glvnd will not load mesa EGL library.
# When DISABLE_MESA_EGL="0" glvnd will load mesa EGL library.
# nvidia EGL library is prioritized over mesa even if DISABLE_MESA_EGL="0".
DISABLE_MESA_EGL="1"
if [ -f "/usr/share/glvnd/egl_vendor.d/50_mesa.json" ]; then
	if  [ "${DISABLE_MESA_EGL}" -eq "1" ]; then
		sed -i "s/\"library_path\" : .*/\"library_path\" : \"\"/g" \
			"/usr/share/glvnd/egl_vendor.d/50_mesa.json"
	else
		sed -i "s/\"library_path\" : .*/\"library_path\" : \"libEGL_mesa.so.0\"/g" \
			"/usr/share/glvnd/egl_vendor.d/50_mesa.json"
	fi
fi

# Add gdm in video group
grep "gdm" "/etc/group" > /dev/null
if [ $? -eq 0 ]; then
	groups "gdm" | grep "video" > /dev/null
	if [ $? -eq 1 ]; then
		addgroup "gdm" "video"
	fi
fi

if [ -e "/var/lib/lightdm" ]; then
	sudo chown lightdm:lightdm /var/lib/lightdm -R
fi

# Ensure weston package is not overwritten
if [ -e "${LIB_DIR}/tegra/weston/desktop-shell.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/desktop-shell.so" "${LIB_DIR}/weston/desktop-shell.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/drm-backend.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/drm-backend.so" "${LIB_DIR}/weston/drm-backend.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/eglstream-backend.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/eglstream-backend.so" "${LIB_DIR}/weston/eglstream-backend.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/gl-renderer.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/gl-renderer.so" "${LIB_DIR}/weston/gl-renderer.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/hmi-controller.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/hmi-controller.so" "${LIB_DIR}/weston/hmi-controller.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/ivi-controller.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/ivi-controller.so" "${LIB_DIR}/weston/ivi-controller.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/ivi-shell.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/ivi-shell.so" "${LIB_DIR}/weston/ivi-shell.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/wayland-backend.so" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/wayland-backend.so" "${LIB_DIR}/weston/wayland-backend.so"
fi

if [ -e "${LIB_DIR}/tegra/weston/libilmClient.so.2.0.0" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/libilmClient.so.2.0.0" "${LIB_DIR}/libilmClient.so.2.0.0"
fi

if [ -e "${LIB_DIR}/tegra/weston/libilmCommon.so.2.0.0" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/libilmCommon.so.2.0.0" "${LIB_DIR}/libilmCommon.so.2.0.0"
fi

if [ -e "${LIB_DIR}/tegra/weston/libilmControl.so.2.0.0" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/libilmControl.so.2.0.0" "${LIB_DIR}/libilmControl.so.2.0.0"
fi

if [ -e "${LIB_DIR}/tegra/weston/libilmInput.so.2.0.0" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/libilmInput.so.2.0.0" "${LIB_DIR}/libilmInput.so.2.0.0"
fi

if [ -e "${LIB_DIR}/tegra/weston/libinput.so.10.10.1" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/libinput.so.10.10.1" "${LIB_DIR}/libinput.so.10.10.1"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-desktop-shell" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-desktop-shell" "/usr/lib/weston/weston-desktop-shell"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-keyboard" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-keyboard" "/usr/lib/weston/weston-keyboard"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-screenshooter" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-screenshooter" "/usr/lib/westonweston-screenshooter"
fi

if [ -e "${LIB_DIR}/tegra/weston/EGLWLInputEventExample" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/EGLWLInputEventExample" "/usr/bin/EGLWLInputEventExample"
fi

if [ -e "${LIB_DIR}/tegra/weston/EGLWLMockNavigation" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/EGLWLMockNavigation" "/usr/bin/EGLWLMockNavigation"
fi

if [ -e "${LIB_DIR}/tegra/weston/LayerManagerControl" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/LayerManagerControl" "/usr/bin/LayerManagerControl"
fi

if [ -e "${LIB_DIR}/tegra/weston/spring-tool" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/spring-tool" "/usr/bin/spring-tool"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston" "/usr/bin/weston"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-calibrator" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-calibrator" "/usr/bin/weston-calibrator"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-clickdot" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-clickdot" "/usr/bin/weston-clickdot"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-cliptest" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-cliptest" "/usr/bin/weston-cliptest"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-dnd" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-dnd" "/usr/bin/weston-dnd"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-eventdemo" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-eventdemo" "/usr/bin/weston-eventdemo"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-flower" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-flower" "/usr/bin/weston-flower"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-fullscreen" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-fullscreen" "/usr/bin/weston-fullscreen"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-image" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-image" "/usr/bin/weston-image"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-info" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-info" "/usr/bin/weston-info"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-ivi-shell-user-interface" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-ivi-shell-user-interface" "/usr/bin/weston-ivi-shell-user-interface"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-launch" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-launch" "/usr/bin/weston-launch"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-multi-resource" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-multi-resource" "/usr/bin/weston-multi-resource"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-resizor" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-resizor" "/usr/bin/weston-resizor"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-scaler" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-scaler" "/usr/bin/weston-scaler"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-simple-egl" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-simple-egl" "/usr/bin/weston-simple-egl"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-simple-shm" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-simple-shm" "/usr/bin/weston-simple-shm"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-simple-touch" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-simple-touch" "/usr/bin/weston-simple-touch"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-smoke" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-smoke" "/usr/bin/weston-smoke"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-stacking" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-stacking" "/usr/bin/weston-stacking"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-subsurfaces" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-subsurfaces" "/usr/bin/weston-subsurfaces"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-terminal" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-terminal" "/usr/bin/weston-terminal"
fi

if [ -e "${LIB_DIR}/tegra/weston/weston-transformed" ]; then
	ln -sf "${LIB_DIR}/tegra/weston/weston-transformed" "/usr/bin/weston-transformed"
fi
