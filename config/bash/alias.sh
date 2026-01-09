alias xu="omarchy-update"
alias xi="omarchy-pkg-install"
alias xr="omarchy-pkg-remove"

# force safeutils
alias mv "echo use move or sysmv"
alias cp "echo use copy or syscp"
alias rm "echo use trash or sysrm"
alias syscp=(which cp)
alias sysmv=(which mv)
alias sysrm=(which rm)

# ls/exa
alias ls="eza -F --group-directories-first"
alias ll="ls -la --git --no-user"
alias la="ls -a"
alias l1="ls -1a"

alias ..="cd .."
alias b="zig build -freference-trace=10 --summary failures"
alias t="zig test -freference-trace=10"
alias clip=wl-copy
alias e="editor"
alias j="e ."
alias tree='eza -F --tree --group-directories-first -L 2'
alias treee='eza -F --tree --group-directories-first'
alias md="mkdir -p"
alias math="calc -p"
alias n="z"
alias N="zi"
alias R="source ~/.config/fish/config.fish"
alias open="xdg-open"
