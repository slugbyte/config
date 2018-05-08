# shorthand for encrypting personal files and directories using gnupg

fuzz(){
  if [[ -d $1 ]]; then 
    tar -czf $1.tar.gz $1 
    gpg -ea -r 'slugbyte@slugbyte.com' $1.tar.gz 
    rm -rf $1
    rm $1.tar.gz
    killall gpg-agent || echo ''
    return 0
  fi 
  gpg -ea -r 'slugbyte@slugbyte.com' $1 
  rm $1
  killall gpg-agent || echo ''
}

defuzz(){
  output=${1/.asc/}
  gpg -o $output -d $1 
  if [[ $output == *.tar.gz ]];then 
    tar -xzf $output
    rm $output
  fi 
  killall gpg-agent || echo ''
}
