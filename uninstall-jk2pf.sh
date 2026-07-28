#!/bin/sh

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

# remove the v4lctls.cfg file
rm -f /mnt/UDISK/printer_data/config/v4lctls.cfg

# remove the 3docam.env file
rm -f /etc/ustreamer/3docam.env

# remove the v4lctls gcode macro line from overrides.cfg
python "${SCRIPT_DIR}/ensure_included.py" \
    ~/printer_data/config/overrides.cfg v4lctls.cfg --remove

echo "Uninstallation complete. reboot the system to apply changes."
