#!/usr/bin/env bash

export DATE=$(date +"%Y_%m_%d-%H_%M")
LOG_DIR="${HOME}/workspace/tail/cron_tail/${1}"
mkdir -p $LOG_DIR

LOG_FILE="${LOG_DIR}/cron_${1}.${DATE}.txt"

for program in $HOME/workspace/cron/$1/*;do
  echo | tee -a "$LOG_FILE"
  echo "EXEC: $program" | tee -a "$LOG_FILE"
  $program |tee -a "$LOG_FILE"
done
