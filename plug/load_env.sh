load_env(){
  local file
  if (( $# == 1 ));then
    file="$1"
  else
    file=".env"
  fi
  if [[ -f $file ]];then
    echo "loading: $file"
    export $(cat $file | xargs) 2> /dev/null
  else
    echo "file not found: $file"
  fi
}
