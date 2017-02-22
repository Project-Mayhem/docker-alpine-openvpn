#!/bin/bash

echo "Running openvpn client script..."
openvpn --config /opt/config/client.ovpn
echo "done running script... Cloning registry or task is now complete."
