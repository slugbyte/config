# Lackluster Plymouth Theme

This repo stores a portable copy of the custom `lackluster` Plymouth boot splash theme.

## Contents

- `plymouth/lackluster/` theme files
- `install.sh` installer script

## Install

```bash
chmod +x ./install.sh
./install.sh
```

What install does:

1. Validates required theme files exist.
2. Copies only required files to `/usr/share/plymouth/themes/lackluster/`.
3. Sets default Plymouth theme to `lackluster`.
4. Rebuilds initramfs via `limine-mkinitcpio` when available, otherwise `mkinitcpio -P`.

## Verify

```bash
plymouth-set-default-theme
```

Expected output:

```text
lackluster
```

Reboot to see the full boot splash.

## Rollback to Omarchy

```bash
sudo plymouth-set-default-theme omarchy && (command -v limine-mkinitcpio >/dev/null && sudo limine-mkinitcpio || sudo mkinitcpio -P)
```
