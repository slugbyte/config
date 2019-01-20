# General Utilitys

# Safely Delete Something
trash(){
  mkdir -p $HOME/.Trash
  mv $1 $HOME/.Trash/
}

# Log Local and Public Ip
ip_address(){
  echo -n 'local:  '
  ifconfig en0 inet | tail -n 1 | cut -d ' ' -f 2
  echo -n 'public: '
  curl ipinfo.io/ip
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

# Source a file in a script(s) directory
# TODO check check dir and script exists and only log ok if actually OK
load(){
  source script/${1}.sh
  echo ${color_magenta}loaded${color_reset} ${1}
}

# FzF and Open To Line in Vim 
fzf_vim(){
  local result=$( ag "$1" | fzf ) 
  local path=$( echo "$result" | cut -d ':' -f 1 )
  local linenum=$( echo "$result" | cut -d ':' -f 2 )
  [[ ! $path ]] && {
    echo "no match found"
    return 1
  }
  $EDITOR "+${linenum}" "$path"
}

# Create A Plain Text Executable
new_script(){
  touch $@
  chmod 755 $@
}

# Safly delete a file
trash(){
  (( $# > 0 )) || {
    echo 'USAGE ERROR: no files provided'
    return 1
  }
  mkdir -p $HOME/.Trash
  mv $@ $HOME/.Trash/
}

# Empty Trash
empty_trash(){
  rm -rf $HOME/.Trash/*
}

# Empty Downloads
empty_download(){
  rm -rf $HOME/Downloads/*
}

# Open An Execuable By Name Using $EDITOR
bin_edit(){
  if ((  $# < 1 ));then  
    echo "USAGE ERROR: must provide at least one command name" && return 1
  fi

  command_path=$(which "$@")
  if [[ "$command_path" ]] && (( $? == 0 ));then
     $EDITOR $command_path
    return 
  fi

  echo "ERROR: no such command"
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