## Raspberry Pi Linux Kernel Patch Instructions

This is needed because we drop a few commits from the upstream Raspberry Pi linux repo

The commit id's will change anytime the Raspberry Pi linux kernel is rebase against upstream

#### Clone the repo
```
git clone https://github.com/raspberrypi/linux.git
cd linux
```

#### Checkout the branch
```
git checkout rpi-4.4.y
```

#### Find the rebase commit, for example
```
git log --grep 'Linux 4.4.6'
```
#### This will show a commit
```
commit 0d1912303e54ed1b2a371be0bba51c384dd57326
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Mar 16 08:43:17 2016 -0700

    Linux 4.4.6
```

#### We need to rebase against this commit sha1
```
git rebase -i 0d1912303e54ed1b2a371be0bba51c384dd57326
```

#### Then we need to remove some commits. These lines need to be removed
```
pick 9ee3100 Add non-mainline source for rtl8192cu wireless driver version v4.0.2_9000 as this is widely used. Disabled older rtlwifi driver
pick 143ad45 rtl8192c_rf6052: PHY_RFShadowRefresh(): fix off-by-one
pick 95641b7 rtl8192cu: Add PID for D-Link DWA 131
pick fbd8454 Added Device IDs for August DVB-T 205
```

#### Then we can create the patch using the same commit sha1
```
git format-patch 0d1912303e54ed1b2a371be0bba51c384dd57326 --cover-letter --stdout > linux-01-RPi_support.patch
```

----
#### Rebase conflict

```
git reset --hard HEAD
git checkout master
git branch -D rpi-4.4.y
git pull
git checkout rpi-4.4.y
```

----
#### Further Discussion

https://github.com/LibreELEC/LibreELEC.tv/pull/31
