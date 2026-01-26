alias xu="omarchy-update"
alias xi="omarchy-pkg-install"
alias xia="omarchy-pkg-aur-install"
alias xr="omarchy-pkg-remove"

# force safeutils
alias syscp=$(which cp)
alias sysmv=$(which mv)
alias sysrm=$(which rm)
alias mv="echo use move or sysmv"
alias cp="echo use copy or syscp"
alias rm="echo use trash or sysrm"

# ls/eza
alias ls="eza -F --group-directories-first"
alias ll="ls -la --git --no-user"
alias la="ls -a"
alias l1="ls -1a"
alias tree="ls --tree -L 2"
alias treee="ls --tree"

# general
alias j="e ."
alias n="z"
alias N="zi"
alias clip=wl-copy
alias md="mkdir -p"
alias math="calc -p"
alias open="xdg-open"
alias ..="cd .."
alias binmake="chmod a+x"
alias manfzf="man -k . | fzf --preview 'man {1}' | awk '{print $1}' | xargs man"

# zig development
alias b="zig build -freference-trace=10 --summary failures"
alias t="zig test -freference-trace=10"
