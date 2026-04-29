  #!/usr/bin/env bash
  set -euo pipefail

  #############################################################################
  # VARS
  #############################################################################
  work="$HOME/workspace"
  conf="$work/conf"
  code="$work/code"
  temp="$HOME/Downloads"
  drop="$HOME/Dropbox"

  # shared helpers: DRY_RUN, run_safe, trash_existing, link_if_exists
  source "$conf/util/lib.sh" "$@"

  #############################################################################
  # FUNCTIONS
  #############################################################################
  # Override link_if_exists to use $conf-relative display paths.
  link_if_exists(){
    if [[ -e "$1" ]];then
      trash_existing "$2"
      run_safe ln -sf "$1" "$2"
      echo "[LINK] ${1/#$conf/\$conf} -> ${2/#$HOME/\~}"
    else
      echo "[MISSING] source not found: ${1/#$conf/\$conf}" >&2
    fi
  }

  # Prune top-level (depth 1) symlinks under $1 that point into $conf but no
  # longer resolve. Scope is intentionally narrow: this only cleans up the
  # blanket links created by link_config. Deeper installer-managed symlinks
  # (e.g. ~/.claude/CLAUDE.md) are reset by their own install.sh on each run.
  prune_dangling_links(){
    local search_dir="$1"
    while IFS= read -r -d '' link; do
      local target
      target="$(readlink "$link")"
      [[ "$target" == "$conf"/* ]] || continue
      [[ -e "$link" ]] && continue
      dangling_filepath_list+=("$link -> $target")
      if $DRY_RUN; then
        echo "[DANGLING] ${link/#$HOME/\~} -> ${target/#$conf/\$conf}"
      else
        run_safe rm "$link"
        echo "[PRUNED]   ${link/#$HOME/\~} -> ${target/#$conf/\$conf}"
      fi
    done < <(find "$search_dir" -maxdepth 1 -type l -print0 2>/dev/null)
  }

  # link all the config files in a $conf subdirectory
  # $link_config $conf/config ~/.config
  # $link_config $conf/home ~/
  link_config(){
    local src_dir="$1"
    local dest_dir="$2"
    echo
    echo "[SOURCE_DIR] ${src_dir/#$conf/\$conf}"
    for src_path in "$src_dir"/* "$src_dir"/.[!.]*; do
      [[ -e "$src_path" ]] || continue # skip if not exists
      local dest_path="$dest_dir/$(basename "$src_path")"
      link_if_exists "$src_path" "$dest_path"
    done
  }
  #############################################################################
  # PROGRAM
  #############################################################################
   
  # guard that $conf exists
  if [[ ! -d "$conf" ]];then
    echo "[ERROR] expected conf to be installed in: $conf"
    exit 1
  fi

  # guard that dropbox exists
  if [[ ! -d "$drop" ]];then
    echo "[ERROR] Dropbox must be setup first"
    exit 1
  fi

  echo "[BLOINGO] lets begin!"

  # flush out $work to have all expected links and dirs
  run_safe mkdir -p "$code"
  run_safe mkdir -p "$trash"
  run_safe mkdir -p ~/.local/bin

  link_config "$conf/config" "$HOME/.config"
  link_config "$conf/home" "$HOME"

  prune_dangling_links "$HOME/.config"
  prune_dangling_links "$HOME"

  # run install scripts for other configs
  for install_script in "$conf/other"/*/install.sh; do
    [[ -x "$install_script" ]] || continue
    echo
    echo "[INSTALL] ${install_script/#$conf/\$conf}"
    bash "$install_script" "$@"
  done

  if $DRY_RUN;then
    echo
    echo "[GLORB]"
    echo "   GLORB will do NO work without magic words."
    echo "   Now wait $(whoami) run | $ link.sh --plz | , ok?"
  else
    echo
    echo "[GLORB]"
    echo "    $RANDOM is a lucky number, don't $(whoami) think?"
    echo "    GLORB work is complete."
  fi

# at the end of the script
if (( ${#trashed_filepath_list[@]} > 0 )); then
  echo
  for f in "${trashed_filepath_list[@]}"; do
    echo "WARNING: TRASHED OLD $f"
  done
fi

if (( ${#dangling_filepath_list[@]} > 0 )); then
  echo
  for f in "${dangling_filepath_list[@]}"; do
    echo "WARNING: DANGLING SYMLINK $f"
  done
fi
