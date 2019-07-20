#!/bin/bash

rm -rf target/

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
	Qualcomm|Dragonboard|arm \
	"

failed_targets=""
declare -i failed_jobs=0

# number of buildthreads = two times number of cpu threads
tc=""
if [ -n "$(which nproc)" ]; then
	tc="THREADCOUNT=$(($(nproc)*2))"
fi

for target in $targets
do
	IFS='|' read -r -a build  <<< "$target"
	project=${build[0]}
	device=${build[1]}
	arch=${build[2]}
	target_name=${device:-$project}.${arch}

	echo "Starting build of ${target_name}"

	make image PROJECT=$project DEVICE=$device ARCH=$arch $tc

	if [ $? -gt 0 ]
	then
		failed_jobs+=1
		failed_targets+="${target_name}\n"
	else
		rm -vf \
			target/Lakka-${target_name}-*.kernel \
			target/Lakka-${target_name}-*.system \
			target/Lakka-${target_name}-*.tar \
			target/Lakka-${target_name}-*.tar.sha256 \
			target/Lakka-${target_name}-*.ova \
			target/Lakka-${target_name}-*.ova.sha256
		mkdir -p target/${target_name}
		mv -v \
			target/Lakka-${target_name}-*.img.gz \
			target/Lakka-${target_name}-*.img.gz.sha256 \
			target/${target_name}/
	fi
done

if [ $failed_jobs -gt 0 ]
then
	echo -e "\nFailed ${failed_jobs} build(s):\n${failed_targets}:-(" >&2
else
	echo -e "\nAll successful!\n:-)"
fi

exit $failed_jobs
