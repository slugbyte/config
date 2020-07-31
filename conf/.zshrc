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
export w=$HOME/workspace
export d=$HOME/workspace/DOWNLOAD

# Mold Init
export MOLD_ROOT="$HOME/.mold"
export MOLD_SIGN='true'
export PATH="$MOLD_ROOT/exec:$PATH"
for plug in $MOLD_ROOT/plug/* ;do
  source $plug
done

# LOAD SECRETS
export SECRET_DIR="$HOME/.secret"
for  secret in $SECRET_DIR/env/*.sh; do 
  source $secret
done

# Custom Error Exit Status
handle_error(){
  echo "FAILED: status code $?"
}

# TODO: STOP THE TRAP FROM FIRING ON PROMPT PRECMD find_git*
#trap handle_error ERR

