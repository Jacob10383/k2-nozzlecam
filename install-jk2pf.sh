#!/bin/sh

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

# copy the 3docam.env file to /etc/ustreamer/3docam.env
cp -f "${SCRIPT_DIR}/3docam.env" /etc/ustreamer/3docam.env

# Start the camera service immediately
systemctl start ustreamer@3docam

# Enable the service to start automatically on system boot
systemctl enable ustreamer@3docam

# add the macro 3dov4lctls.cfg into the printer.cfg file
python "${SCRIPT_DIR}/ensure_included.py" \
    ~/printer_data/config/overrides.cfg 3dov4lctls.cfg

echo "Installation complete. reboot klipper to load the new 3DO camera control macros."
