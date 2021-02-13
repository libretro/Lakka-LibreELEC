#!/bin/bash

# Creates .tar.xz archives of cloned libretro repositories for future re-use
# in case original repository goes awol or is force-pushed, so a build can
# be reproduced.

# Get list of libretro packages
for pkg in packages/libretro/*
do

	pkg=$(basename ${pkg})

	# Is there a folder for this package in sources?
	if [ -d sources/${pkg} ]
	then
		# Is anything in that folder?
		for dir in sources/${pkg}/${pkg}-*
		do
			# Is it a folder?
			if [ -d ${dir} ]
			then
				# Skip in case a tarball was already created
				if [ ! -f ${dir}.tar.xz ]
				then
					# Create a tarball in separate process, so the main loop does not change working directory
					(
					cd sources/${pkg}
					name=$(basename ${dir})
					echo $pkg - creating ${name}.tar.xz
					tar -pcJf ${name}.tar.xz ${name}
					)
				fi
			fi
		done
	fi
done

