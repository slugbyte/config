# TODO convert to zsh

#compdef _mold mold

 _mold(){ 
   local state 
  _arguments  $(mold --complete $line )  

  #if [[ $MOLD_COMPLETE == '__MAGIC_MOLD__' ]]; then 

    ## "__MAGIC_MOLD__" turns on file path competion
    #for canidate in $(compgen -f $2); do 
      #if [[ "$canidate" == "$2"* ]];then
        #COMPREPLY+=("$canidate")
        #compadd "$canidate"
      #fi 
    #done
  #else 
    #for canidate in $MOLD_COMPLETE; do 
      #if [[ "$canidate" == "$2"* ]];then
        #COMPREPLY+=("$canidate")
      #fi 
    #done
  #fi
}

#complete -F _mold mold
