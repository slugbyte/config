#!/usr/bin/env bash
set -o pipefail

argv_length=${#@}
flag=${1:-}

get_file_path(){
  local file_path
  local file_path_length
  file_path=$(fzf || echo '')
  file_path_length=${#file_path}

  (( file_path_length > 0 )) && { 
    echo "$file_path"
    return 0
  }

  echo -n ''
}

(( argv_length > 0)) && {
  # fzf and open selected file file
  [[ $flag = '-f' ]] && {
    file_path=$(get_file_path)

    [[ $file_path != '' ]] && {
      $EDITOR "$file_path"
      exit 0 
    }

    echo 'byebye'
    exit 0
  }

  # create an executable
  [[ $flag = '-x' ]] && {
    file_path=$2
    touch "$file_path"
    chmod 755 "$file_path"
    $EDITOR "$file_path"

    echo 'byebye'
    exit 0
  }

  # edit an executable script on $PATH
  [[ $flag = '-w' ]] && {
    file_path=$2
    "$EDITOR" "$(which "$file_path")"

    echo 'byebye'
    exit 0
  }

  $EDITOR "$@"
  exit 0
}

$EDITOR
exit 0

