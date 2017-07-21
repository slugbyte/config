#!/usr/bin/env bash

# dot directory structure
# / 
# | - config/
#       files to copy to the home directory
# | - plugin/
#       files to be sourced by interactive bash 
# | - template/
#       project templates
# | - bin/
#       directory added to the begining of $PATH

dot_help(){
  echo -e 'DOT SUBROUTINES:
    help -- print dot help
    list -- list configs, scripts, or plugins
    copy -- copy a config, script, or plugins into dot
    edit -- edit configs, scripts, or plugins
    stat -- check dots git status
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


dot_stat(){
  pushd . 
  cd $DOT_ROOT
  git status
  popd
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
  popd
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

dot_proj_list(){
  echo "project templates"
  ls $DOT_ROOT/template |tr '/ ' ' \n' |sed 's/^/    /'
}

dot_proj_make(){
  if (( $# < 1 ));then 
    echo "USER ERROR: missing project name"
    return 
  else 
    pushd . 
    local project_name=$1
    local project_path=$DOT_ROOT/template/${project_name}
    mkdir -p $project_path
    cd $project_path
  fi 
}

dot_proj_copy(){
  if (( $# < 2 ));then 
    echo "USER ERROR: missing project name and destination"
    return 
  else 
    local project=$1
    local destination=$2
    local project_path=$DOT_ROOT/template/${project}
    if [[ -e $project_path ]];then 
      cp -r $project_path ${destination}
    else 
      echo "USER ERROR: project ($project) does not exist"
    fi 
  fi 
}


dot_proj_edit(){
  if (( $# < 1 ));then 
    echo "USER ERROR: missing project name"
    return 
  else 
    local project=$1
    local project_path=$DOT_ROOT/template/${project}
    if [[ -e $project_path ]];then 
      pushd . 
      cd $DOT_ROOT/template/${project}
    else 
      echo "USER ERROR: project (${project}) does not exist"
    fi 
  fi 
}

dot_proj_help(){
  echo 'DOT PROJ SUBROUTINES:
  help -- print dot proj help
  list -- list all exisoting projects
  make -- make a new project template
  copy -- copy an existing project directory
  edit -- edit an existing project directory'
}

dot_proj(){
  # help
  # make 
  # copy 
  # edit 
  local subroutine=$1
  case $subroutine in 
    'help')
      dot_proj_help
      ;;
    'list')
      dot_proj_list
      ;;
    'make')
      dot_proj_make $2
      ;;
    'copy')
      dot_proj_copy $2 $3
      ;;
    'edit')
      dot_proj_edit $2 
      ;;
    *)
      dot_proj_help
      ;;
  esac 
}

dot(){
  if [[ ! -n $DOT_ROOT ]];then 
    echo "ERROR: \$DOT_ROOT needs to be set"
    return 1 
  fi 
  if (( $# == 0 ));then 
    dot_help
    return 
  fi 
  local subroutine=${1}
  case $subroutine in
    'list')
      dot_list | less
      ;;
    'stat')
      dot_stat
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
    'proj')
      dot_proj $2 $3 $4
      ;;
    'help')
      dot_help
      ;;
    *)
      echo "USER ERROR: (${subroutine}) is not a subroutine"
      ;;
  esac
}

