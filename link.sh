  #!/usr/bin/env bash
  set -euo pipefail

  #############################################################################
  # VARS
  #############################################################################
  DRY_RUN=true
  [[ "${1:-}" == "--plz" ]] && DRY_RUN=false
  work="$HOME/workspace"
  conf="$work/conf"
  code="$work/code"
  temp="$HOME/Downloads"
  drop="$HOME/Dropbox"
  trash="$HOME/.local/share/Trash/files"

  trashed_filepath_list=()

  #############################################################################
  # FUNCTIONS
  #############################################################################
  # run a command if DRY_RUN is false, print the command if its true
  # $ run_safe cmd --arg1 --arg2 --arg3
  run_safe(){
    if $DRY_RUN;then
      echo "[MOCK]" "$@"
    else
      # silent in non mock mode
      "$@" >/dev/null 2>&1
    fi
  }

  # trash a file if it exists and is not a symlink
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
  

  # if $src exists force link to $dest, if $dest is exists trash it before linking
  # $ link_if_exists $src $dest
  link_if_exists(){
    if [[ -e "$1" ]];then
      trash_existing "$2"
      run_safe ln -sf "$1" "$2"
      echo "[LINK] ${1/#$conf/\$conf} -> ${2/#$HOME/\~}"
    fi
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
  mkdir -p "$code" 
  mkdir -p "$trash"
  mkdir -p ~/.local/bin

  link_config "$work/conf/config" "$HOME/.config"
  link_config "$work/conf/home" "$HOME"

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
