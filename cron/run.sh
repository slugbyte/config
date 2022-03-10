#!/usr/bin/env bash
export MOLD_ROOT=$HOME/workspace

for program in $HOME/workspace/cron/$1/*;do
  $program |tee -a $HOME/workspace/tail/cron_$1.log.txt
done
