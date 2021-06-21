#!/usr/bin/env bash
get_file_list(){
  find $HOME/.trash/ -maxdepth 1 -mtime 20
}

count=$(get_file_list | wc -l)
if (( count > 0 ));then
  echo "lighting the trash fire... torched $count pieces of garbage"
  get_file_list | xargs -I {} rm -rf {}
else
  echo "all these matches and no trash to burn"
fi


