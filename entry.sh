#!/bin/bash

echo "Running openvpn client script..."
openvpn --config /opt/config/client.ovpn &
sleep 10
echo "vpn is now open."

# Cheezy way to determine that we quit if the openvpn process ends
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
