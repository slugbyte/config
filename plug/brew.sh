search(){
  brew search $@
}

install(){
  brew install $@ && {
    brew list > ~/.brew-install
    mold conf drop .brew-list
    mold conf load ~/.brew-list
  }
}

uninstall(){
  brew uninstall $@ && {
    brew list > ~/.brew-install
    mold conf drop .brew-list
    mold conf load ~/.brew-list
  }
}

install_all(){
  brew install $(cat $MOLD_ROOT/conf/.brew-list)
}
