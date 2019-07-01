#!/bin/bash

rm -rf target/

targets="\
	Allwinner|A64|arm \
	Allwinner|H3|arm \
	Allwinner|H6|arm \
	Amlogic|AMLGX|arm \
	Generic||x86_64 \
	Rockchip|MiQi|arm \
	Rockchip|RK3328|arm \
	Rockchip|RK3399|arm \
	Rockchip|TinkerBoard|arm \
	RPi|Gamegirl|arm \
	RPi|RPi|arm \
	RPi|RPi2|arm \
	RPi|RPi4|arm \
	RPi|Slice|arm \
	RPi|Slice3|arm \
	"


failed_targets=""
declare -i failed_jobs=0

for target in $targets
do
	IFS='|' read -r -a build  <<< "$target"
	project=${build[0]}
	device=${build[1]}
	arch=${build[2]}
	target_name=${device:-$project}.${arch}

	echo "Starting build of ${target_name}"

	PROJECT=$project DEVICE=$device ARCH=$arch make image

	if [ $? -gt 0 ]
	then
		failed_jobs+=1
		failed_targets+="${target_name}\n"
	else
		rm -f target/*.kernel target/*.system target/*.tar target/*.tar.sha256 target/*.ova target/*.ova.sha256
		mkdir -p target/${target_name}
		mv target/Lakka-${target_name}-*.img.gz target/Lakka-${target_name}-*.img.gz.sha256 target/${target_name}/
	fi
done

if [ $failed_jobs -gt 0 ]
then
	echo -e "\nFailed ${failed_jobs} build(s):\n${failed_targets}:-(" >&2
else
	echo -e "\nAll successful!\n:-)"
fi

exit $failed_jobs
