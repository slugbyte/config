trash(){
  (( $# > 0 )) || {
    echo 'USAGE ERROR: no files provided'
    return 1
  }
  mkdir -p $HOME/.Trash
  mv $@ $HOME/.Trash/
}

alias rimraf='rm -rf'

_clean_trash(){
  rm -rf $HOME/.Trash/*
}

_clean_download(){
  rm -rf $HOME/Downloads/*
}

_clean_swap(){
  rm -rf $HOME/.local/share/nvim/swap
}

_clean(){
  _clean_swap
  _clean_trash
  _clean_download
}
