tt(){
  if [[ -e Cargo.toml ]];then 
    cargo test $@
    return 0
  fi

  if [ -e package.json ];then 
    npm run test $@
    return 0
  fi

  echo ERROR: no project config file found
  return 1
}
