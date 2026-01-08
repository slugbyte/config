# SET ENVIRONMENT
# RETURN IF NOT INTERACTIVE
export SHELL=$(which bash)
[[ $- != *i* ]] && return

# LOAD OMARCHY
source ~/.local/share/omarchy/default/bash/rc

# LOAD PERSONAL
source ~/.config/bash/theme.sh
source ~/.config/bash/env.sh
prepend_path() {
    case ":$PATH:" in
        *:"$1":*) ;;  # already in PATH, do nothing
        *) PATH="$1${PATH:+:$PATH}" ;;
    esac
}
prepend_path "$HOME/.local/bin"
prepend_path "$HOME/workspace/exec/bin"
prepend_path "$HOME/workspace/conf/bin"
export PATH

# SET ALIASES
unalias -a # remove all aliases
alias e="hx"
alias j="hx ."
alias n="z"
alias N="zi"
alias md="mkdir -p"
alias R="source ~/.bashrc"
alias ls="eza -F --group-directories-first"
alias la="ls -a"
alias ll="ls -la --git --no-time"
alias tree="ls --tree -L 2"
alias tree="ls --tree"
alias open="xdg-open"
alias clip=wl-copy

alias xu="omarchy-update"
alias xi="omarchy-pkg-install"
alias xr="omarchy-pkg-remove"



