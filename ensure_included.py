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
        content = f.read()
else:
    content = ""

# Split content by lines, keeping trailing newlines intact
lines = content.splitlines()

if remove_mode:
    # Match lines while ignoring leading/trailing spaces on the line itself
    new_lines = [line for line in lines if line.strip() != include_line]
    
    if len(lines) != len(new_lines):
        # Rejoin and write back if changes were made
        with open(target_path, "w") as f:
            f.write("\n".join(new_lines) + ("\n" if new_lines else ""))
        print(f"Removed {include_line} from {target_path}")
    else:
        print(f"{include_line} was not found.")
else:
    # Check if the stripped include line already exists anywhere
    if not any(line.strip() == include_line for line in lines):
        # Strip trailing spaces from file content before adding to keep it tidy
        clean_content = content.rstrip()
        new_content = clean_content + f"\n\n{include_line}\n" if clean_content else f"{include_line}\n"
        
        with open(target_path, "w") as f:
            f.write(new_content)
        print(f"Added {include_line} to {target_path}")
    else:
        print(f"{include_line} is already included.")
