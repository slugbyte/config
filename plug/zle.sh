# configrue zle
bindkey -v                           # enable vim mode
bindkey "^W" backward-kill-word      # ctl-w delete word backward insert mode
bindkey -a "^W" backward-kill-word   # ctl-w delete word backward normal mode
bindkey "^H" backward-delete-char    # Control-h also deletes the previous char
bindkey "^U" backward-kill-line      # ctl-u delete cur line insert mode
bindkey -a "^U" backward-kill-line   # ctl-u delete cur line normal mode
bindkey "^?" backward-delete-char    # delete key to work like normal
bindkey -a 'L' vi-end-of-line        # shift l jumps to end of line in normal mode
bindkey -a 'H' vi-beginning-of-line  # shift h jumps to beginning of lin in normal mode
bindkey '^a' vi-beginning-of-line    # ctl a jumps to beginning of line insert mode
bindkey -a '^a' vi-beginning-of-line # ctl a jumps to beginning of line normal mode
bindkey '^e' vi-end-of-line          # cta e jumps to end of line insert mode
bindkey -a '^e' vi-end-of-line       # cta e jumps to end of line normal mode
bindkey '^r' history-incremental-pattern-search-backward

# C-x C-e edit this command in vim 
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line


# [Shift - Tab] move through the completion menu backwards :)
if [[ "${terminfo[kcbt]}" != "" ]]; then
	bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi
