# General Utilitys
pwdcopy(){
  pwd | tr -d '\n' | copy
}

# Log Local and Public Ip
ip_address(){
  echo -n 'local:  '
  ifconfig en0 inet | tail -n 1 | cut -d ' ' -f 2
  echo -n 'public: '
  curl ipinfo.io/ip
}

look() {
  find . -iname "$@"
}

# Add Color to Man Pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}


# Run File and Stat on an Executable by Name
bin_info(){
  if ((  $# < 1 ));then  
    echo "USAGE ERROR: must provide at least one command name" && return 1
  fi
  command_path=$(which "$@")
  if [[ "$command_path" ]] && (( $? == 0 ));then
    file -b $command_path
    stat -x  $command_path
    return 
  fi
  echo "ERROR: no such command"
}
