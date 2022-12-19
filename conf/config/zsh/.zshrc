# Options
setopt no_clobber # let me overwrite files
setopt rm_star_silent # dont ask to delete
setopt chase_links # resolve symlinks
setopt extended_glob # better glob
setopt glob_dots # glob include dotfiles
zstyle ':completion:*' menu select # better zsh completion

# Environment Variabels
# ZSH
export ZDOTDIR="$HOME/.config/zsh"

# MOLD
export MOLD_ROOT="$HOME/workspace"
export w=$MOLD_ROOT
export PATH="$MOLD_ROOT/exec:$MOLD_ROOT/exec/ignore:$PATH"
export TRASH_DIR=$HOME/.local/share/Trash/files


# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_RUNTIME_DIR=$HOME/.runtime

# WHOAMI
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'

# GENERAL
export SHELL=$(which zsh)
export PAGER=$(which less)
export EDITOR=$(which nvim)
export LC_ALL='en_US.UTF-8'
export TERM='xterm-256color'

# LOAD SHELL PLUGIN
for plug in $MOLD_ROOT/plug/* ;do
  if ! [[ -d $secret ]]; then
    source $plug
  fi
done

# LOAD SECRETS
export SECRET_DIR="$MOLD_ROOT/hide"
for  secret in $SECRET_DIR/env/*.sh; do
  if ! [[ -d $secret ]]; then
    source $secret
  fi
done

# dedupe the path
if [[ -x "$(command -v clean_path)" ]];then
  export PATH=$(clean_path)
fi

alias xi="sudo apt-get install -y"
alias xs="sudo apt-cache search"
