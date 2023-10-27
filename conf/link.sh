#!/usr/bin/env bash

WORKSPACE_DIR="$HOME/workspace"
TRASH_DIR="$HOME/.trash"

trash(){
  mv $1 $TRASH_DIR/
}

config_root="$WORKSPACE_DIR/conf/config/"
config_path_tree=$(ls "$config_root")

for path in $config_path_tree; do
  echo "linking: .config/${path#"$config_root"}"
  trash "$HOME/.config/${path#"$config_root"}"
  ln -sf "${config_root}${path}" "$HOME/.config/${path#"$config_root"}"
done

HOME_ROOT="$WORKSPACE_DIR/conf/home/"
HOME_DOTFILE_LIST=$(find "$HOME_ROOT" -name '*')

for path in $HOME_DOTFILE_LIST; do
  if [[ -d $path ]];then
    mkdir -p "$HOME/${path#"$HOME_ROOT"}" &> /dev/null
  else
    echo "linking: ~/${path#"$HOME_ROOT"}"
    ln -f "$path" "$HOME/${path#"$HOME_ROOT"}"
  fi
done
