#!/bin/bash
usage() {
	echo ""
	echo "$0 <build|clean> <package>"
	echo ""
	echo "Builds/cleans a package for all projects/devices/systems of Lakka"
	echo ""
}

[ $# -lt 2 -o $# -gt 2 ] && { usage ; echo -e "Error: no or incorrect number of parameters!\n" ; exit 1 ; }

case $1 in
	clean)
		action=$1
		script="./scripts/clean"
		activity="Cleaning"
		;;
	build)
		action=$1
		script="./scripts/build"
		activity="Compilation"
		;;
	*)
		usage
		echo -e "Error: action '$1' not valid!\n"
		exit 2
		;;
esac

# existing targets in format PROJECT|ARCH|DEVICE|SYSTEM|BOARD|OUTPUT
targets="\
	Generic|i386||| \
	Generic|x86_64||| \
	Generic_VK_nvidia|x86_64||| \
	RPi|arm||| \
	RPi|arm|||GPICase \
	RPi2|arm||| \
	RPi2|arm|||RPi4 \
	Allwinner|arm||Bananapi| \
	imx6|arm||cuboxi| \
	OdroidC1|arm||| \
	Odroid_C2|arm||| \
	OdroidXU3|arm||| \
	WeTek_Core|arm||| \
	WeTek_Hub|arm||| \
	WeTek_Play|arm||| \
	WeTek_Play_2|arm||| \
	Gamegirl|arm||| \
	S8X2|arm||S82| \
	S805|arm||MXQ| \
	S905|arm||| \
	S912|arm||| \
	Rockchip|arm|TinkerBoard|| \
	Rockchip|arm|RK3328||ROCK64 \
	Rockchip|arm|RK3328||ROC-RK3328-CC \
	Rockchip|arm|MiQi|| \
	Rockchip|arm|RK3399||ROCKPro64 \
	Rockchip|arm|RK3399||ROCK960 \
	"
package=$2
declare -i failed=0
failed_targets=""
skipped_targets=""
distro="Lakka"
source distributions/${distro}/options
if [ -z "$OS_VERSION" -o -z "$LIBREELEC_VERSION" ]; then
	echo "OS_VERSION or LIBREELEC_VERSION empty / not set in 'distributions/${distro}/options'!"
	echo "  OS_VERSION=$OS_VERSION"
	echo "  LIBREELEC_VERSION=$LIBREELEC_VERSION"
	echo "Bailing out!"
	exit 127
fi

for T in $targets ; do
	IFS='|' read -r -a build <<< "$T"
	project=${build[0]}
	arch=${build[1]}
	device=${build[2]}
	system=${build[3]}
	board=${build[4]}
	target_name=${board:-${device:-${project}}}.${arch}
	if [ "$IGNORE_VERSION" = "1" ]; then
		build_folder=build.${distro}-${target_name}
	else
		if [ "$LIBREELEC_VERSION" = "devel" ]; then
			build_folder=build.${distro}-${target_name}-${OS_VERSION}-${LIBREELEC_VERSION}
		else
			build_folder=build.${distro}-${target_name}-${LIBREELEC_VERSION}
		fi
	fi
	echo "Processing package '$package' for '$target_name':"
	if [ ! -d ${build_folder} ] ; then
		skipped_targets="${skipped_targets}${target_name}\n"
		echo "No build folder - skipping."
	else
		PROJECT=$project DEVICE=$device BOARD=$board ARCH=$arch $script $package
		if [ $? -gt 0 ] ; then
			failed+=1
			failed_targets="${failed_targets}${target_name}\n"
			echo "$activity of package '$package' failed for '$target_name'!"
		else
			echo "$activity of package '$package' succeeded for '$target_name'."
		fi
	fi
done
[ -n "$skipped_targets" ] &&
	echo -e "\nFollowing targets were skipped - could not find existing build folder:\n$skipped_targets\n" 
if [ $failed -gt 0 ] ; then
	echo -e "\nFailed to ${action} package '$package' on following targets:\n${failed_targets}" >&2
else
	echo "Done."
fi
exit $failed
