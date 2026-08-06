#!/bin/sh

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

# copy the 3docam.env file to /etc/ustreamer/3docam.env
cp -f "${SCRIPT_DIR}/3docam.env" /etc/ustreamer/3docam.env

# Start the camera service immediately
systemctl start ustreamer@3docam

# Enable the service to start automatically on system boot
systemctl enable ustreamer@3docam

# copy the 3dov4lctls.cfg to /mnt/UDISK/printer_data/config/3dov4lctrls.cfg
cp -f "${SCRIPT_DIR}/3dov4lctls.cfg" /mnt/UDISK/printer_data/config/3dov4lctls.cfg

# add the macro 3dov4lctls.cfg into the printer.cfg file
python "${SCRIPT_DIR}/ensure_included.py" \
    ~/printer_data/config/overrides.cfg 3dov4lctls.cfg

echo "Installation complete. reboot klipper to load the new 3DO camera control macros."
