#!/usr/bin/env bash
# vim 
[[ -f $HOME/.vim/autoload/plug.vim ]] || {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  $(which vim) +PluginInstall +qall
}

# TPM 
[[ -d $HOME/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# rust
[[ $(which rustup) ]] || curl https://sh.rustup.rs -sSf | sh
