#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)

if [ -f /storage/.config/suspend-modules.conf ]; then
    . /storage/.config/suspend-modules.conf
    custom_modules="${SUSPEND_MODULES}"
    SUSPEND_MODULES=""
fi

. /etc/suspend-modules.conf

if [ -n "${custom_modules}" ]; then
    SUSPEND_MODULES="${SUSPEND_MODULES} ${custom_modules}"
fi

modunload()
{
    local MOD D C USED MODS I
    local UNL="$(echo $1 |tr - _)" RET=1

    while read MOD D C USED D; do
        [ "$MOD" = "$UNL" ] || continue
        if [ "$USED" = "-" ]; then
            # no dependent modules, just try to remove this one.
            _rmmod "$MOD" $C
            RET=$?
        else
            # modules depend on this one.  try to remove them first.
            MODS=",${USED%,}"
            while [ -n "${MODS}" ]; do
                # try to unload the last one first
                MOD="${MODS##*,}"
                modunload $MOD && RET=0
                # prune the last one from the list
                MODS="${MODS%,*}"
            done
            # if we unloaded at least one module, then let's
            # try again!
            [ $RET -eq 0 ] && modunload $MOD
            RET=$?
        fi
        return $RET
    done < /proc/modules
    # if we came this far, there was nothing to do,
    # the module is no longer loaded.
    return 0
}

_rmmod()
{
    if modprobe -r "$1"; then
        touch "/run/libreelec/suspend/module:$1"
        return 0
    else
        logger -t suspend-modules "# could not unload '$1', usage count was $2"
        return 1
    fi
}

resume_modules()
{
    for x in /run/libreelec/suspend/module:* ; do
        [ -O "${x}" ] || continue
        modprobe "${x##*:}" &>/dev/null && \
            logger -t resume-modules "Reloaded module ${x##*:}." || \
            logger -t resume-modules "Could not reload module ${x##*:}."
    done
}

suspend_modules()
{
    [ -z "$SUSPEND_MODULES" ] && return 0
    # clean up
    rm -rf /run/libreelec/suspend
    mkdir -p /run/libreelec/suspend
    for x in $SUSPEND_MODULES ; do
        modunload $x && \
            logger -t suspend-modules "Unloading kernel module $x: Done" || \
            logger -t suspend-modules "Unloading kernel module $x: Failed"
    done
    return 0
}

case $1 in
    pre)
        suspend_modules
    ;;
    post)
        resume_modules
    ;;
esac
