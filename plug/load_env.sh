load_env(){
  local file
  if (( $# == 1 ));then
    file="$1"
  else
    file=".env"
  fi
  if [[ -f $file ]];then
    echo "loading: $file"
    for line in $(cat $file | rg -v '^#.*' ); do
      echo $line
      export $line 2> /dev/null
    done
  else
    echo "file not found: $file"
  fi
}
