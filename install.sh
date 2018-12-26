#!/usr/bin/env bash 

echo "INSTALLING DOT"
echo "INIT WORKSPACE"
WORKSPACE=$HOME/workspace
mkdir -p $WORKSPACE/slug-bench
mkdir -p $WORKSPACE/node-bench
mkdir -p $WORKSPACE/rust-bench
mkdir -p $WORKSPACE/cf-bench

echo "INSTALLING BASE"
source ./install/base.sh

echo "CHOOSE AN INSTALLER (n for none)"
select install_file in `ls ./install |grep -v base`; do 
  [[ -n $install_file ]] && source ./install/$install_file
  break
done
echo DOT INSTALLED


echo "ENSURE DOT REPO"
cd $HOME/workspace/slug-bench
[[ -d config ]] || git clone --recursive git@github.com:slugbyte/config.git 

echo "SOURCE DOT AND SYNC"
cd config
source ./config/.bashrc
source ./plugin/dot.plugin.sh && dot sync 

