#!/bin/bash
################################################################################
#  This file is part of OpenELEC - http://www.openelec.tv
#  Copyright (C) 2011-2013 Christian Hewitt (chewitt@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

blink(){
  atvclient &>/dev/null &
}

check_verbose(){
  exec 1>/dev/console
  exec 2>/dev/console
  if [ -f /mnt/openelec/enable_verbose ]; then
    exec 3>&1
    exec 4>&2
  else
    exec 3> /dev/null
    exec 4> /dev/null
  fi
}

check_debug(){
  if [ -f /mnt/rootfs/enable_debug ]; then
    echo "        INFO: Script debugging enabled"
    set -x
  fi
}

check_function(){
  FUNCTION=$(cat /mnt/rootfs/function)
}

check_bootdevice(){
  SDA=$(ls /dev/sda)
  SDB=$(ls /dev/sdb)
  BOOTDEVICE=$(cat /proc/mounts | grep /mnt/rootfs | awk '{print $1}' | sed 's/[0-9]//g')
  if [ -n "${SDA}" -a -n "${SDB}" ]; then
    # AppleTV has USB and HDD devices
    if [ "${BOOTDEVICE}" = "/dev/sda" ]; then
      # AppleTV has a SATA adapter the kernel recognises slowly
      USB="/dev/sda"
      HDD="/dev/sdb"
      SLOWBOOT="TRUE"
    else
      # AppleTV has a normal setup
      USB="/dev/sdb"
      HDD="/dev/sda"
    fi
  else
    # AppleTV has no HDD
    USB="/dev/sda"
    HDD="/dev/sda"
    NOHDD="TRUE"
  fi
}

banner(){
  clear
  echo ""
  echo ""
  echo ""
  echo "        ********************************************************************************"
  echo "        *                                                                              *"
  case $FUNCTION in
    factoryrestore) echo "        *                       OpenELEC AppleTV Factory Restore                       *" ;;
    update)         echo "        *                            OpenELEC AppleTV Updater                          *" ;;
    emergency)      echo "        *                        OpenELEC AppleTV Emergency Boot                       *" ;;
    *)              echo "        *                           OpenELEC AppleTV Installer                         *" ;;
  esac
  echo "        *                                                                              *"
  echo "        ********************************************************************************"
  echo ""
}

get_partition_end(){
  local PARTITION=$1
  PARTITION_END=$(parted -s "${TARGET}" print -m | egrep "^${PARTITION}" | cut -d ":" -f 3)
  strip_alpha_characters "${PARTITION_END}"
  PARTITION_END="${STRIPPED}"
}

strip_alpha_characters(){
  local TEXT=$1
  STRIPPED=$(echo "${TEXT}" | sed 's/[^.0-9]//g')
}

disk_sync(){
  partprobe "${TARGET}" 1>&3 2>&4
  sync 1>&3 2>&4
}

network(){
  ifconfig eth0 0.0.0.0
  /sbin/udhcpc --now 1>&3 2>&4
  sleep 4
  IPADDRESS=$(ifconfig | head -n 2 | grep inet | awk '{print $2}' | sed 's/addr://g')
  if [ "${IPADDRESS}" = "" ]; then
    ERROR="noipaddress"
    error
  else  
    echo "        INFO: Leased ipv4 address ${IPADDRESS} from DHCP server"
  fi
}

prepare(){
  case $FUNCTION in
    factoryrestore)
      if [ ! -d /mnt/rootfs/restore ]; then
        echo ""
        echo "        FAIL: No restore files!"
        echo ""
        error
      fi
    ;;
    *)
      if [ ! -f /mnt/rootfs/MACH_KERNEL -a ! -f /mnt/rootfs/SYSTEM ]; then
        network
        DOWNLOAD=$(wget -qO- "http://update.openelec.tv/updates.php?i=INSTALLER&d=OpenELEC&pa=ATV.i386&v=3.1.0" | \
                   sed 's/{"data":{"update":"//g' | sed 's/","folder":"releases"}}//g' | grep OpenELEC-ATV)
        echo ""
        echo "        INFO: Downloading ${DOWNLOAD}"
        echo ""
        wget -O /mnt/rootfs/${DOWNLOAD} http://releases.openelec.tv/${DOWNLOAD}
        tar -xvf /mnt/rootfs/${DOWNLOAD} -C /mnt/rootfs 1>&3 2>&4
		FOLDER=$(echo ${DOWNLOAD} | sed 's/.tar//g')
        mv /mnt/rootfs/${FOLDER}/target/MACH_KERNEL /mnt/rootfs/ 1>&3 2>&4
        mv /mnt/rootfs/${FOLDER}/target/MACH_KERNEL.md5 /mnt/rootfs/ 1>&3 2>&4
        mv /mnt/rootfs/${FOLDER}/target/SYSTEM /mnt/rootfs/ 1>&3 2>&4
        mv /mnt/rootfs/${FOLDER}/target/SYSTEM.md5 /mnt/rootfs/ 1>&3 2>&4
        rm -rf /mnt/rootfs/${FOLDER} 1>&3 2>&4
      fi
      SUM1=$(md5sum /mnt/rootfs/MACH_KERNEL | awk '{print $1}')
      SUM2=$(cat /mnt/rootfs/MACH_KERNEL.md5 | awk '{print $1}')
      SUM3=$(md5sum /mnt/rootfs/SYSTEM | awk '{print $1}')
      SUM4=$(cat /mnt/rootfs/SYSTEM.md5 | awk '{print $1}')
      if [ "${SUM1}" != "${SUM2}" -o "${SUM3}" != "${SUM4}" -o -z "${SUM2}" -o -z "${SUM4}" ]; then
        ERROR="badchecksum"
        error
      fi
      rm /mnt/rootfs/MACH_KERNEL.md5 1>&3 2>&4
      rm /mnt/rootfs/SYSTEM.md5 1>&3 2>&4
    ;;
  esac
}

