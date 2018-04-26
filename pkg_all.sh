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

package=$2
declare -i failed=0
failed_targets=""
skipped_folders=""

declare -i i=0
for f in $(ls -d build.Lakka-*/) ; do
	if [ -d $f ] ; then
		i+=1
		declare "skip_$i=no"
		declare "distro_$i=$(echo $f | sed -e 's/build\.\(.*\)-\(.*\)-[0-9]\(.*\)/\1/')"
		declare "arch_$i=$(echo $f | sed -e 's/build\.\(.*\)-\(.*\)\.\(.*\)-[0-9]\(.*\)/\3/')"
		target=$(echo $f | sed -e 's/build\.\(.*\)-\(.*\)\.\(.*\)-[0-9]\(.*\)/\2/')
		if [ -d projects/$target ] ; then
			declare "project_$i=$target"
			declare "device_$1="
		else
			if [ -d projects/*/devices/$target ] ; then
				declare "device_$i=$target"
				declare "project_$i=$(ls -d projects/*/devices/$target | sed -e 's/projects\/\(.*\)\/devices\/\(.*\)/\1/')"
			else
				echo "Skipping $f: could not match."
				skipped_folders="${skipped_folders}${f}\n"
				declare "skip_$i=yes"
			fi
		fi
	fi
done

[ $i -eq 0 ] && { echo "No build folders found!" ; exit 1 ; }

for a in $(seq 1 $i) ; do
	declare "var=skip_$a"
	declare "skip=${!var}"
	[ "$skip" = "yes" ] && continue
	declare "var=distro_$a"
	declare "distro=${!var}"
	declare "var=project_$a"
	declare "project=${!var}"
	declare "var=device_$a"
	declare "device=${!var}"
	declare "var=arch_$a"
	declare "arch=${!var}"
	target_name=${distro}-${project:-$device}.${arch}
	DISTRO=$distro PROJECT=$project DEVICE=$device ARCH=$arch $script $package
	if [ $? -gt 0 ] ; then
		failed+=1
		failed_targets="${failed_targets}${target_name}\n"
	fi
done
[ -n "$skipped_folders" ] && { echo -e "Following folders were skipped - could not match:\n$skipped_folders\n\n" ; }
if [ $failed -gt 0 ] ; then
	echo -e "\nFailed to ${action} package '$package' on following targets:\n${failed_targets}" >&2
	exit 127
else
	echo "Done."
	exit 0
fi
