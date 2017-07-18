#!/usr/bin/env bash 

git clone git@github.com:slugbyte/config.git ~/workspace/config
cd ~/workspace

source ./config/.bashrc
source ./plugin/dot.plugin.sh

dot sync 
