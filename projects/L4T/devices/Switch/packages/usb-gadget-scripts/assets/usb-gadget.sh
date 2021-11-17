#!/bin/bash

manufacturer="Nintendo"
product="Switch(Lakka)"
#vid/pid defaults if not ran as attackmode.... Defaults are default for linux
vid_default="0x1d6b" #linux foundation
pid_default="0x0104" #Multifunction Gadget
serialnumber="00000001"

gadget_config="/sys/kernel/config"
udc="700d0000.xudc"

create_gadget_framework() {
	#create basic gadget framework to work with
	mkdir -p $gadget_config
	mount -t configfs none $gadget_config
	mkdir -p $gadget_config/usb_gadget/g
	chmod -R 666 $gadget_config/usb_gadget/g
	echo $vid_default > $gadget_config/usb_gadget/g/idVendor
	echo $pid_default > $gadget_config/usb_gadget/g/idProduct
	echo 0x0100 > $gadget_config/usb_gadget/g/bcdDevice # v1.0.0
	echo 0x0200 > $gadget_config/usb_gadget/g/bcdUSB    # USB 2.0
	mkdir -p $gadget_config/usb_gadget/g/strings/0x409
	echo $serialnumber > $gadget_config/usb_gadget/g/strings/0x409/serialnumber
	echo $manufacturer > $gadget_config/usb_gadget/g/strings/0x409/manufacturer
	echo $product  > $gadget_config/usb_gadget/g/strings/0x409/product
 	echo 0xEF > $gadget_config/usb_gadget/g/bDeviceClass
	echo 0x02 > $gadget_config/usb_gadget/g/bDeviceSubClass
	echo 0x01 > $gadget_config/usb_gadget/g/bDeviceProtocol
	mkdir -p $gadget_config/usb_gadget/g/configs/c.1
	echo 250 > $gadget_config/usb_gadget/g/configs/c.1/MaxPower
}

create_ffs_mtp() {
	mkdir -p $gadget_config/usb_gadget/g/functions/ffs.mtp
	ln -s $gadget_config/usb_gadget/g/functions/ffs.mtp $gadget_config/usb_gadget/g/configs/c.1/
        mkdir -p /dev/ffs-umtp
        mount mtp /dev/ffs-umtp -t functionfs
        umtprd &
}

create_serial() {
	mkdir -p $gadget_config/usb_gadget/g/functions/acm.usb0
	ln -s $gadget_config/usb_gadget/g/functions/acm.usb0 $gadget_config/usb_gadget/g/configs/c.1/
}

finalize_gadget_framework() {
	echo $udc > $gadget_config/usb_gadget/g/UDC
	udevadm settle -t 5 || :
}


create_gadget_framework
#create_ffs_mtp
create_serial
finalize_gadget_framework
