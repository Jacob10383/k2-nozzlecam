#!/bin/sh

set -e

SCRIPT_DIR="$(readlink -f "$(dirname "$0")")"

echo "============================================="
echo "             3DoCam Uninstaller              "
echo "============================================="
echo "Please select which 3DO installation to remove:"
echo "1) Creality Firmware 3DO uninstall (uninstall.sh)"
echo "2) Jacob K2 Plus Firmware 3DO uninstall (uninstall-jk2pf.sh)"
echo "3) Exit"
echo "============================================="
printf "Enter your choice [1-3]: "
read -r CHOICE

case "$CHOICE" in
    1)
        TARGET_SCRIPT="${SCRIPT_DIR}/uninstall.sh"
        ;;
    2)
        TARGET_SCRIPT="${SCRIPT_DIR}/uninstall-jk2pf.sh"
        ;;
    3)
        echo "Uninstall canceled."
        exit 0
        ;;
    *)
        echo "Invalid option. Exiting." >&2
        exit 1
        ;;
esac

# Check if the selected script actually exists
if [ ! -f "$TARGET_SCRIPT" ]; then
    echo "Error: Configuration script not found at: $TARGET_SCRIPT" >&2
    exit 1
fi

# Make sure the target script is executable and run it
chmod +x "$TARGET_SCRIPT"
echo "Starting installation: $(basename "$TARGET_SCRIPT")..."
exec "$TARGET_SCRIPT"
