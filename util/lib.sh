#!/usr/bin/env bash
# Shared helpers for conf install scripts.
# Source this file after setting: set -euo pipefail
#
# Provides:
#   DRY_RUN   — true by default, false when caller passes --plz
#   run_safe  — run a command (or print it in dry-run mode)
#   trash_existing — trash a non-symlink file, remove symlinks
#   link_if_exists — symlink $1 → $2, trashing any existing $2

DRY_RUN=true
[[ "${1:-}" == "--plz" ]] && DRY_RUN=false

trash="$HOME/.local/share/Trash/files"
trashed_filepath_list=()

# Run a command if DRY_RUN is false, print the command if true.
# $ run_safe cmd --arg1 --arg2 --arg3
run_safe(){
  if $DRY_RUN;then
    echo "[MOCK]" "$@"
  else
    # silent in non mock mode
    "$@" >/dev/null 2>&1
  fi
}

# Trash a file if it exists and is not a symlink.
# $ trash_existing ./file/to/trash
trash_existing(){
  # skip if doesn't exist or is a symlink
  [[ -e "$1" ]] || return 0
  if [[ -L "$1" ]]; then
    run_safe rm "$1"
    return 0
  fi

  trashed_filepath_list+=("$1")
  if command -v trash >/dev/null 2>&1; then
    run_safe trash "$1"
  else
    local dest
    dest="$trash/$(basename "$1").backup.$$.$RANDOM"
    run_safe mv "$1" "$dest"
  fi
}

# If $src exists, force link to $dest.  Trash $dest first if it exists.
# $ link_if_exists $src $dest
link_if_exists(){
  if [[ -e "$1" ]];then
    trash_existing "$2"
    run_safe ln -sf "$1" "$2"
    echo "[LINK] $1 -> $2"
  fi
}
