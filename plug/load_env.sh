load_env(){
  if [[ -f .env ]];then 
    export $(cat .env | xargs)
  fi
}
