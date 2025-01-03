#!/usr/bin/env bash

set -e

if [ "$EUID" -ne 0 ]; then
    # If not, re-execute the script with sudo
    echo "This script requires root privileges. Elevating..."
    sudo bash "$0" "$@"
    exit $?
fi

# Check if the envsubst is installed
if ! nix-env -q envsubst >/dev/null 2>&1; then
    nix-env -iA nixos.envsubst
fi

DEVICE="/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0"
if [ ! -b "$DEVICE" ]; then
  echo "ERROR: The default disk $DEVICE is missing!"
  exit 1;
fi

# List partitions on the device
PARTITIONS=$(lsblk "$DEVICE" --output NAME --noheadings --raw | wc -l)

# Check if partitions exist
if [ "$PARTITIONS" != 1 ]; then
    echo "Looks like the disk partitions are already setup, skipping this step!"
else
    parted $DEVICE -- mklabel gpt
    parted $DEVICE -- mkpart root ext4 512MB -8GB
    parted $DEVICE -- mkpart swap linux-swap -8GB 100%    
    parted $DEVICE -- mkpart ESP fat32 1MB 512MB
    parted $DEVICE -- set 3 esp on

    sync

    mkfs.ext4 -L nixos $DEVICE-part1
    mkswap -L swap $DEVICE-part2
    mkfs.fat -F 32 -n boot  $DEVICE-part3

    sync
    
    swapon $DEVICE-part2
    mount /dev/disk/by-label/nixos /mnt

    mkdir -p /mnt/boot
    mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
fi

nixos-generate-config --root /mnt

# download the configuation.nix template
curl -s "https://raw.githubusercontent.com/kwull/nix-config/main/hosts/nixos/artemis/default.nix?x$(date +%s)" > configuration.nix

nixos-install

while true; do
    read -p "Do you want to reboot now? (y/n) " yn
    case $yn in
        [Yy]* )
            reboot
            break;;
        [Nn]* )
            exit;;
        * )
            echo "Please answer y or n.";;
    esac
done