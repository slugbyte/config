#!/usr/bin/env bash

export DATE=$(date +"%Y_%m_%d-%H_%M")
LOG_DIR="${HOME}/workspace/tail/cron_tail/${1}"
mkdir -p $LOG_DIR

for program in $HOME/workspace/cron/$1/*;do
  $program |tee -a "${LOG_DIR}/cron_${1}.${DATE}.txt"
done
