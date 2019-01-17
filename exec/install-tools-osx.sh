#!/usr/bin/env bash
# if no brew install brew 
[[ $(uname -s) = 'Darwin' ]] && {
  [[ $(which brew) ]] || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew install vim tmux htop pstree git httpie aria2 wget nvm fzf nmap reattach-to-user-namespace the_silver_searcher
}  || {
  echo 'ERROR: not darwin cannot install'
}
