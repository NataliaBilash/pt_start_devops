#!/bin/bash
set -Eeo pipefail

#инициализирует базу данных
/usr/local/bin/docker-entrypoint.sh postgres &


echo "${RM_USER}:${RM_PASSWORD}" | chpasswd
echo 'PermitRootLogin yes'       >> /etc/ssh/sshd_config
echo "Port ${RM_PORT}"           >> /etc/ssh/sshd_config


service ssh start
wait $!