create_target(){
  echo ""
  dd if=/dev/zero of=${TARGET} bs=512 count=40 1>&3 2>&4
  disk_sync
  echo "        INFO: Creating GPT Scheme"
  parted -s ${TARGET} mklabel gpt 1>&3 2>&4
}

create_boot(){
  echo "        INFO: Creating BOOT Partition"
  PARTITION="1"
  parted -s ${TARGET} mkpart primary HFS 40s 409600s 1>&3 2>&4
  parted -s ${TARGET} set ${PARTITION} atvrecv on 1>&3 2>&4
  parted -s ${TARGET} name ${PARTITION} 'BOOT' 1>&3 2>&4
  disk_sync
  mkfs.hfsplus -s -v "BOOT" ${TARGET}${PARTITION} 1>&3 2>&4
  fsck.hfsplus -y ${TARGET}${PARTITION} 1>&3 2>&4
  BOOT=$(mktemp -d "/tmp/mounts.XXXXXX")
  mount ${TARGET}${PARTITION} ${BOOT} 1>&3 2>&4
  PARTITION=$(( ${PARTITION} + 1 ))
}

create_boot_usb(){
  echo "        INFO: Creating BOOT Partition"
  PARTITION="1"
  parted -s ${TARGET} mkpart primary HFS 40s 1048542s 1>&3 2>&4
  parted -s ${TARGET} set ${PARTITION} atvrecv on 1>&3 2>&4
  parted -s ${TARGET} name ${PARTITION} 'BOOT' 1>&3 2>&4
  disk_sync
  PARTITION=$(( ${PARTITION} + 1 ))
}

create_storage(){
  echo "        INFO: Creating STORAGE Partition"
  P1_END=$(parted -s ${TARGET} unit s print | grep atvrecv | awk '{print $3}' | sed 's/s//g')
  P2_START=$(( ${P1_END} + 1 ))
  DRIVE_END=$(parted -s ${TARGET} unit s print | grep ${TARGET} | awk '{print $3}' | sed 's/s//g')
  SWAP_SIZE=$(( 512 * 1024 * 1024 / 512 )) # 512MB in bytes / 512 byte sectors
  if [ "${SWAP}" = "TRUE" -a "${FUNCTION}" = "install-hdd" ]; then
    P2_END=$(( ${DRIVE_END} - ${SWAP_SIZE} - 40 ))
  else
    P2_END=$(( ${DRIVE_END} - 40 ))
  fi
  parted -s ${TARGET} mkpart primary ext4 ${P2_START}s ${P2_END}s 1>&3 2>&4
  parted -s ${TARGET} name ${PARTITION} 'STORAGE' 1>&3 2>&4
  disk_sync
  mkfs.ext4 -L "STORAGE" ${TARGET}${PARTITION} 1>&3 2>&4
  fsck.ext4 -y ${TARGET}${PARTITION} 1>&3 2>&4
  STORAGE=$(mktemp -d "/tmp/mounts.XXXXXX")
  mount ${TARGET}${PARTITION} ${STORAGE} 1>&3 2>&4
  PARTITION=$(( ${PARTITION} + 1 ))
}

