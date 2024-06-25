#!/usr/bin/env bash

WORKSPACE_DIR="$HOME/workspace"
TEMP_DIR="$HOME/Downloads/"
TRASH_DIR="$HOME/.Trash"
CONF_DIR="$WORKSPACE_DIR/conf"
ARG="$1"

mkdir -p "$WORKSPACE_DIR/code" 
mkdir -p "$WORKSPACE_DIR/exec"
# mkdir -p "$WORKSPACE_DIR/data"
# mkdir -p "$WORKSPACE_DIR/gang"
mkdir -p "$WORKSPACE_DIR/hist"
mkdir -p "$WORKSPACE_DIR/lang"
mkdir -p "$WORKSPACE_DIR/play"
mkdir -p "$WORKSPACE_DIR/play"
mkdir -p "$WORKSPACE_DIR/work"
ln -sf "$TEMP_DIR" "$WORKSPACE_DIR/temp"

if [[ ! -d "$CONF_DIR" ]];then
  git clone git@github.com:slugbyte/config.git "$WORKSPACE_DIR/conf"
fi

echo "[BLOINGO]"
echo "   WORKSPACE_DIR=$WORKSPACE_DIR"
echo "   TEMP_DIR=$TEMP_DIR"
echo "   TRASH_DIR=$TRASH_DIR"

if [[ ! -d "$TRASH_DIR" ]];then
  echo "ABORT: TRASH_DIR DOES NOT EXIST"
  echo "   $TRASH_DIR"
  exit 1
fi

exec_if_plz(){
  # place exec_if_plz before line to exec_if_plz it
  # example ```$ exec_if_plz mv $1  $TRASH_DEST_PATH```
  if [[ "$ARG" = "--plz" ]];then
    "$@"
  else
    echo "    [MOCK]" "$@"
  fi
}

backup_if_exist(){
  if [[ -e "$1" ]]; then
    TRASH_DATE=$(date "+%Y%m%d%H%M%S")
    TRASH_SOURCE_NAME=$(basename "$1")
    TRASH_DEST_PATH="$TRASH_DIR/config-backup_if_exist-$TRASH_DATE.$TRASH_SOURCE_NAME"
    exec_if_plz mv "$1"  "$TRASH_DEST_PATH"
    echo "    [BACKUP] $1 -> $TRASH_DEST_PATH"
  fi
}

link_config(){
  SOURCE_DIR="$1"
  SOURCE_FILE_LIST=$(ls -a "$SOURCE_DIR" | grep -v "^\.*$" | grep -v .DS_Store)
  DEST_DIR="$2"
  echo
  echo "[SOURCE_DIR] $SOURCE_DIR"
  for SOURCE_FILE in $SOURCE_FILE_LIST; do
    LINK_SOURCE="$SOURCE_DIR/$SOURCE_FILE"
    LINK_TARGET="$DEST_DIR/$SOURCE_FILE"
    echo "  $SOURCE_FILE: $LINK_SOURCE"
    backup_if_exist "$LINK_TARGET"
    if [[ -d "$LINK_SOURCE" ]];then 
      exec_if_plz ln -sf "$LINK_SOURCE" "$LINK_TARGET"
      echo "    [SOFT_LINK] $LINK_TARGET -> $LINK_SOURCE"
    else
      exec_if_plz ln -f "$LINK_SOURCE" "$LINK_TARGET"
      echo "    [HARD_LINK] $LINK_TARGET -> $LINK_SOURCE"
    fi
  done
}

link_config "$WORKSPACE_DIR/conf/config" "$HOME/.config"
link_config "$WORKSPACE_DIR/conf/home" "$HOME"

if [[ $ARG = "--plz" ]];then
  echo
  echo "[GLORB]"
  echo "    $RANDOM is a lucky number, don't $(whoami) think?"
  echo "    GLORB work is complete."
else
  echo
  echo "[GLORB]"
  echo "   GLORB will do NO work without magic words."
  echo "   Now wait $(whoami) run | $ link.sh --plz | , ok?"
fi
