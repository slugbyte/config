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
    make -- create a config, script, or plugin
    copy -- copy a config, script, or plugins into dot
    list -- list configs, scripts, or plugins
    edit -- edit configs, scripts, or plugins
    drop -- remove a config, script, or plugin
    push -- upload changes
    pull -- download changes
    load -- install changes'
}

dot_edit(){
  local type=$1
  local filename=$2
  local filepath=$DOT_ROOT/$type/$filename
  if [[ -n $type ]] && [[ -n $filename ]];then 
    if [[ -e $filepath ]];then 
      $EDITOR $filepath
      if [[ type = 'config' ]];then 
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

dot(){
  if [[ ! -n $DOT_ROOT ]];then 
    echo "ERROR: \$DOT_ROOT needs to be set"
    return 1 
  fi 
  local subroutine=${1}
  case $subroutine in
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

