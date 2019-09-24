#!/bin/bash

rm -rf target/

targets="\
	Allwinner|A64|arm|image \
	Allwinner|H3|arm|image \
	Allwinner|H6|arm|image \
	Amlogic|AMLG12|arm|image \
	Amlogic|AMLGX|arm|image \
	Generic||x86_64|image \
	Generic||i386|image \
	Rockchip|MiQi|arm|image \
	Rockchip|RK3328|arm|image \
	Rockchip|RK3399|arm|image \
	Rockchip|TinkerBoard|arm|image \
	RPi|Gamegirl|arm|image \
	RPi|GPICase|arm|noobs \
	RPi|RPi|arm|noobs \
	RPi|RPi2|arm|noobs \
	RPi|RPi4|arm|noobs \
	Qualcomm|Dragonboard|arm|image \
	"

failed_targets=""
declare -i failed_jobs=0

# number of buildthreads = two times number of cpu threads
tc=""
if [ -n "$(which nproc)" ]
then
	tc="THREADCOUNT=$(($(nproc)*2))"
fi

for target in $targets
do
	IFS='|' read -r -a build  <<< "$target"
	project=${build[0]}
	device=${build[1]}
	arch=${build[2]}
	out=${build[3]}
	target_name=${device:-$project}.${arch}

	echo "Starting build of ${target_name}"

	make $out PROJECT=$project DEVICE=$device ARCH=$arch $tc

	if [ $? -gt 0 ]
	then
		failed_jobs+=1
		failed_targets+="${target_name}\n"
	else
		cd target
		mkdir -p ${target_name}
		for file in Lakka-${target_name}-*.{kernel,system}
		do
			md5sum ${file} > ${file}.md5
		done
		for file in Lakka-${target_name}-*{.img.gz,-noobs.tar,.kernel,.system}*
		do
			mv -v ${file} ${target_name}/
		done
		rm -vf Lakka-${target_name}-*.{tar,ova}*
		cd ..
	fi
done

if [ $failed_jobs -gt 0 ]
then
	echo -e "\nFailed ${failed_jobs} build(s):\n${failed_targets}:-(" >&2
else
	echo -e "\nAll successful!\n:-)"
fi

exit $failed_jobs
