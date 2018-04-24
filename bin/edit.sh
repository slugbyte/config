#!/usr/bin/env bash
set -o pipefail

argv_length=${#@}
flag=${1:-}
export FZF_DEFAULT_COMMAND='ag -g ""'

get_file_path(){
  local file_path=$(fzf || echo '')
  local file_path_length=${#file_path}

  (( file_path_length > 0 )) && { 
    echo $file_path
    return 0
  }

  echo -n ''
}

(( argv_length > 0)) && {
  [[ $flag = '-f' ]] && {
    file_path=$(get_file_path)

    [[ $file_path != '' ]] && {
      $EDITOR "$file_path"
      exit 0 
    }

    echo 'byebye'
    exit 0
  }
  
  $EDITOR "$@"
  exit 0
}

$EDITOR 
exit 0

