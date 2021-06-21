# shorthand for encrypting personal files and directories using gnupg

_fuzz(){
  if [[ -z $1 ]]; then 
    echo "ERROR: no target supplied" 2>&1 1>/dev/null
    return -1
  fi 
  if [[ -d $1 ]]; then 
    tar -czf $1.tar.gz $1 
    gpg2 -sea -r $EMAIL $1.tar.gz 
    rm -rf $1
    rm $1.tar.gz
    return 0
  fi 
  gpg2 -sea -r $EMAIL $1 
  rm $1
}

_defuzz(){
  if [[ -z $1 ]]; then 
    #>2& echo "ERROR: no target supplied" 
    echo "ERROR: no target supplied" 2>&1 1>/dev/null
    return -1
  fi 
  output=${1/.asc/}
  gpg2 -o $output -d $1 && rm $1
  if [[ $output == *.tar.gz ]];then 
    tar -xzf $output
    rm $output
  fi 
}

fuzz(){
  for file in $@;do 
    if [[ -f $file ]];then 
      _fuzz $file
    else 
      echo "SORRY $file is not a file"
    fi
  done
}

defuzz(){
  for file in $@;do 
    if [[ -f $file ]];then 
      _defuzz $file
    else 
      echo "SORRY $file is not a file"
    fi
  done
}
