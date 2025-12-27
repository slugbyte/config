#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: isoburn <iso_file> <disk_path>"
    echo "Example: isoburn ubuntu.iso /dev/sdb"
    exit 1
fi

infile="$1"
disk_path="$2"

if [[ ! -f "$infile" ]]; then
    echo "Error: '$infile' not found"
    exit 1
fi

if [[ ! -e "$disk_path" ]]; then
    echo "Error: '$disk_path' does not exist"
    exit 1
fi

sudo dd if="$infile" of="$disk_path" bs=4M status=progress conv=fsync