create_swap(){
  if [ "${SWAP}" = "TRUE" ]; then
    echo "        INFO: Creating LINUX-SWAP Partition"
    P2_END=$(parted -s ${TARGET} unit s print | grep STORAGE | awk '{print $3}' | sed 's/s//g')
    DRIVE_END=$(parted -s ${TARGET} unit s print | grep ${TARGET} | awk '{print $3}' | sed 's/s//g')
    P3_START=$(( ${P2_END} + 1 ))
    P3_END=$(( ${DRIVE_END} - 40 ))
    parted -s ${TARGET} mkpart primary linux-swap ${P3_START}s ${P3_END}s 1>&3 2>&4
    parted -s ${TARGET} name ${PARTITION} 'LINUX-SWAP' 1>&3 2>&4
    mkswap ${TARGET}${PARTITION} 1>&3 2>&4
    disk_sync
  fi
}

install_hdd(){
  TARGET=${HDD}
  SWAP="TRUE"
  echo ""
  echo "        WARN: Continuing with installation will replace the original Apple OS or current"
  echo "              Linux OS on the AppleTV's internal hard drive with OpenELEC. If you do not"
  echo "              want installation to contine please POWER OFF your AppleTV within the next"
  echo "              30 seconds and remove the USB key."
  catnap
  create_target
  create_boot
  create_storage
  create_swap
  echo "        INFO: Creating BOOT Files"
  cp -av /mnt/rootfs/boot.efi "${BOOT}"/ 1>&3 2>&4
  cp -av /mnt/rootfs/BootLogo.png "${BOOT}"/ 1>&3 2>&4
  cp -Rv /mnt/rootfs/System "${BOOT}"/ 1>&3 2>&4
  cp -av /mnt/rootfs/MACH_KERNEL "${BOOT}"/ 1>&3 2>&4
  cp -av /mnt/rootfs/SYSTEM "${BOOT}"/ 1>&3 2>&4
  if [ "${SLOWBOOT}" = "TRUE" ]; then
    cp -av /mnt/rootfs/com.apple.Boot.usb "${BOOT}"/com.apple.Boot.plist 1>&3 2>&4
  else
    cp -av /mnt/rootfs/com.apple.Boot.hdd "${BOOT}"/com.apple.Boot.plist 1>&3 2>&4
  fi
  chown root:root "${BOOT}"/* 1>&3 2>&4
  mkdir -p ${STORAGE}/.update 1>&3 2>&4
  mkdir -p ${STORAGE}/.cache/services 1>&3 2>&4
  echo SSHD_START=true > ${STORAGE}/.cache/services/ssh.conf
  # for systemd testing we also need to touch sshd.conf
  touch ${STORAGE}/.cache/services/sshd.conf
  remove_temp_mounts 1>&3 2>&4
  echo ""
  echo "        INFO: Installation Completed!"
  echo ""
  echo "        INFO: Ignore the warnings below as we reboot :)"
  echo ""
}

install_usb(){
  TARGET=${USB}
  SWAP="FALSE"
  create_target
  create_boot_usb
  create_storage
  if [ "${NOHDD}" = "TRUE" ]; then
    cp -av /mnt/rootfs/com.apple.Boot.hdd /mnt/rootfs/com.apple.Boot.plist 1>&3 2>&4
  else
    cp -av /mnt/rootfs/com.apple.Boot.usb /mnt/rootfs/com.apple.Boot.plist 1>&3 2>&4
  fi
  mkdir -p ${STORAGE}/.update 1>&3 2>&4
  mkdir -p ${STORAGE}/.cache/services 1>&3 2>&4
  echo SSHD_START=true > ${STORAGE}/.cache/services/ssh.conf
  # for systemd testing we also need to touch sshd.conf
  touch ${STORAGE}/.cache/services/sshd.conf
  remove_temp_mounts 1>&3 2>&4
  echo ""
  echo "        INFO: Installation Completed!"
  echo ""
  echo "        INFO: Ignore the warnings below as we reboot :)"
  echo ""
}

update(){
  echo ""
  echo "        INFO: Checking ${HDD}1 Filesystem for Errors"
  fsck.hfsplus ${HDD}1 1>&3 2>&4
  # echo "        INFO: Checking ${HDD}2 Filesystem for Errors"
  # fsck.ext4 ${HDD}2 1>&3 2>&4
  mkdir -p /mnt/boot 1>&3 2>&4
  echo "        INFO: Mounting BOOT Partition"
  mount -t hfsplus -o rw,force ${HDD}1 /mnt/boot 1>&3 2>&4
  echo "        INFO: Updating MACH_KERNEL and SYSTEM"
  cp -av /mnt/rootfs/MACH_KERNEL /mnt/boot/ 1>&3 2>&4
  cp -av /mnt/rootfs/SYSTEM /mnt/boot/ 1>&3 2>&4
  echo ""
  echo "        INFO: Files updated!"
  echo ""
  echo "        INFO: Ignore the warnings below as we reboot :)"
  echo ""
}

factoryrestore(){
  DISKSIZE=$(parted -s ${HDD} unit s print | grep "Disk ${HDD}:" | awk '{print $3}' | sed 's/s//g')
  let SECTORS="${DISKSIZE}"-262145
  echo "        WARN: Continuing with restore will erase OpenELEC from the internal HDD of your"
  echo "              AppleTV and will reinstall AppleOS files to prepare for a factory-restore"
  echo "              boot. To abort the restore, POWER OFF your AppleTV in the next 30 seconds"
  echo ""
  catnap
  echo "        INFO: Creating GPT Scheme"
  parted -s ${HDD} mklabel gpt 1>&3 2>&4
  echo "        INFO: Creating Partitions"
  parted -s ${HDD} mkpart primary fat32 40s 69671s 1>&3 2>&4
  parted -s ${HDD} mkpart primary HFS 69672s 888823s 1>&3 2>&4
  parted -s ${HDD} mkpart primary HFS 888824s 2732015s 1>&3 2>&4
  parted -s ${HDD} mkpart primary HFS 2732016s ${SECTORS}s 1>&3 2>&4
  partprobe ${HDD} 1>&3 2>&4
  parted -s ${HDD} set 2 atvrecv on 1>&3 2>&4
  parted -s ${HDD} set 1 boot on 1>&3 2>&4
  echo "        INFO: Creating Filesystems"
  mkfs.msdos -F 32 -n EFI ${HDD}1 1>&3 2>&4
  mkfs.hfsplus -v Recovery ${HDD}2 1>&3 2>&4
  mkfs.hfsplus -J -v OSBoot ${HDD}3 1>&3 2>&4
  mkfs.hfsplus -J -v Media ${HDD}4 1>&3 2>&4
  partprobe ${HDD} 1>&3 2>&4
  echo "        INFO: Restoring Recovery Files"
  mkdir /mnt/Recovery 1>&3 2>&4
  mount -t hfsplus -o rw,force ${HDD}2 /mnt/Recovery 1>&3 2>&4
  cp -Rv /mnt/rootfs/restore/* /mnt/Recovery 1>&3 2>&4
  sync 1>&3 2>&4
  sleep 2
  umount /mnt/Recovery 1>&3 2>&4
  sleep 2
  echo y | gptsync ${HDD} 1>&3 2>&4
  sleep 2
  echo ""
  echo "        INFO: Preparation has completed!"
  echo ""
  echo "        INFO: Ignore the warnings below as we reboot :)"
  echo ""
}

emergency(){
  echo ""
  echo "        INFO: Telnet login available; user = 'root' and password = 'root'"
  echo "" 
  telnetd -l /bin/login
}

cleanup_hdd(){
  umount /mnt/rootfs 1>&3 2>&4
  echo y | gptsync ${HDD} 1>&3 2>&4
  dd if=/dev/zero of=${USB} bs=512 count=40 1>&3 2>&4
}

cleanup_usb(){
  umount /mnt/rootfs 1>&3 2>&4
  echo y | gptsync ${USB} 1>&3 2>&4
}

snooze(){
  sleep 100000
}

catnap(){
  sleep 30
}

pause(){
  sleep 10
}

error(){
  case $ERROR in
    download)    echo "        FAIL: The files could not be downloaded, aborting!";;
    badchecksum) echo "        FAIL: Checksum does not match, aborting!";;
    noipaddress) echo "        FAIL: Failed to lease an ipv4 address, aborting!";;
    *)           echo "        FAIL: There was an error, aborting!";;
  esac
  echo ""
  if [ -z "${IPADDRESS}" ]; then
    network
  fi
  emergency
  snooze
}

main(){
  blink
  check_verbose
  check_debug
  check_function
  check_bootdevice
  banner
  case $FUNCTION in
    install-hdd)
      prepare
      install_hdd
      cleanup_hdd
      pause
      reboot
      ;;
    install-hdd-offline)
      prepare
      install_hdd
      cleanup_hdd
      pause
      reboot
      ;;
    install-hdd-offline-debug)
      prepare
      install_hdd
      cleanup_hdd
      pause
      reboot
      ;;
    install-usb)
      prepare
      install_usb
      cleanup_usb
      pause
      reboot
      ;;
    install-usb-offline)
      prepare
      install_usb
      cleanup_usb
      pause
      reboot
      ;;
    install-usb-offline-debug)
      prepare
      install_usb
      cleanup_usb
      pause
      reboot
      ;;
    update)
      prepare
      update
      cleanup_hdd
      pause
      reboot
      ;;
    update-offline)
      prepare
      update
      cleanup_hdd
      pause
      reboot
      ;;
    factoryrestore)
      prepare
      factoryrestore
      cleanup_hdd
      pause
      reboot
      ;;
    emergency)
      network
      emergency
      ;;
    *)
      error
      ;;
  esac
}

main
snooze
