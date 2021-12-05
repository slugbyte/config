#!/usr/bin/env bash
get_file_list(){
  find $HOME/workspace/play/ ! -name README.md ! -name .gitignore ! -name play -mmin +60 
}

count=$(get_file_list | wc -l)
if (( count > 0 ));then
  echo "lighting the playground fire... torched $count pieces of garbage"
  get_file_list | xargs -I {} rm -rf {}
else
  echo "all these matches and no playground garbage to burn"
fi


