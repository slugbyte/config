#!/usr/bin/env bash

if [[ -z "$MOLD_ROOT" ]];then
  echo "ERROR: \$MOLD_ROOT not set" 1>&2
  exit 1
fi

config_root="$MOLD_ROOT/conf/config/"
config_path_tree=$(find $config_root -name '*')

for path in $config_path_tree; do
  if [[ -d $path ]];then
    mkdir -p "$HOME/.config/${path#$config_root}" &> /dev/null
  else
    echo "linking: .config/${path#$config_root}"
    ln -f $path "$HOME/.config/${path#$config_root}"
  fi
done

home_root="$MOLD_ROOT/conf/home/"
home_path_tree=$(find $home_root -name '*')

for path in $home_path_tree; do
  if [[ -d $path ]];then
    mkdir -p "$HOME/${path#$home_root}" &> /dev/null
  else
    echo "linking: ~/${path#$home_root}"
    ln -f $path "$HOME/${path#$home_root}"
  fi
done
