ebin(){
  if ((  $# < 1 ));then  
    echo "USAGE ERROR: must provide at least one command name" && exit 1
  fi

  command_path=$(which "$@")
  if [[ "$command_path" ]] && (( $? == 0 ));then
    vim $command_path
    exit
  fi

  echo "ERROR: no such command"
}
