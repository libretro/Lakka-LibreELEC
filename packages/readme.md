# Structure of package.mk files

## Introduction

The package.mk file defines variables and functions to build a package.

## Variables
To control the build behaviour of your package, use variables in the top-down order listed here.

#### Base

| Variable    | Default | Required |Description |
|-------------|---------|----------|------------|
| PKG_NAME    | -       | yes | Name of the packaged software application. Should be lowercase |
| PKG_VERSION | -       | yes | Version of the packaged software application. If the version is a githash, please use the full githash, not the abbreviated form. |
| PKG_SHA256  | -       | yes | SHA256 hashsum of the application download file |
| PKG_ARCH    | any     | no  | Architectures for which the package builds. `any` or a space separated list of `aarch64`, `arm` or `x86_64` |
| PKG_LICENSE | -       | yes | License of the software application. [Reference](https://github.com/LibreELEC/LibreELEC.tv/tree/master/licenses) |
| PKG_SITE    | -       | yes | Site of the software application |
| PKG_URL     | -       | yes | Address at which the source of the software application can be retrieved |
| PKG_MAINTAINER | -    | no  | Your name |
| PKG_DEPENDS_BOOTSTRAP<br>PKG_DEPENDS_HOST   PKG_DEPENDS_INIT   PKG_DEPENDS_TARGET | - | no | A space separated list of name of packages required to build the software application |
| PKG_SECTION | -       | no  | virtual if the package only defines dependencies |
| PKG_SHORTDESC | -     | no<br>yes&nbsp;for&nbsp;addons | Short description of the software package |
| PKG_LONGDESC | -      | yes | Long description of the package including purpose or function within LibreELEC or Kodi |

#### Universal Build Option
| Variable    | Default | Required |Description |
|-------------|---------|----------|------------|
| PKG_SOURCE_DIR | -    | no  | Force the folder name that application sources are unpacked to. Used when sources do not automatically unpack to a folder with the `PKG_NAME-PKG_VERSION` naming convention. |
| PKG_SOURCE_NAME | -   | no  | Force the filename of the application sources. Used when the filename is not the basename of `PKG_URL` |
| PKG_PATCH_DIRS | -    | no  | Patches in `./patches` are automatically applied after package unpack. Use this option to include patches from an additional folder, e.g. `./patches/$PKG_PATCH_DIRS` |
| PKG_NEED_UNPACK | -   | no  | Space separated list of files or folders to include in package stamp calculation. If the stamp is invalidated through changes to package files or dependent files/folders the package is cleaned and rebuilt. e.g. `PKG_NEED_UNPACK="$(get_pkg_directory linux)"` will trigger clean/rebuild of a Linux kernel driver package when a change to the `linux` kernel package is detected. |
| PKG_TOOLCHAIN | auto  | no  | Control which build toolchain is used. For detailed information, see [reference](#toolchain-options). |
| PKG_BUILD_FLAGS | -   | no  | A space separated list of flags with which to fine-tune the build process. Flags can be enabled or disabled with a `+` or `-` prefix. For detailed information, see the [Reference](#build_flags-options). |
| PKG_PYTHON_VERSION | python2.7 | no | Define the Python version to be used. |
| PKG_IS_KERNEL_PKG | - | no  | Set to `yes` for packages that include Linux kernel modules |

#### Meson Options
| Variable    | Default | Required |Description |
|-------------|---------|----------|------------|
| PKG_MESON_SCRIPT | $PKG_BUILD/meson.build | no | Meson build file to use |
| PKG_MESON_OPTS_TARGET | - | no   | Options directly passed to meson |

#### CMAKE Options
| Variable    | Default | Required |Description |
|-------------|---------|----------|------------|
| PKG_CMAKE_SCRIPT | $PKG_BUILD/CMakeLists.txt | no | CMake build file to use |
| PKG_CMAKE_OPTS_HOST<br>PKG_CMAKE_OPTS_TARGET | - | no | Options directly passed to cmake |

#### Configure Options
| Variable    | Default | Required |Description |
|-------------|---------|----------|------------|
| PKG_CONFIGURE_SCRIPT | $PKG_BUILD/configure | no | configure script to use |
| PKG_CONFIGURE_OPTS<br>PKG_CONFIGURE_OPTS_BOOTSTRAP<br>PKG_CONFIGURE_OPTS_HOST<br>PKG_CONFIGURE_OPTS_INIT<br>PKG_CONFIGURE_OPTS_TARGET | - | no | Options directly passed to configure |

#### Make Options
| Variable    | Default | Required |Description |
|-------------|---------|----------|------------|
| PKG_MAKE_OPTS<br>PKG_MAKE_OPTS_BOOTSTRP<br>PKG_MAKE_OPTS_HOST<br>PKG_MAKE_OPTS_INIT<br> PKG_MAKE_OPTS_TARGET | - | no | Options directly passed to make in the build step
| PKG_MAKEINSTALL_OPTS_HOST<br>PKG_MAKEINSTALL_OPTS_TARGET | - | no | Options directly passed to make in the install step

#### Addons
Additional options used when the package builds an addon.

| Variable    | Default | Required |Description |
|-------------|---------|----------|------------|
| PKG_REV     | -       | yes      | The revision number of the addon (starts at 100). Must be placed after `PKG_VERSION`. Must be incremented for each new version else Kodi clients will not detect version change and download the updated addon. |
| PKG_IS_ADDON | no     | yes      | Must be set to `yes` <br>or to `embedded` when this addon is part of the image |
| PKG_ADDON_NAME | -    | yes      | Proper name of the addon that is shown at the repo |
| PKG_ADDON_TYPE | -    | yes      | See LE/config/addon/ for other possibilities |
| PKG_ADDON_VERSION | - | no       | The version of the addon, used in addon.xml |
| PKG_ADDON_PROVIDES | - | no      | [Provides](http://kodi.wiki/view/addon.xml#.3Cprovides.3E_element) in addon-xml |
| PKG_ADDON_REQUIRES | - | no      | [Requires](http://kodi.wiki/view/addon.xml#.3Crequires.3E) used in addon.xml |
| PKG_ADDON_PROJECTS | @PROJECTS@ | no | for available projects or devices, see projects subdirectory (note: Use RPi for RPi project, and RPi1 for RPi device) |
| PKG_DISCLAIMER | -    | no       | [Disclaimer](https://kodi.wiki/view/Addon.xml#.3Cdisclaimer.3E) in addon-xml |
| PKG_ADDON_IS_STANDALONE | - | no | Defines if an addon depends on Kodi (on) or is standalone (yes) |
| PKG_ADDON_BROKEN | -  | no       | Marks an addon as broken for the user |

#### Detail Infomations for Options

##### TOOLCHAIN options

Application/packages needs different toolchains for build.
For instance `cmake` or the classic `./configure` or same very different.

For the most application/packages, the auto-detection of the toolchain works proper.
But not always. To select a specific toolchain, you only need to set the `PKG_TOOLCHAIN` variable.

| Toolchain   | Description (if needed) |
|-----------  |-------------------------|
| meson       | [Meson Build System](http://mesonbuild.com/) |
| cmake       | [CMake](https://cmake.org/) with Ninja |
| cmake-make  | [CMake](https://cmake.org/) with Make |
| autotools   | [GNU Build System](https://en.wikipedia.org/wiki/GNU_Build_System)
| configure   | preconfigured [GNU Build System](https://en.wikipedia.org/wiki/GNU_Build_System) |
| ninja       | [Ninja Build](https://ninja-build.org/) |
| make        | [Makefile Based](https://www.gnu.org/software/make/) |
| manual      | only runs self writen build steps, see [Functions](#functions) |

###### Auto-Detection
The auto-detections looks for specific files in the source path.

1. `meson.build` (PKG_MESON_SCRIPT) => meson toolchain
2. `CMakeLists.txt` (PKG_CMAKE_SCRIPT) => cmake toolchain
3. `configure` (PKG_CONFIGURE_SCRIPT) => configure toolchain
4. `Makefile` => make toolchain

When none of these was found, the build abort and you have to set the toolchain via `PKG_TOOLCHAIN`

##### BUILD_FLAGS options

Build flags implement often used build options. Normally these are activated be default, but single applications/packages has problems to compile/run with these.

Set the variable `PKG_BUILD_FLAGS` in the `package.mk` to enable/disable the single flags. It is a space separated list. The flags can enabled with a `+` prefix, and disabled with a `-`.

| flag     | default  | affected stage | description |
|----------|----------|----------------|-------------|
| pic      | disabled | target/init    | [Position Independent Code](https://en.wikipedia.org/wiki/Position-independent_code) |
| pic:host | disabled | host/bootstrap | see above |
| lto      | disabled | target/init    | enable LTO (Link Time optimization) in the compiler and linker unless disabled via `LTO_SUPPORT`. Compiles non-fat LTO objects (only bytecode) and performs single-threaded optimization at link stage |
| lto-parallel | disabled | target/init | same as `lto` but enable parallel optimization at link stage. Only enable this if the package build doesn't run multiple linkers in parallel otherwise this can result in lots of parallel processes! |
| lto-fat  | disabled | target/init | same as `lto` but compile fat LTO objects (bytecode plus optimized assembly). This increases compile time but can be useful to create static libraries suitable both for LTO and non-LTO linking |
| lto-off  | disabled | target/init | explicitly disable LTO in the compiler and linker |
| gold     | depend on `GOLD_SUPPORT` | target/init | can only disabled, use of the GOLD-Linker |
| parallel | enabled  | all | `make` or `ninja` builds with multiple threads/processes (or not) |
| strip    | enabled  | target | strips executables (or not) |

###### Example
```
PKG_BUILD_FLAGS="+pic -gold"
PKG_BUILD_FLAGS="-parallel"
```

## Functions
All build steps in the LibreELEC build system, a done by shell function.
These functions can overwritten in the `package.mk`. But this raises problems, when the build system is updated. To reduce the problem, most function was extended by `pre_` and `post_` scripts, to use instead.

When it is nesseary to replace configure, make and makeinstall, please use `PKG_TOOLCHAIN="manual"`.

Some of the build steps needs to be run once, like `unpack`. Other steps needs to be run multiple times, to create the toolchain (stage bootstrap & host) or to create the LE image (stage init & target). These stage specific functions have the stage as suffix, like `make_target`.

Full list of overwrittable functions.

| function                | stages specific | description |
|-------------------------|--------|-------------|
| unpack<br>pre_unpack<br>post_unpack | - | Extract the source from the downloaded file |
| pre_patch<br>post_patch | -      | Apply the patches to the source, after extraction. The patch function it self is not allowed to overwritten |
| pre_build_\[stage]      | yes    | Runs before of the start of the build |
| configure_\[stage]<br>pre_configure_\[stage]<br>post_configure_\[stage] | yes | Configure the package for the compile. This is only relevant for toolchain, that supports it (e.g. meson, cmake, configure, manual) |
| make_\[stage]<br>pre_make_\[stage]<br>post_make_\[stage] | yes | Build of the package |
| makeinstall_\[stage]<br>pre_makeinstall_\[stage]<br>post_makeinstall_\[stage] | yes | Installation of the files in the correct pathes<br>host: TOOLCHAIN<br>target: SYSROOT and IMAGE<br>bootstrap and init: temporary destination
| addon                   | -      | Copy all files together for addon creation. This is requiered for addons |

###### Example
```
post_patch() {
  # replace hardcoded stuff
  sed -i $PKG_BUILD/Makefile 's|hardcoded stuff|variabled stuff|'
}

pre_configure_target() {
  CFLAGS="$CFLAGS -DEXTRA_FLAG=yeah"
}

post_makeinstall_target() {
  # remove unused executable, only library needed
  rm $INSTALL/usr/bin/bigexecutable
}
```

## Add a new package to the Image
1. Think about, why you needs it in the image.
    * new multimedia tool
    * add a new network tool
    * new kernel driver
    * ...
2. Find a place in the packages-tree
    * look into the package-tree, i think most is self explaind. When 1. was done, this is going fast :)
    * do not place it, in an existing package (directory with includes a `package.mk`)
    * when you found a place, create a directory with the name of your package (must the same like `PKG_NAME`!!)
3. Create a initial `package.mk`
    * you found a template under `packages/package.mk.template`. Copy the template into the new directory and call it `package.mk`
    * edit your new `package.mk`
4. Find a place in the dependency tree. When 1. was done, this is going fast, again :)
    * when it extend an existing package, add it there to the `PKG_DEPENDS_TARGET`
    * take a look into the path `packages/virtual`, there you should find a virtual packages, that match your new package (misc-packages should the last option)
5. now you can build your image
    * after the build, under build-[...]/ should apear a directory with your package-name and -version.

## Example
```
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mariadb-connector-c"
PKG_VERSION="3.0.2"
PKG_SHA256="f44f436fc35e081db3a56516de9e3bb11ae96838e75d58910be28ddd2bc56d88"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://mariadb.org/"
PKG_URL="https://github.com/MariaDB/mariadb-connector-c/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_SECTION="database"
PKG_SHORTDESC="mariadb-connector: library to conntect to mariadb/mysql database server"
PKG_LONGDESC="mariadb-connector: library to conntect to mariadb/mysql database server"

PKG_CMAKE_OPTS_TARGET="-DWITH_EXTERNAL_ZLIB=ON
                       -DAUTH_CLEARTEXT=STATIC
                       -DAUTH_DIALOG=STATIC
                       -DAUTH_OLDPASSWORD=STATIC
                       -DREMOTEIO=OFF
                      "

post_makeinstall_target() {
  # drop all unneeded
  rm -rf $INSTALL/usr
}
```

