# configrue zle
bindkey -v                           # enable vim mode
bindkey "^W" backward-kill-word      # ctl-w delete word backward insert mode
bindkey -a "^W" backward-kill-word   # ctl-w delete word backward normal mode
bindkey "^?" backward-delete-char    # delete key to work like normal
bindkey "^U" backward-kill-line      # ctl-u delete cur line insert mode
bindkey -a "^U" backward-kill-line   # ctl-u delete cur line normal mode
bindkey '^a' vi-beginning-of-line    # ctl a jumps to beginning of line insert mode
bindkey -a '^a' vi-beginning-of-line # ctl a jumps to beginning of line normal mode
bindkey '^g' vi-end-of-line          # cta s jumps to end of line insert mode
bindkey -a '^g' vi-end-of-line       # cta s jumps to end of line normal mode
bindkey '^r' history-incremental-pattern-search-backward

bindkey -a 'n' down-line-or-history
bindkey -a 'e' up-line-or-history
bindkey -a 'y' vi-backward-char
bindkey -a 'o' vi-forward-char
bindkey -a 'Y' vi-beginning-of-line  # shift y jumps to beginning of lin in normal mode
bindkey -a 'O' vi-end-of-line        # shift o jumps to end of line in normal mode

bindkey -a 'h' vi-find-next-char
bindkey -a 'H' vi-find-prev-char

bindkey -a "'" vi-repeat-find
bindkey -a '"' vi-rev-repeat-find

bindkey -a 'f' vi-repeat-search
bindkey -a 'F' vi-rev-repeat-search

bindkey -a 'k' vi-yank
bindkey -a 'K' vi-yank-whole-line

bindkey -a 's' vi-forward-word
bindkey -a 'S' vi-backward-word

bindkey -a 'E' vi-forward-word-end
bindkey -a 'E' vi-forward-word-end
bindkey -a 'E' vi-forward-word-end
bindkey -a 'J' vi-forward-blank-word-end
bindkey -a 'l' vi-open-line-below
bindkey -a 'L' vi-open-line-above

# C-x C-e edit this command in vim 
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line


# [Shift - Tab] move through the completion menu backwards :)
if [[ "${terminfo[kcbt]}" != "" ]]; then
	bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi
