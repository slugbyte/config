#!/usr/bin/env bash 

# install brew and tools

WORKSPACE=$HOME/workspace
mkdir -p $WORKSPACE/slug-bench
mkdir -p $WORKSPACE/node-bench
mkdir -p $WORKSPACE/rust-bench
mkdir -p $WORKSPACE/cf-bench

cd $HOME/workspace/slug-bench
git clone --recursive git@github.com:slugbyte/config.git 
cd config
source ./config/.bashrc
source ./plugin/dot.plugin.sh

dot sync 
