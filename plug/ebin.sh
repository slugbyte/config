ebin(){
  if ((  $# < 1 ));then  
    echo "USAGE ERROR: must provide at least one command name" && return 1
  fi

  command_path=$(which "$@")
  if [[ "$command_path" ]] && (( $? == 0 ));then
    vim $command_path
    return 
  fi

  echo "ERROR: no such command"
}
