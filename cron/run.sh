#!/usr/bin/env bash

for program in $HOME/cron/$1/*;do
  $program |tee -a $HOME/workspace/tail/cron_$1.log.txt
done
