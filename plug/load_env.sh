load_env(){
  local file
  if (( $# == 1 ));then
    file="$1"
  else
    file=".env"
  fi
  if [[ -f $file ]];then 
    export $(cat $file | xargs) 2> /dev/null
  fi
  echo "loaded $file"
}
