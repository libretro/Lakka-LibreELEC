#!/bin/bash

# Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights reserved.
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

set -e

# These variables define which set of protocols are supported. Each variable
# should be set to either 0 or 1. Note that Windows caches information about
# each USB device; if these values are changed, Windows users may need to
# manually uninstall drivers/devices using Device Manager, delete cached USB OS
# descriptors using regedit on HLKM\SYSTEM\CurrentControlSet\Control\UsbFlags,
# and delete cached OEM .inf files using pnputil -d. These actions require
# considerable care to avoid impacting other devices and drivers. Linux and
# MacOS do not appear to have this issue.
#
# If this script is modified in a way that alters information visible to the
# USB host (adding/removing/enabling/disabling/reordering protocols, or
# adding/removing/modifying OS descriptors), then the host must be informed of
# this by modifying the USB device identity:
#
# - NVIDIA engineers should increase the bcdDevice value that is written below.
#
# - NVIDIA customers MUST initially change the idVendor, idProduct values and
#   manufacturer and product strings that are set below and reset the bcdDevice
#   value to 1. Later modifications may simply increase the bcdDevice value.
#
# - In all cases, any associated Windows INF files MUST be updated to match the
#   changes made here, or Windows will not match the INF file against the HW.
#
# Ethernet using the RNDIS protocol.
# Linux: Supported automatically.
# Windows: Supported automatically via OS descriptors.
# MacOS: Requires the HoRNDIS driver to be installed.
enable_rndis=1
# CDC ACM serial port/UART.
# Linux: Supported automatically.
# Windows 10: Supported automatically.
# Windows other: Requires driver manual selection by use of l4t-serial.inf.
# Mac OS: Supported automatically.
enable_acm=1
# Ethernet using the CDC ECM protocol.
# Linux: Supported automatically.
# Windows: Not supported.
# Mac OS: Supported automatically.
enable_ecm=1
# USB Mass Storage (virtual disk drive/USB memory stick).
# Linux: Supported automatically.
# Windows: Supported automatically.
# Mac OS: Supported automatically.
enable_ums=1

# The IP address shared by all USB network interfaces created by this script.
net_ip=192.168.55.1
# The associated netmask.
net_mask=255.255.255.0
# The associated network address.
net_net=192.168.55.0
# The DHCP pool range
net_dhcp_start=192.168.55.100
net_dhcp_end=192.168.55.200
# The IPv6 address shared by all USB network interfaces created by this script.
# This should be a link-local address.
net_ipv6=fe80::1

# The disk image to export as a USB Mass Storage device
fs_img="/opt/nvidia/l4t-usb-device-mode/filesystem.img"

udc_dev_t210=700d0000.xudc
if [ -e "/sys/class/udc/${udc_dev_t210}" ]; then
    udc_dev="${udc_dev_t210}"
fi
udc_dev_t186=3550000.xudc
if [ -e "/sys/class/udc/${udc_dev_t186}" ]; then
    udc_dev="${udc_dev_t186}"
fi
if [ "${udc_dev}" == "" ]; then
    echo No known UDC device found
    exit 1
fi

mkdir -p /sys/kernel/config/usb_gadget/l4t
cd /sys/kernel/config/usb_gadget/l4t

# If this script is modified outside NVIDIA, the idVendor and idProduct values
# MUST be replaced with appropriate vendor-specific values.
echo 0x0955 > idVendor
echo 0x7020 > idProduct
# BCD value. Each nibble should be 0..9. 0x1234 represents version 12.3.4.
echo 0x0001 > bcdDevice

# Informs Windows that this device is a composite device, i.e. it implements
# multiple separate protocols/devices.
echo 0xEF > bDeviceClass
echo 0x02 > bDeviceSubClass
echo 0x01 > bDeviceProtocol

mkdir -p strings/0x409
cat /proc/device-tree/serial-number > strings/0x409/serialnumber
# If this script is modified outside NVIDIA, the manufacturer and product values
# MUST be replaced with appropriate vendor-specific values.
echo "NVIDIA" > strings/0x409/manufacturer
echo "Linux for Tegra" > strings/0x409/product

cfg=configs/c.1
mkdir -p "${cfg}"
cfg_str=""

