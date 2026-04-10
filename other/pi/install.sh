#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.pi/agent"
CONF_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$SCRIPT_DIR/../../util/lib.sh" "$@"

run_safe mkdir -p "$TARGET"

link_if_exists "$CONF_ROOT/config/opencode/AGENTS.md" "$TARGET/AGENTS.md"
link_if_exists "$SCRIPT_DIR/settings.json" "$TARGET/settings.json"
link_if_exists "$SCRIPT_DIR/extensions" "$TARGET/extensions"
link_if_exists "$SCRIPT_DIR/skills" "$TARGET/skills"
link_if_exists "$SCRIPT_DIR/themes" "$TARGET/themes"

if (( ${#trashed_filepath_list[@]} > 0 )); then
  echo
  for f in "${trashed_filepath_list[@]}"; do
    echo "WARNING: TRASHED OLD $f"
  done
fi
