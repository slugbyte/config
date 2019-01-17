# shorthand for encrypting personal files and directories using gnupg

fuzz(){
  if [[ -z $1 ]]; then 
    >2& echo "ERROR: no target supplied" 
    return -1
  fi 
  if [[ -d $1 ]]; then 
    tar -czf $1.tar.gz $1 
    gpg -sea -r $EMAIL $1.tar.gz 
    rm -rf $1
    rm $1.tar.gz
    killall gpg-agent || echo ''
    return 0
  fi 
  gpg -sea -r $EMAIL $1 
  rm $1
  killall gpg-agent || echo ''
}

defuzz(){
  if [[ -z $1 ]]; then 
    >2& echo "ERROR: no target supplied" 
    return -1
  fi 
  output=${1/.asc/}
  gpg -o $output -d $1 && rm $1
  if [[ $output == *.tar.gz ]];then 
    tar -xzf $output
    rm $output
  fi 
  killall gpg-agent || echo ''
}
