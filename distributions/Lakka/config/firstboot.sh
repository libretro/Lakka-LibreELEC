#!/bin/sh

wifi_cfg=/flash/wifi-config.txt
ra_overrides=/flash/retroarch-overrides.txt
ra_temp_ov=/flash/retroarch-overrides.tmp
ra_defaults=/etc/retroarch.cfg
ra_core_def_path=/etc/retroarch/config
config_path=/storage/.config
auto_script=${config_path}/autostart.sh
ra_cfg_path=${config_path}/retroarch
ra_cfg_file=${ra_cfg_path}/retroarch.cfg
ra_core_cfg_path=${ra_cfg_path}/config

echo "${0}: Started"

# prepare empty autostart.sh
[ ! -d ${config_path} ] && mkdir ${config_path}
touch ${auto_script}
chmod +x ${auto_script}
echo "#!/bin/sh" >${auto_script}

# setup network
SSID=""
PSK=""
COUNTRY=""

[ -f ${wifi_cfg} ] && . ${wifi_cfg}

if [ -n "${SSID}" -a -n ${PSK} ]; then
  cat << EOF >>${auto_script}

wifilog=/storage/autostart-wifi-config.log
[ -f \${wifilog} ] && rm \${wifilog}

connmanctl enable wifi 2>&1 >>\${wifilog}
connmanctl scan wifi 2>&1 >>\${wifilog}
connmanctl services 2>&1 >>\${wifilog}

ID=\$(connmanctl services | grep -e "\s${SSID}\s" | awk '{print \$(NF)}')

echo "ID: \${ID}" >>\${wifilog}

if [ -n "\${ID}" ]; then
  (
    echo "agent on"
    echo "connect \${ID}"
    sleep 5
    echo "${PSK}"
  ) | connmanctl 2>&1 >>\${wifilog}
fi
EOF
  echo "${0}: Added wifi setup to ${auto_script}"
fi

if [ -n "${COUNTRY}" ]; then
  echo "${0}: Registering country ${COUNTRY} for wifi:"
  iw reg set ${COUNTRY} 2>&1
fi

# apply RetroArch overrides to default configuration
if [ -f ${ra_overrides} ]; then
  [ -f ${ra_temp_ov} ] && rm ${ra_temp_ov}
  [ ! -d ${ra_cfg_path} ] && mkdir ${ra_cfg_path}
  [ ! -f ${ra_cfg_file} ] && cp ${ra_defaults} ${ra_cfg_file}
  while IFS= read -r line ; do
    [ -z "${line}" ] && { echo "${line}" >> ${ra_temp_ov} ; continue ; }
    [ "${line:0:1}" = "#" ] && { echo "${line}" >> ${ra_temp_ov} ; continue ; }
    key=$(echo ${line} | awk '{ print $1; }')
    sed -i "/${key} =/d" ${ra_cfg_file}
    echo "${line}" >> ${ra_cfg_file}
    echo "#${line}" >> ${ra_temp_ov}
    echo "${0}: Processed '${line}' into ${ra_cfg_file}"
  done < ${ra_overrides}
  [ -f ${ra_temp_ov} ] && mv ${ra_temp_ov} ${ra_overrides}
fi

# copy included core configuration
if [ -d ${ra_core_def_path} ]; then
  [ ! -d ${ra_core_cfg_path} ] && mkdir -p ${ra_core_cfg_path}
  echo "${0}: Copying core configurations to ${ra_core_cfg_path}"
  cp -vr ${ra_core_def_path}/* ${ra_core_cfg_path}
fi

# If you want to put anything else to be executed on the first boot
# (and only on the first boot), put it below here.
# v v v v v v v v v v v v v v v v v v v v



# ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^
# Do not put anything below here. But you can above here.

# close autostart.sh - remove self after finished
echo "rm ${auto_script}" >> ${auto_script}
echo "${0}: Finished"
