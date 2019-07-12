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

# existing targets in format PROJECT|ARCH|DEVICE|SYSTEM|BOARD|OUTPUT
targets="\
	Generic|i386||||image \
	Generic|x86_64||||image \
	RPi|arm||||noobs \
	RPi2|arm||||noobs \
	Allwinner|arm||Bananapi||image \
	imx6|arm||cuboxi||image \
	OdroidC1|arm||||image \
	Odroid_C2|arm||||image \
	OdroidXU3|arm||||image \
	WeTek_Core|arm||||image \
	WeTek_Hub|arm||||image \
	WeTek_Play|arm||||image \
	WeTek_Play_2|arm||||image \
	Gamegirl|arm||||image \
	S8X2|arm||S82||image \
	S805|arm||MXQ||image \
	S905|arm||||image \
	S912|arm||||image \
	Rockchip|arm|TinkerBoard|||image \
	Rockchip|arm|RK3328||ROCK64|image \
	Rockchip|arm|RK3328||ROC-RK3328-CC|image \
	Rockchip|arm|MiQi|||image \
	Rockchip|arm|RK3399||ROCKPro64|image \
	Rockchip|arm|RK3399||ROCK960|image \
	"
package=$2
declare -i failed=0
failed_targets=""
skipped_targets=""
distro="Lakka"

for T in $targets ; do
	IFS='|' read -r -a build <<< "$T"
	project=${build[0]}
	arch=${build[1]}
	device=${build[2]}
	system=${build[3]}
	board=${build[4]}
	target=${build[5]}
	target_name=${board:-${device:-${project}}}.${arch}
	if [ ! -d build.${distro}-${target_name}* ] ; then
		skipped_targets="${skipped_targets}${target_name}\n"
	else
		PROJECT=$project DEVICE=$device BOARD=$board ARCH=$arch $script $package
		if [ $? -gt 0 ] ; then
			failed+=1
			failed_targets="${failed_targets}${target_name}\n"
		fi
	fi
done
[ -n "$skipped_targets" ] && { echo -e "Following targets were skipped - could not find existing build folder:\n$skipped_targets\n\n" ; }
if [ $failed -gt 0 ] ; then
	echo -e "\nFailed to ${action} package '$package' on following targets:\n${failed_targets}" >&2
	exit 127
else
	echo "Done."
	exit 0
fi
