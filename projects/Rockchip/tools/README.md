# Tools

Helper scripts to update patches

Example usage:

```
# cat ~/.bash_aliases
alias build-tinker='cd ~/LibreELEC && PROJECT=Rockchip DEVICE=TinkerBoard ARCH=arm make image'
alias update-kodi='cd ~/kodi && ~/LibreELEC/projects/Rockchip/tools/update-kodi-patches.sh'
alias update-ffmpeg='cd ~/ffmpeg && ~/LibreELEC/projects/Rockchip/tools/update-ffmpeg-patches.sh'
alias update-mali='cd ~/libmali && ~/LibreELEC/projects/Rockchip/tools/update-libmali-patches.sh'
alias update-linux-4.4='cd ~/linux-rockchip && ~/LibreELEC/projects/Rockchip/tools/update-linux-patches-4.4.sh'
alias update-uboot='cd ~/u-boot-rockchip && ~/LibreELEC/projects/Rockchip/tools/update-u-boot-patches.sh'
```
