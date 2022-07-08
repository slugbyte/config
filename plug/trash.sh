alias rm='echo oops you shoul use trash or wipe'
alias wipe='/usr/bin/rm'
trashfire(){
  rm -rf $HOME/.trash/*
}
