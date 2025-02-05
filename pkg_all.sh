#!/bin/bash
usage() {
	echo ""
	echo "${0} <build|clean|unpack> <package>"
	echo ""
	echo "Builds/cleans a package for all projects/devices/systems of Lakka"
	echo ""
}

[ ${#} -lt 2 -o ${#} -gt 2 ] && { usage ; echo -e "Error: no or incorrect number of parameters!\n" ; exit 127 ; }

case ${1} in
	clean)
		action=${1}
		script="scripts/clean"
		activity="Cleaning"
		;;
	build)
		action=${1}
		script="scripts/build"
		activity="Compilation"
		;;
	unpack)
		action=${1}
		script="scripts/unpack"
		activity="Unpacking"
		;;
	*)
		usage
		echo -e "Error: action '${1}' not valid!\n"
		exit 128
		;;
esac

# existing targets in format PROJECT|DEVICE|ARCH
targets="\
	Allwinner|A64|aarch64| \
	Allwinner|H2-plus|arm| \
	Allwinner|H3|arm| \
	Allwinner|H5|aarch64| \
	Allwinner|H616|aarch64| \
	Allwinner|H6|aarch64| \
	Allwinner|R40|arm| \
	Amlogic|AMLGX|aarch64| \
	Ayn|Odin|aarch64| \
	Generic|Generic|i386| \
	Generic|Generic|x86_64| \
	Generic|wayland|x86_64| \
	Generic|x11|x86_64| \
	L4T|Switch|aarch64| \
	NXP|iMX6|arm| \
	NXP|iMX8|aarch64| \
	RPi|RPi|arm| \
	RPi|RPi2|arm| \
	RPi|RPi3|aarch64| \
	RPi|RPi3-Composite|aarch64| \
	RPi|RPi4|aarch64| \
	RPi|RPi4-Composite|aarch64| \
	RPi|RPi4-GPiCase2|aarch64| \
	RPi|RPi4-PiBoyDmg|aarch64| \
	RPi|RPi4-RetroDreamer|aarch64| \
	RPi|RPi5|aarch64| \
	RPi|RPi5-Composite|aarch64| \
	RPi|RPiZero-GPiCase|arm| \
	RPi|RPiZero2-GPiCase|arm| \
	RPi|RPiZero2-GPiCase2W|aarch64| \
	Rockchip|RK3288|arm| \
	Rockchip|RK3328|aarch64| \
	Rockchip|RK3399|aarch64| \
	Samsung|Exynos|arm| \
"

package=${2}
declare -i failed=0
declare -i succeeded=0
failed_targets=""
succeeded_targets=""
skipped_targets=""

for T in ${targets} ; do
	IFS='|' read -r -a build <<< ${T}
	project=${build[0]}
	device=${build[1]}
	arch=${build[2]}
	target_name=${device:-${project}}.${arch}
	[ -z "${DISTRO}" ] && distro="Lakka" || distro="${DISTRO}"
	echo "Processing package '${package}' for '${target_name}':"
	export DISTRO=${distro}
	export PROJECT=${project}
	export DEVICE=${device}
	export ARCH=${arch}

	opt_file="distributions/${distro}/options"
	ver_file="distributions/${distro}/version"

	[ -f ${opt_file} ] && source ${opt_file} || { echo "${ver_file}: not found!" ; exit 129 ; }

	[ -f ${ver_file} ] && source ${ver_file} || { echo "${ver_file}: not found!" ; exit 130 ; }

	BUILD=build.${DISTRO}-${DEVICE:-$PROJECT}.${ARCH}-${LIBREELEC_VERSION}

	if [ "${LIBREELEC_VERSION}" = "devel" ] ; then
		BUILD=build.${DISTRO}-${DEVICE:-$PROJECT}.${ARCH}-${OS_VERSION}-${LIBREELEC_VERSION}
	fi

	if [ "${BUILD_NO_VERSION}" = "yes" ]; then
		BUILD=build.${DISTRO}-${DEVICE:-$PROJECT}.${ARCH}
	fi

	if [ -n "${BUILD_SUFFIX}" ]; then
		BUILD=${BUILD}-${BUILD_SUFFIX}
	fi

	build_folder=${BUILD}

	if [ ! -d "${build_folder}" ] ; then
		skipped_targets+="${target_name}\n"
		echo -e "No build folder - skipping.\n"
		continue
	fi

	${script} ${package}

	if [ ${?} -gt 0 ] ; then
		failed+=1
		failed_targets+="${target_name}\n"
		echo -e "${activity} of package '${package}' failed for '${target_name}'.\n"
	else
		succeeded+=1
		succeeded_targets+="${target_name}\n"
		echo -e "${activity} of package '${package}' succeeded for '${target_name}'.\n"
	fi

done

if [ -n "${skipped_targets}" ] ; then
	echo -e "Following targets were skipped - could not find existing build folder:\n${skipped_targets}\n"
fi

if [ ${failed} -gt 0 ] ; then
	echo -e "Failed to ${action} package '${package}' on following ${failed} target(s):\n${failed_targets}\n" >&2
fi

if [ ${succeeded} -gt 0 ] ; then
	echo -e "Successful ${action} of package '${package}' on following ${succeeded} target(s):\n${succeeded_targets}\n" >&2
fi

echo "Done."

exit ${failed}
