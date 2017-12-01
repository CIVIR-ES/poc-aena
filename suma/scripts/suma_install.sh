#!/bin/bash

set -eux

SUSE_USER=
SUSE_REGCODE=

SUSEConnect -e ${SUSE_USER} -r ${SUSE_REGCODE}
SUSEConnect -p SUSE-Manager-Server/3.1/x86_64 -r ${SUSE_REGCODE}

zypper refresh

#Workaround to resolve salt version dependency of pattern
zypper --non-interactive install --force -t package salt-2016.11.4-4.3.1
zypper --non-interactive install --auto-agree-with-licenses -t pattern suma_server

#Workaround for hostname -f timeout
sed -i 's/^127.0.0.1/127.0.0.1 suma.aena.lan suma localhost/g' /etc/hosts

chmod +x /tmp/setup_env.sh
mv /tmp/setup_env.sh /root/

touch /etc/cloud/cloud-init.disabled

sync; reboot
