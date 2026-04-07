#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.claude"

source "$SCRIPT_DIR/../../util/lib.sh" "$@"

mkdir -p "$TARGET"
mkdir -p "$TARGET/skills"

link_if_exists "$SCRIPT_DIR/CLAUDE.md"          "$TARGET/CLAUDE.md"
link_if_exists "$SCRIPT_DIR/settings.json"       "$TARGET/settings.json"
link_if_exists "$SCRIPT_DIR/skills/git"          "$TARGET/skills/git"
link_if_exists "$SCRIPT_DIR/skills/jujutsu"      "$TARGET/skills/jujutsu"

if (( ${#trashed_filepath_list[@]} > 0 )); then
  echo
  for f in "${trashed_filepath_list[@]}"; do
    echo "WARNING: TRASHED OLD $f"
  done
fi
