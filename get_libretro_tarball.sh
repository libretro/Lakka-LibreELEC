#!/bin/bash

# This script downloads a tarball of libretro package (packages/libretro) and extracts
# this tarball to sources/<package> folder.
# It is usefull in cases when the core repository was force-pushed and it is not possible
# to clone / checkout the the desired commit, which breaks the build.

# Where are the tarballs hosted
URL="https://nightly.builds.lakka.tv"

# Check arguments and print usage
[ $# -ne 1 ] && {
	echo "Usage:"
	echo "$0 <package>"
	echo ""
	echo "Download tarball from ${URL} and store it in sources/<package> folder"
	exit 1
}

PKG=${1}
PKG_PATH=""

# Check if there is such package
for FINDPATH in packages/lakka/retroarch_base/${PKG} packages/lakka/libretro_cores/${PKG} ; do
	if [ -d ${FINDPATH} ] ; then
		PKG_PATH=${FINDPATH}
		break
	fi
done

[ -z "${PKG_PATH}" ] && {
	echo "There is no package '${PKG}' in packages/lakka/retroarch_base and package/lakka/libretro_cores"
	exit 2
}

# Check if we have package.mk
[ ! -f ${PKG_PATH}/package.mk ] && {
	echo "Missing package.mk in ${PKG_PATH}"
	exit 3
}

# Import package properties
source ${PKG_PATH}/package.mk 2>&1 >/dev/null

# Check for package version, URL and that URL is git repo
[ -z "${PKG_VERSION}" ] && {
	echo "No PKG_VERSION set in ${PKG_PATH}/package.mk"
	exit 4
}

[ -z "${PKG_URL}" ] && {
	echo "No PKG_URL set in ${PKG_PATH}/package.mk"
	exit 4
}

[ "${PKG_URL: -4}" = ".git" -o "${PKG_URL:0:6}" = "git://" ] || {
	echo "PKG_URL (${PKG_URL}) is not a git repository"
	exit 4
}

LINK=${URL}/sources/${PKG}/${PKG}-${PKG_VERSION}.tar.xz
FILENAME=sources/${PKG}/${PKG}-${PKG_VERSION}.tar.xz
STAMPFILE=${FILENAME}.gitstamp

# Do not continue when a tarball is already present in the sources folder
# (also safety catch in case this script is started on the server, where the tarballs are hosted)
[ -f ${FILENAME} ] && {
	echo "There is already ${FILENAME} - remove it and try again"
	exit 5
}

[ -f ${STAMPFILE} ] && {
	echo "There is already ${STAMPFILE} - remove it and try again"
	exit 5
}

# Create folder in case it does not exist already
if [ ! -d sources/${PKG} ]
then
	if [ ! -f sources/${PKG} ]
	then
		mkdir -p sources/${PKG}
	else
		echo "Cannot create folder sources/$PKG - file exists"
		exit 6
	fi
fi

# Check if we have wget
[ -z "$(which ${PRG} 2>/dev/null)" ] && {
	echo "Please install ${PRG}"
	exit 7
}

# Download the tarball
echo "Downloading to ${FILENAME} ..."
wget --quiet -O ${FILENAME} ${LINK}

[ ${?} -gt 0 ] && {
	echo "Error downloading ${LINK}"
	exit 8
}

echo "Creating ${STAMPFILE} ..."
echo "${PKG_URL}|${PKG_VERSION}" > ${STAMPFILE}

[ ${?} -gt 0 ] && {
	echo "Error creating ${STAMPFILE}"
	exit 8
}

# And we are done
echo "Done"
