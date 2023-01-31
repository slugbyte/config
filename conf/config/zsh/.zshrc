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

source $HOME/.global_env.sh

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
