trash(){
  (( $# > 0 )) || {
    echo 'USAGE ERROR: no files provided'
    return 1
  }
  mkdir -p $HOME/.Trash
  mv $@ $HOME/.Trash/
}

_trash_clean(){
  rm -rf $HOME/.Trash/*
}

_download_clean(){
  rm -rf $HOME/Downloads/*
}

_clean(){
  _trash_clean
  _download_clean
}
