#!/bin/bash

set -euo pipefail

THEME_NAME="lackluster"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/plymouth/$THEME_NAME"
TARGET_DIR="/usr/share/plymouth/themes/$THEME_NAME"

REQUIRED_FILES=(
  "lackluster.plymouth"
  "lackluster.script"
  "logo.png"
  "lock.png"
  "entry.png"
  "bullet.png"
  "progress_bar.png"
  "progress_box.png"
)

for file in "${REQUIRED_FILES[@]}"; do
  if [[ ! -f "$SOURCE_DIR/$file" ]]; then
    echo "Missing required theme file: $SOURCE_DIR/$file" >&2
    exit 1
  fi
done

echo "Installing Plymouth theme '$THEME_NAME' from $SOURCE_DIR"
sudo mkdir -p "$TARGET_DIR"

for file in "${REQUIRED_FILES[@]}"; do
  sudo cp "$SOURCE_DIR/$file" "$TARGET_DIR/$file"
done

sudo plymouth-set-default-theme "$THEME_NAME"

if command -v limine-mkinitcpio &>/dev/null; then
  sudo limine-mkinitcpio
else
  sudo mkinitcpio -P
fi

echo "Install complete. Current default theme: $(plymouth-set-default-theme)"
echo "Rollback command:"
echo "  sudo plymouth-set-default-theme omarchy && (command -v limine-mkinitcpio >/dev/null && sudo limine-mkinitcpio || sudo mkinitcpio -P)"
