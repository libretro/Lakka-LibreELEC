#!/bin/bash

# Setup:
# git clone -b rpi-4.4.y --depth=1000 --single-branch git@github.com:raspberrypi/linux.git raspberrypi-linux
# git remote add -t linux-4.4.y linux-stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
# git config --local core.abbrev 40
# Update:
# git fetch --all --depth=1000
# git reset --hard origin/rpi-4.4.y
# GIT_SEQUENCE_EDITOR=../rpi-linux-rebase.sh git rebase -i linux-stable/linux-4.4.y
# git format-patch --no-signature --stdout linux-stable/linux-4.4.y > ../linux-01-RPi_support.patch

TODO=$1

# Drop commits not used
DROP_COMMITS="
Added Device IDs for August DVB-T 205
net\: Add non-mainline source for rtl8192cu wlan
net\: Fix rtl8192cu build errors on other platforms

# Other rtl8192cu related commits below...
Fix cfg80211 for kernel >= 4.7 \(#1624\)
suppress spurious messages
Add #if for 3\.14 kernel change \(#87\)
Set dev_type to wlan
Tentatively added support for more 8188CUS based devices\.
Add support for more 8188CUS and 8192CUS devices
Add ProductId for the Netgear N150 - WNA1000M
Fixes CONFIG_CONCURRENT_MODE CONFIG_MULTI_VIR_IFACES
Fixes compatibility with 3\.13
Enables warning in the compiler and fixes some issues, reference => https\:\/\/github.com\/diederikdehaas\/rtl8812AU
Starts device in station mode instead of monitor, fixes NetworkManager issues
Enable cfg80211 support
"

IFS=$'\n'
for COMMIT in $DROP_COMMITS; do
  sed -i -E "s/^pick ([0-9a-f]+) (${COMMIT}.*)/drop \1 \2/g" $TODO
done

grep -E "^drop " $TODO > /tmp/dropped
sed -i -E "/^drop /d" $TODO
