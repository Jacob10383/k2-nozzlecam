#!/usr/bin/env python3

import sys
import os

if len(sys.argv) < 3:
    print("Usage: python ensure_included.py <target_cfg> <include_file> [--remove]")
    sys.exit(1)

target_path = os.path.expanduser(sys.argv[1])
include_file = sys.argv[2]
include_line = f"[include {include_file}]"
remove_mode = "--remove" in sys.argv

if os.path.exists(target_path):
    with open(target_path, "r") as f:
        lines = f.readlines()
else:
    lines = []

if remove_mode:
    # Filter out the include line
    new_lines = [line for line in lines if line.strip() != include_line]
    if len(lines) != len(new_lines):
        with open(target_path, "w") as f:
            f.writelines(new_lines)
        print(f"Removed {include_line} from {target_path}")
    else:
        print(f"{include_line} was not found.")
else:
    # Standard add logic
    if not any(line.strip() == include_line for line in lines):
        with open(target_path, "a") as f:
            f.write(f"\n{include_line}\n")
        print(f"Added {include_line} to {target_path}")
    else:
        print(f"{include_line} is already included.")
