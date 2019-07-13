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
	Allwinner|A64|arm \
	Allwinner|H3|arm \
	Allwinner|H6|arm \
	Amlogic|AMLGX|arm \
	Generic||x86_64 \
	Generic||i386 \
	Rockchip|MiQi|arm \
	Rockchip|RK3328|arm \
	Rockchip|RK3399|arm \
	Rockchip|TinkerBoard|arm \
	RPi|Gamegirl|arm \
	RPi|RPi|arm \
	RPi|RPi2|arm \
	RPi|RPi4|arm \
	"

package=$2
declare -i failed=0
failed_targets=""
skipped_targets=""

for T in $targets ; do
	IFS='|' read -r -a build <<< "$T"
	project=${build[0]}
	device=${build[1]}
	arch=${build[2]}
	target_name=${device:-${project}}.${arch}
	if [ ! -d build.Lakka-${target_name}* ] ; then
		skipped_targets="${skipped_targets}${target_name}\n"
	else
		PROJECT=$project DEVICE=$device ARCH=$arch $script $package
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
