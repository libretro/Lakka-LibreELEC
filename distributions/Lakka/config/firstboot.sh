#!/bin/sh

wifi_cfg=/flash/wifi-config.txt
ra_overrides=/flash/retroarch-overrides.txt
ra_defaults=/etc/retroarch.cfg
config_path=/storage/.config
auto_script=${config_path}/autostart.sh
ra_cfg_path=${config_path}/retroarch
ra_cfg_file=${ra_cfg_path}/retroarch.cfg

# prepare empty autostart.sh
[ ! -d ${config_path} ] && mkdir ${config_path}
touch ${auto_script}
chmod +x ${auto_script}
tee -a ${auto_script} << END
#!/bin/sh

END

# setup network
SSID=""
PSK=""
COUNTRY=""

[ -f ${wifi_cfg} ] && . ${wifi_cfg}

if [ -n "${SSID}" -a -n ${PSK} ]; then
  tee -a ${auto_script} << END
(
  echo "enable wifi"
  echo "scan wifi"
) | connmanctl

sleep 5
ID=\$(connmanctl services | grep -e "\s${SSID}\s" | awk '{print \$(NF)}')

(
echo "agent on"
echo "connect \$ID"
sleep 5
echo "${PSK}"
) | connmanctl
END
fi

if [ -n "${COUNTRY}" ]; then
  iw reg set ${COUNTRY}
fi

# apply RetroArch overrides to default configuration
if [ -f ${ra_overrides} ]; then
  [ ! -d ${ra_cfg_path} ] && mkdir ${ra_cfg_path}
  [ ! -f ${ra_cfg_file} ] && cp ${ra_defaults} ${ra_cfg_file}
  while IFS= read -r line ; do
    [ -z "${line}" ] && continue
    [ "${line:0:1}" = "#" ] && continue
    key=$(echo ${line} | awk '{ print $1; }')
    sed -i "/${key} =/d" ${ra_cfg_file}
    echo "${line}" >> ${ra_cfg_file}
  done < ${ra_overrides}
fi

# If you want to put anything else to be executed on the first boot
# (and only on the first boot), put it here.



# Do not put anything below here. But you can above here.

# close autostart.sh - remove self after finished
echo "rm ${auto_script}" >> ${auto_script}
