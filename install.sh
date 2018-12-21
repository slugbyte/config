#!/usr/bin/env bash 
[[ $(type dot) ]] || {
  WORKSPACE=$HOME/workspace
  mkdir -p $WORKSPACE/slug-bench
  mkdir -p $WORKSPACE/node-bench
  mkdir -p $WORKSPACE/rust-bench
  mkdir -p $WORKSPACE/cf-bench

  cd $HOME/workspace/slug-bench
  git clone --recursive git@github.com:slugbyte/config.git 
  cd config
  source ./config/.bashrc
  source ./plugin/dot.plugin.sh && dot sync 
  source ./install/base.sh

  select install_file in `ls ./install |grep -v base`; do 
    source ./install/$install_file
    break
  done
  echo DOT INSTALLED
}
