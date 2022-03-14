# L4T Developer Guide

## What Works

1. Tegra BSP Libs on tegra210 devices(Untested elsewhere)
2. ffmpeg encoding/decoding using nvv4l2 encoder/decoder on tegra chips.

## What Still needs to be done:
1. Kernel get script needs proper cleanup and zip downloading/merge patching support for non switch version finished/tested.
2. There is no bootloader support for standard tegra devices. I dont have any, so this is an undertaking I am unwilling to do at this time.
3. Tegra-BSP might need some work on non t210 boards, I havnt bothered testing building for them. Probably the biggest differences will be the config file, or file name issues, the logic should be about the same.


## Basic L4T Device Options:

```
GENERIC_L4T_VERSION= # Available Options: [ 32.3.1 32.4.2 32.4.3 32.4.4 32.5 32.5.1 32.6 32.6.1 32.7.1 ] 
L4T_DEVICE_TYPE="" # Available Options: [ t210 t18x t19x ]
```
Sha256 of generated file.

This doesnt work properly, but when I refactor l4t_kernel_get stuff I plan on fixing it
```
L4T_COMBINED_KERNEL_SHA256=""
```
## Optional L4T Options:
### Only set if you need to, these point at nvidia tegra git by default.

### Only Use REPO or URL, never both at the same time

### Currently URL Downloading is broken/not implemented. Still needs work.

### This is default if not using custom kernel branches. I never bothered rebasing patches on generic kernels. [ 0 or 1]
```
FORCE_GENERIC_L4T_PATCHES=
```
### This is only used in conjunction with L4T_DEVICE_CUSTOM_* and is needed to place custom board dts properly in kernel tree.
```
L4T_DEVICE_CUSTOM_BOARD_NAME=""
```
### These should be self explanitory if not check projects/L4T/devices/Switch/options
```
L4T_KERNEL_4_9_REPO=""
L4T_KERNEL_4_9_REPO_BRANCH=""
L4T_KERNEL_4_9_REPO_SHA256=""
L4T_KERNEL_4_9_URL=""

L4T_KERNEL_NVIDIA_REPO=""
L4T_KERNEL_NVIDIA_REPO_BRANCH=""
L4T_KERNEL_NVIDIA_REPO_SHA256=""
L4T_KERNEL_NVIDIA_URL=""

L4T_KERNEL_NVGPU_REPO=""
L4T_KERNEL_NVGPU_REPO_BRANCH=""
L4T_KERNEL_NVGPU_REPO_SHA256=""
L4T_KERNEL_NVGPU_URL=""

L4T_DEVICE_TEGRA_REPO=""
L4T_DEVICE_TEGRA_REPO_BRANCH=""
L4T_DEVICE_TEGRA_REPO_SHA256=""
L4T_DEVICE_TEGRA_URL=""

L4T_DEVICE_COMMON_TEGRA_REPO=""
L4T_DEVICE_COMMON_TEGRA_REPO_BRANCH=""
L4T_DEVICE_COMMON_TEGRA_REPO_SHA256=""
L4T_DEVICE_COMMON_TEGRA_URL=""
```
### These depend on L4T_DEVICE_TYPE, and wont be used if not building for t210
```
L4T_DEVICE_COMMON_T210_REPO=""
L4T_DEVICE_COMMON_T210_REPO_BRANCH=""
L4T_DEVICE_COMMON_T210_REPO_SHA256=""
L4T_DEVICE_COMMON_T210_URL=""

L4T_DEVICE_T210_REPO=""
L4T_DEVICE_T210_REPO_BRANCH=""
L4T_DEVICE_T210_REPO_SHA256=""
L4T_DEVICE_T210_URL=""

L4T_DEVICE_T210_JETSON_REPO=""
L4T_DEVICE_T210_JETSON_REPO_BRANCH=""
L4T_DEVICE_T210_JETSON_REPO_SHA256=""
L4T_DEVICE_T210_JETSON_URL=""

L4T_DEVICE_T210_BATUU_REPO=""
L4T_DEVICE_T210_BATUU_REPO_BRANCH=""
L4T_DEVICE_T210_BATUU_REPO_SHA256=""
L4T_DEVICE_T210_BATUU_URL=""

L4T_DEVICE_T210_PORG_REPO=""
L4T_DEVICE_T210_PORG_REPO_BRANCH=""
L4T_DEVICE_T210_PORG_REPO_SHA256=""
L4T_DEVICE_T210_PORG_URL=""
```
### These depend on L4T_DEVICE_TYPE, and wont be used if not building for t18x
```
L4T_DEVICE_COMMON_T18X_REPO=""
L4T_DEVICE_COMMON_T18X_REPO_BRANCH=""
L4T_DEVICE_COMMON_T18X_REPO_SHA256=""
L4T_DEVICE_COMMON_T18X_URL=""

L4T_DEVICE_T18X_REPO=""
L4T_DEVICE_T18X_REPO_BRANCH=""
L4T_DEVICE_T18X_REPO_SHA256=""
L4T_DEVICE_T18X_URL=""

L4T_DEVICE_T18X_QUILL_REPO=""
L4T_DEVICE_T18X_QUILL_REPO_BRANCH=""
L4T_DEVICE_T18X_QUILL_REPO_SHA256=""
L4T_DEVICE_T18X_QUILL_URL=""
```
### These depend on L4T_DEVICE_TYPE, and wont be used if not building for t19x
```
L4T_DEVICE_COMMON_T19X_REPO=""
L4T_DEVICE_COMMON_T19X_REPO_BRANCH=""
L4T_DEVICE_COMMON_T19X_REPO_SHA256=""
L4T_DEVICE_COMMON_T19X_URL=""

L4T_DEVICE_T19X_REPO=""
L4T_DEVICE_T19X_REPO_BRANCH=""
L4T_DEVICE_T19X_REPO_SHA256=""
L4T_DEVICE_T19X_URL=""

L4T_DEVICE_T19X_GALEN_REPO=""
L4T_DEVICE_T19X_GALEN_REPO_BRANCH=""
L4T_DEVICE_T19X_GALEN_REPO_SHA256=""
L4T_DEVICE_T19X_GALEN_URL=""

L4T_DEVICE_T19X_JAKKU_REPO=""
L4T_DEVICE_T19X_JAKKU_REPO_BRANCH=""
L4T_DEVICE_T19X_JAKKU_REPO_SHA256=""
L4T_DEVICE_T19X_JAKKU_URL=""
```

### Apply Custom Device DTS tree.
```
L4T_DEVICE_CUSTOM_REPO=""
L4T_DEVICE_CUSTOM_REPO_BRANCH=""
L4T_DEVICE_CUSTOM_REPO_SHA256=""
L4T_DEVICE_CUSTOM_REPO_URL=""
```
