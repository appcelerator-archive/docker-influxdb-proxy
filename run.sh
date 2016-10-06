#!/bin/sh

cfg=/usr/local/etc/haproxy/haproxy.cfg
maxconn=512

grep -q " backend relays" $cfg
if [ $? -ne 0 ]; then
  echo "Updating configuration file..."
  echo "    backend relays" >> $cfg
  for relay in $(env | grep "^RELAY_"); do
    key=$(echo $relay | cut -d= -f1)
    value=$(echo $relay | cut -d= -f2)
    name=$(echo $value | cut -d: -f1)
    echo "        server $name $value maxconn $maxconn" >> $cfg
  done
  echo "    backend backends" >> $cfg
  for backend in $(env | grep "^BACKEND_"); do
    key=$(echo $backend | cut -d= -f1)
    value=$(echo $backend | cut -d= -f2)
    name=$(echo $value | cut -d: -f1)
    port=$(echo $value | cut -d: -f2)
    if [ -z "$port" ]; then port=8086 ; fi
    echo "        server $name $name:$port maxconn $maxconn" >> $cfg
  done
  echo "    backend ui-backends" >> $cfg
  for backend in $(env | grep "^BACKEND_"); do
    key=$(echo $backend | cut -d= -f1)
    value=$(echo $backend | cut -d= -f2)
    name=$(echo $value | cut -d: -f1)
    port=$(echo $value | cut -d: -f3)
    if [ -z "$port" ]; then port=8083 ; fi
    echo "        server $name $name:$port maxconn $maxconn" >> $cfg
  done
echo "done"
else
  echo "Configuration already set"
fi
cat $cfg

exec "$(which haproxy-systemd-wrapper)" -p /run/haproxy.pid -f $cfg "$@"
