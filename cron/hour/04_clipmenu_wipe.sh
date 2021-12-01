#!/usr/bin/env bash

clip_delete_count=$(cat $XDG_RUNTIME_DIR/clipmenu.6.slugbyte/line_cache |wc -l)

echo "DELETING $clip_delete_count clips from clipmenu"

rm $XDG_RUNTIME_DIR/clipmenu.6.slugbyte/*