# Note: RNDIS must be the first function in the configuration, or Windows'
# RNDIS support will not operate correctly.
if [ ${enable_rndis} -eq 1 ]; then
    cfg_str="${cfg_str}+RNDIS"
    func=functions/rndis.usb0
    mkdir -p "${func}"
    ln -sf "${func}" "${cfg}"

    # Informs Windows that this device is compatible with the built-in RNDIS
    # driver. This allows automatic driver installation without any need for
    # a .inf file or manual driver selection.
    echo 1 > os_desc/use
    echo 0xcd > os_desc/b_vendor_code
    echo MSFT100 > os_desc/qw_sign
    echo RNDIS > "${func}/os_desc/interface.rndis/compatible_id"
    echo 5162001 > "${func}/os_desc/interface.rndis/sub_compatible_id"
    ln -sf "${cfg}" os_desc
fi

# If two USB configs are created, and the second contains RNDIS and ACM, then
# Windows will ignore at the ACM function in that config. Consequently, this
# script creates only a single USB config.
if [ ${enable_acm} -eq 1 ]; then
    cfg_str="${cfg_str}+ACM"
    func=functions/acm.GS0
    mkdir -p "${func}"
    ln -sf "${func}" "${cfg}"
fi

if [ ${enable_ums} -eq 1 ]; then
    cfg_str="${cfg_str}+UMS"
    func=functions/mass_storage.0
    mkdir -p "${func}"
    ln -sf "${func}" "${cfg}"
    # Prevent users from corrupting the disk image; make it read-only
    echo 1 > "${func}/lun.0/ro"
    echo "${fs_img}" > "${func}/lun.0/file"
fi

if [ ${enable_ecm} -eq 1 ]; then
    cfg_str="${cfg_str}+ECM"
    func=functions/ecm.usb0
    mkdir -p "${func}"
    ln -sf "${func}" "${cfg}"
fi

mkdir -p "${cfg}/strings/0x409"
# :1 in the variable expansion strips the first character from the value. This
# removes the unwanted leading + sign. This simplifies the logic to construct
# $cfg_str above; it can always add a leading delimiter rather than only doing
# so unless the string is previously empty.
echo "${cfg_str:1}" > "${cfg}/strings/0x409/configuration"

echo "${udc_dev}" > UDC

# Ethernet devices require additional configuration. This must happen after the
# UDC device is assigned, since that triggers the creation of the Tegra-side
# Ethernet interfaces.
#
# This script always assigns any-and-all Ethernet devices to an Ethernet
# bridge, and assigns the static IP to that bridge. This allows the script to
# more easily handle the potentially variable set of Ethernet devices.
#
# If your custom use-case requires separate IP addresses per interface, or
# only ever has one interface active, you may modify this script to skip
# bridge creation, and assign IP address(es) directly to the interface(s).

/sbin/brctl addbr l4tbr0
/sbin/ifconfig l4tbr0 ${net_ip} netmask ${net_mask} up
/sbin/ifconfig l4tbr0 add ${net_ipv6}

if [ ${enable_rndis} -eq 1 ]; then
    /sbin/brctl addif l4tbr0 "$(cat functions/rndis.usb0/ifname)"
    /sbin/ifconfig "$(cat functions/rndis.usb0/ifname)" up
fi

if [ ${enable_ecm} -eq 1 ]; then
    /sbin/brctl addif l4tbr0 "$(cat functions/ecm.usb0/ifname)"
    /sbin/ifconfig "$(cat functions/ecm.usb0/ifname)" up
fi

cd - # Out of /sys/kernel/config/usb_gadget

# Create a local disk device that exposes the same filesystem image that's
# exported over USB. This will allow local users to see the files too.
/sbin/losetup -f -r "${fs_img}"

# Start a DHCP server so that connected systems automatically receive an IP
# address. This avoids users having to manually configure the connection, and
# also prevents Network Manager on Linux from destroying any manually applied
# configuration.
if [ -n "${net_dhcp_start}" ]; then
    cat > /opt/nvidia/l4t-usb-device-mode/dhcpd.conf <<ENDOFHERE
max-lease-time 120;
default-lease-time 120;

subnet ${net_net} netmask ${net_mask} {
    range ${net_dhcp_start} ${net_dhcp_end};
}
ENDOFHERE
    touch /opt/nvidia/l4t-usb-device-mode/dhcpd.leases
    /usr/sbin/dhcpd -cf /opt/nvidia/l4t-usb-device-mode/dhcpd.conf \
        -pf /opt/nvidia/l4t-usb-device-mode/dhcpd.pid \
        -lf /opt/nvidia/l4t-usb-device-mode/dhcpd.leases
fi

exit 0
