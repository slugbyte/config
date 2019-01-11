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
    list -- list configs, scripts, installers, or plugins
    load -- copy a config, script, or plugins into dot
    edit -- edit configs, scripts, installers, or plugins
    temp -- manage scaffolding templates
    stat -- git status dot
    push -- git commit and push 
    pull -- git pull and dot sync
    diff -- git diff 
    sync -- hardlink configs from $DOT_ROOT into $HOME'
}

dot_list(){
  echo "config"
  for config in $DOT_ROOT/config/{*,.*};do
    if [[ -f $config ]]; then 
      echo "    $(basename $config)"
    fi 
  done 

  echo "install"
  for config in $DOT_ROOT/install/{*,.*};do
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

dot_load(){
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

dot_edit(){
  local type=$1
  local filename=$2
  [[ $type = 'plugin' ]] && filename=${filename}.plugin.sh
  local filepath=$DOT_ROOT/$type/$filename
  if [[ -n $type ]] && [[ -n $filename ]];then 
    if [[ -e $filepath ]];then 
      $EDITOR $filepath
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


dot_sync(){
  local config
  for config in $DOT_ROOT/config/{*,.*};do
    if [[ -f $config ]]; then 
      ln -f $config $HOME/$(basename $config)
    fi 
  done
  . ~/.bashrc
  echo "sync complete"
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
  git pull origin master && dot_sync
  popd
}

dot_diff(){
  pushd . 
  cd $DOT_ROOT
  git diff
  popd
}

dot_temp_list(){
  echo "project templates"
  ls $DOT_ROOT/template |tr '/ ' ' \n' |sed 's/^/    /'
}

dot_temp_make(){
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

dot_temp_load(){
  if (( $# < 2 ));then 
    echo "USER ERROR: missing from_path and project_name "
    return 
  else 
    [[ -d $DOT_ROOT/template/$2 ]] && rm -rf "$DOT_ROOT/template/$2" 
    cp -rf "$1" "$DOT_ROOT/template/$2"
    echo "LOADED $2"
  fi 
}

dot_temp_copy(){
  if (( $# < 2 ));then 
    echo "USER ERROR: missing project name and destination"
    return 
  else 
    local project=$1
    local destination=$2
    local project_path=$DOT_ROOT/template/${project}
    if [[ -e $project_path ]];then 
      cp -R $project_path ${destination}
    else 
      echo "USER ERROR: project ($project) does not exist"
    fi 
  fi 
}


dot_temp_edit(){
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

dot_temp_help(){
  echo 'DOT PROJ SUBROUTINES:
  help -- print dot proj help
  list -- list all exisoting projects
  make -- make a new project template
  load -- copy an existing directory as a new template
  copy -- copy an existing project directory
  edit -- edit an existing project directory'
}

dot_temp(){
  # help
  # make 
  # copy 
  # edit 
  local subroutine=$1
  case $subroutine in 
    'help')
      dot_temp_help
      ;;
    'list')
      dot_temp_list
      ;;
    'make')
      dot_temp_make $2
      ;;
    'load')
      dot_temp_load $2 $3
      ;;
    'copy')
      dot_temp_copy $2 $3
      ;;
    'edit')
      dot_temp_edit $2 
      ;;
    *)
      dot_temp_help
      ;;
  esac 
}

dot_one(){
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
    'diff')
      dot_diff
      ;;
    'load')
      dot_load $2 $3
      ;;
    'edit')
      dot_edit $2 $3
      ;;
    'temp')
      dot_temp $2 $3 $4
      ;;
    'help')
      dot_help
      ;;
    *)
      echo "USER ERROR: (${subroutine}) is not a subroutine"
      ;;
  esac
}


#_dot(){

  #candidates=(help list load edit temp stat push pull diff sync)
  #if [[ $COMP_LINE =~ "dot edit"  ]];then 
    #candidates=(plugin config )
  #elif [[ $COMP_LINE =~ "dot temp edit"  ]];then 
    #candidates=($(compgen -W "$(dot temp list | tail -n +2)"))
  #elif [[ $COMP_LINE =~ "dot temp copy"  ]];then 
    #candidates=($(compgen -W "$(dot temp list | tail -n +2)"))
  #elif [[ $COMP_LINE =~ "dot temp load"  ]];then 
    #candidates=($(compgen -f ))
  #elif [[ $COMP_LINE =~ "dot temp"  ]];then 
    #candidates=(help list make load copy edit)
  #fi 

    #COMPREPLY=()
      #for candidate in ${candidates[@]}; do
          #if [[ "$candidate" == "$2"* ]]; then
              #COMPREPLY+=("$candidate")
          #fi
      #done 
#}

#complete -F _dot dot
