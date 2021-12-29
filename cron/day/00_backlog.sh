#!/usr/bin/env bash

SELF_LOG_FILE=$MOLD_ROOT/tail/backlog.log

DATE=$(date +%Y_%m_%d-%H-%M)

TEMP_DIR=$(mktemp -d)

DATE_DIR="$TEMP_DIR/$DATE"

TAR_FILENAME="$DATE.tar.gz"

mkdir -p $DATE_DIR

find $MOLD_ROOT/tail/ -name '*.log*' | xargs -I {} mv {} $DATE_DIR/

cd $TEMP_DIR

echo BACKLOG DATA: | tee -a $SELF_LOG_FILE
tree . | tee -a $SELF_LOG_FILE

tar -czf $TAR_FILENAME ./$DATE

mkdir -p $MOLD_ROOT/tail/backlog
mv $TEMP_DIR/$TAR_FILENAME $MOLD_ROOT/tail/backlog/

rm -rf $TEMP_DIR

echo CREATED BACKLOG $DATE.tar.gz | tee -a $SELF_LOG_FILE
