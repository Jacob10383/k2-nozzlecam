#!/bin/sh

set -e

SCRIPT_DIR="$(readlink -f $(dirname $0))"

# return original auto_uvc if backup exists
if [ -e /usr/bin/auto_uvc.sh.bak ] && [ -e /usr/bin/auto_uvc.sh ]; then
    rm -rf /usr/bin/auto_uvc.sh
	cp -p /usr/bin/auto_uvc.sh.bak /usr/bin/auto_uvc.sh
	rm -rf /usr/bin/auto_uvc.sh.bak
fi


# return original 60-v4l if backup exists
if [ -e /etc/hotplug.d/usb/60-v4l.bak ] && [ -e /etc/hotplug.d/usb/60-v4l ]; then
    rm -rf /etc/hotplug.d/usb/60-v4l
	cp -p /etc/hotplug.d/usb/60-v4l.bak /etc/hotplug.d/usb/60-v4l
	rm -rf /etc/hotplug.d/usb/60-v4l.bak
fi

# remove the old symlinks
rm -rf /usr/bin/ustreamer
rm -rf /mnt/UDISK/printer_data/config/custom/v4lctls.cfg
rm -rf /usr/share/klipper/klippy/extras/gcode_shell_command.py

# remove the v4lctls macro file
python ${SCRIPT_DIR}/ensure_included.py \
    ~/printer_data/config/custom/main.cfg v4lctls.cfg --remove

echo "Uninstallation complete. reboot the system to apply changes."
