# mold/config
export MOLD_ROOT="$HOME/workspace"
export PATH="$MOLD_ROOT/exec:$MOLD_ROOT/exec/ignore:$PATH"
export w=$MOLD_ROOT

# fake slash
export SLASH="$w/root"
export s="$SLASH"
export PATH="$SLASH/bin:$PATH"

# trash
export TRASH_DIR=$HOME/.local/share/Trash/files
export t="$TRASH_DIR"

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
