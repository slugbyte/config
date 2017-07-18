#!/usr/bin/env bash

# dot directory structure
# / 
# | - config/
#       files to copy to the home directory
# | - plugin/
#       files to be sourced by interactive bash 
# | - bin/
#       directory added to the begining of $PATH

dot_help(){
  echo -e 'DOT SUBROUTINES:
    help -- print dot help
    list -- list configs, scripts, or plugins
    copy -- copy a config, script, or plugins into dot
    edit -- edit configs, scripts, or plugins
    push -- upload changes
    pull -- download changes
    sync -- install changes'
}

dot_list(){
  echo "config"
  for config in $DOT_ROOT/config/{*,.*};do
    if [[ -f $config ]]; then 
      echo "    $(basename $config)"
    fi 
  done 

  echo "plugin"
  for config in $DOT_ROOT/plugin/{*,.*};do
    if [[ -f $config ]]; then 
      local filename=$(basename $config)
      echo "    ${filename/.plugin.sh}"
    fi 
  done 

  echo "bin"
  for config in $DOT_ROOT/bin/{*,.*};do
    if [[ -f $config ]]; then 
      local filename=$(basename $config)
      echo "    ${filename}"
    fi 
  done 
}

dot_edit(){
  local type=$1
  local filename=$2
  [[ $type = 'plugin' ]] && filename=${filename}.plugin.sh
  local filepath=$DOT_ROOT/$type/$filename
  if [[ -n $type ]] && [[ -n $filename ]];then 
    if [[ -e $filepath ]];then 
      $EDITOR $filepath
      if [[ $type = 'config' ]];then 
        cp $filepath $HOME/$filename
      fi 
    else 
      echo no such $type $filename
    fi
  else 
    echo "USER ERROR: must supply type and filename"
  fi 
}

dot_copy(){
  local type=$1
  local filepath=$2
  if [[ -n $type ]] && [[ -n $filepath ]];then 
    if [[ -e $filepath ]];then 
      cp -f $filepath $DOT_ROOT/$type/$(basename $filepath)
      if [[ $type = 'config' ]];then 
        cp $filepath $HOME/$(basename $filepath)
      fi 
    else 
      echo no such $type $filename
    fi
  else 
    echo "USER ERROR: must supply type and filepath"
  fi 
}

dot_push(){
  pushd . 
  cd $DOT_ROOT
  git add . 
  git commit 
  git push origin master
  popd 
}

dot_pull(){
  pushd . 
  cd $DOT_ROOT
  git pull origin master
}

dot_sync(){
  local config
  for config in $DOT_ROOT/config/{*,.*};do
    if [[ -f $config ]]; then 
      cp -f $config ~/
    fi 
  done
  . ~/.bashrc
  echo "sync complete"
}

dot(){
  if [[ ! -n $DOT_ROOT ]];then 
    echo "ERROR: \$DOT_ROOT needs to be set"
    return 1 
  fi 
  local subroutine=${1}
  case $subroutine in
    'list')
      dot_list
      ;;
    'sync')
      dot_sync
      ;;
    'pull')
      dot_pull
      ;;
    'push')
      dot_push
      ;;
    'copy')
      dot_copy $2 $3
      ;;
    'edit')
      dot_edit $2 $3
      ;;
    'help')
      dot_help
      ;;
    *)
      echo "USER ERROR"
      dot_help
      ;;
  esac
}

