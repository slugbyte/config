# Options
setopt no_clobber # let me overwrite files
setopt rm_star_silent # dont ask to delete
setopt chase_links # resolve symlinks
setopt extended_glob # better glob 
setopt glob_dots # glob include dotfiles

# better zsh completion
zstyle ':completion:*' menu select

# Environment Variabels
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'
export SHELL=$(which zsh)
export PAGER=$(which less)
export EDITOR=$(which nvim)
export GPG_TTY=$(tty)
export LC_ALL='en_US.UTF-8'
export ZDOTDIR="$HOME/.config/zsh"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_RUNTIME_DIR=$HOME/.runtime

# Mold Init
export MOLD_ROOT="$HOME/workspace"
export MOLD_SIGN='true'
export PATH="$MOLD_ROOT/exec:$MOLD_ROOT/exec/ignore:$PATH"
export w=$MOLD_ROOT
for plug in $MOLD_ROOT/plug/* ;do
  source $plug
done

# LOAD SECRETS
export SECRET_DIR="$MOLD_ROOT/hide"
if [[ -d $SECRET_DIR ]];then
	for  secret in $SECRET_DIR/env/*.sh; do 
	  source $secret
	done
fi

# Custom Error Exit Status
handle_error(){
  echo "FAILED: status code $?"
}

# TODO: STOP THE TRAP FROM FIRING ON PROMPT PRECMD find_git*
#trap handle_error ERR

# set the window titile for the terminal script
print -n "\e]2;__XOXO__:$PWD"

precmd(){
  print -n "\e]2;__XOXO__:$PWD"
}

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH=$(clean_path)
