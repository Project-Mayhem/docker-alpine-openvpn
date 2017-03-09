#!/bin/bash

usage() { echo "Usage: $0 [-d for interactive vpn]" 1>&2; exit 1; }

while getopts ":d" o; do
    case "${o}" in
        d)
            DEBUG=true
            ;;
        *)
            usage
            ;;
    esac
done

#updating DNS
if [ -f "/opt/config/resolv.conf" ]; then
  cat /opt/config/resolv.conf >> /etc/resolv.conf
fi

echo "Running openvpn client script..."
openvpn --config /opt/config/client.ovpn &
sleep 12
echo "vpn is now open."

# Cheezy way to determine that we quit if the openvpn process ends
if [ $DEBUG == "true" ]; then
  echo "do your work  :)"
else
  while :
  do
    pid=`pgrep -o -x openvpn`
    if [ $? -eq 1 ];
    then
      echo "vpn is now closed."
      # java process has stopped running!
      pkill openvpn
      exit 1
    else
      # echo "Minecraft still running: $pid"
      sleep 10
    fi
  done
fi
