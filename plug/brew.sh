BREW_LIST=$MOLD_ROOT/conf/.brew-list

brew_list_save(){
  brew list > $BREW_LIST 
  brew list > ~/.brew-install
  mold conf drop .brew-list  
  mold conf load ~/.brew-list
}

search(){
  brew search $@
}

install(){
  brew install $@ && {
    brew_list_save
  }
}

uninstall(){
  brew uninstall $@ && {
    brew_list_save
  }
}

install_all(){
  brew install $(cat $BREW_LIST)
}

