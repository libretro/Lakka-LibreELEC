#!/bin/bash

usage() {
	echo ""
	echo "$0 <build|clean> <package>"
	echo ""
	echo "Builds/cleans a package for all projects/devices/systems of Lakka"
	echo ""
}

_do() {
	if [ -z "$system" -a -z "$device" ] ; then
		target_name=$project.$arch
		DISTRO=$distro PROJECT=$project ARCH=$arch $script $package
		ret=$?
	fi
	if [ -n "$system" -a -z "$device" ] ; then
		target_name=$project.$system.$arch
		DISTRO=$distro PROJECT=$project SYSTEM=$system ARCH=$arch $script $package
		ret=$?
	fi
	if [ -z "$system" -a -n "$device" ] ; then
		target_name=$project.$device.$arch
		DISTRO=$distro PROJECT=$project DEVICE=$device ARCH=$arch $script $package
		ret=$?
	fi
	if [ -n "$system" -a -n "$device" ] ; then
		target_name=$project.$device.$system.$arch
		DISTRO=$distro PROJECT=$project SYSTEM=$system DEVICE=$device ARCH=$arch $script $package
		ret=$?
	fi
}

failed() {
	failed+=1
	failed_targets="${failed_targets}${target_name}\n"
}

[ $# -lt 2 -o $# -gt 2 ] && { usage ; echo -e "Error: no or incorrect number of parameters!\n" ; exit 1 ; }

case $1 in
	clean)
		action=$1
		script="./scripts/clean"
		;;
	build)
		action=$1
		script="./scripts/build"
		;;
	*)
		usage
		echo -e "Error: action '$1' not valid!\n"
		exit 2
		;;
esac

package=$2
distro="Lakka"
buildprojects="Generic RPi RPi2 Allwinner Rockchip imx6 OdroidC1 Odroid_C2 OdroidXU3 WeTek_Core WeTek_Hub WeTek_Play WeTek_Play_2 Gamegirl S8X2 S805 S905 S912 Slice Slice3"
archs_default="arm"
archs_Generic="x86_64 i386"
systems_default=""
systems_imx6="cuboxi udoo"
systems_S8X2="S82 M8 T8 MXIII-1G MXIII-PLUS X8H-PLUS"
systems_S805="MXQ HD18Q M201C M201D MK808B-Plus"
systems_Allwinner="Bananapi Cubieboard2 Cubietruck orangepi_2 orangepi_lite orangepi_one orangepi_pc orangepi_plus orangepi_plus2e nanopi_m1_plus"
devices_default=""
devices_Rockchip="TinkerBoard ROCK64 MiQi"
declare -i failed=0
failed_targets=""

for p in $buildprojects ; do

	project=$p

	for v in archs systems devices ; do
		vars=${v}_${project}
		vars=$(echo ${!vars})
		vard=${v}_default
		vard=$(echo ${!vard})
		varname=p_${v}
		if [ -z "$vars" ] ; then
			declare "$varname=`echo $vard`"
		else
			declare "$varname=`echo $vars`"
		fi
	done

	for a in $p_archs ; do
		arch=$a
		if [ -n "$p_systems" -a -z "$p_devices" ] ; then
			for s in $p_systems ; do
				system=$s
				device=""
				_do
				if [ $ret -gt 0 ] ; then
					failed
				fi
			done
		fi

		if [ -z "$p_systems" -a -n "$p_devices" ] ; then
			for d in $p_devices ; do
				system=""
				device=$d
				_do
				if [ $ret -gt 0 ] ; then
					failed
				fi
			done
		fi

		if [ -n "$p_systems" -a -n "$p_devices" ] ; then
			for s in $p_systems ; do
				for d in $p_devices ; do
					system=$s
					device=$d
					_do
					if [ $ret -gt 0 ] ; then
						failed
					fi
				done
			done
		fi

		if [ -z "$p_systems" -a -z "$p_devices" ] ; then
			system=""
			device=""
			_do
			if [ $ret -gt 0 ] ; then
				failed
			fi
		fi
	done

done

if [ $failed -gt 0 ] ; then
	echo -e "\nFailed to ${action}:\n${failed_targets}" >&2
	exit 127
else
	echo "Done."
	exit 0
fi
