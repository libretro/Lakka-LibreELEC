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
	echo "Downloads tarballs from ${URL} and extracts it in sources/<package> folder"
	exit 1
}

PKG=${1}

# Check if there is such package
[ ! -d packages/libretro/${PKG} ] && {
	echo "There is no package '${PKG}' in packages/libretro"
	exit 2
}

# Check if we have package.mk
[ ! -f packages/libretro/${PKG}/package.mk ] && {
	echo "Missing package.mk in packages/libretro/${PKG}"
	exit 3
}

# Import package properties
source packages/libretro/${PKG}/package.mk 2>&1 >/dev/null

# Check for package version
[ -z "${PKG_VERSION}" ] && {
	echo "No PKG_VERSION set in packages/libretro/${PKG}/package.mk"
	exit 4
}

LINK=${URL}/sources/${PKG}/${PKG}-${PKG_VERSION}.tar.xz
FILENAME=sources/${PKG}/${PKG}-${PKG_VERSION}.tar.xz

# Do not continue when a tarball is already present in the sources folder
# (also safety catch in case this script is started on the server, where the tarballs are hosted)
[ -f ${FILENAME} ] && {
	echo "There is already ${FILENAME} - remove it and try again"
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

# Check if we have wget and tar
for PRG in wget tar
do
	[ -z "$(which ${PRG} 2>/dev/null)" ] && {
		echo "Please install ${PRG}"
		exit 7
	}
done

# Download the tarball
echo "Downloading to ${FILENAME} ..."
wget --quiet -O ${FILENAME} ${LINK}

[ ${?} -gt 0 ] && {
	echo "Error downloading ${LINK}"
	exit 8
}

# Extract the tarball
echo "Extracting..."
tar xf ${FILENAME} -C sources/${PKG}

[ ${?} -gt 0 ] && exit $?

# And we are done
echo "Done"

