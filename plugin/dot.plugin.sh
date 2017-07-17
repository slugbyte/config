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
    list -- list configs, scripts, or plugins
    edit -- edit configs, scripts, or plugins
    drop -- remove a config, script, or plugin
    push -- upload changes
    pull -- download changes
    load -- install changes'
}


dot(){
  local subroutine=${1}
  case $subroutine in
    'help')
      dot_help
      ;;
    *)
      echo "USER ERROR"
      dot_help
      ;;
  esac
}

