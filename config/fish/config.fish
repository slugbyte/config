if status is-interactive
    set -U fish_greeting ""

    source ~/.config/fish/theme.fish
    source ~/.config/bash/env.sh

    zoxide init fish | source

    function manfzf
        man -k . | fzf --preview 'man {1}' | awk '{print $1}' | xargs man
    end
    function binedit
        hx (which $argv[1])
    end
    complete -c binedit -a "(complete -C '')" --no-files # ebin autocomplets commands

    function binbat
        bat (which $argv[1])
    end
    complete -c binbat -a "(complete -C '')" --no-files # ebin autocomplets commands

    alias binmake="chmod +x"

    # alias
    # system
    alias night="omarchy-toggle-nightlight &>/dev/null"

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
    alias e="hx"
    alias j="e ."
    alias tree='eza -F --tree --group-directories-first -L 2'
    alias treee='eza -F --tree --group-directories-first'
    alias md="mkdir -p"
    alias math="calc -p"
    alias n="z"
    alias N="zi"
    alias R="source ~/.config/fish/config.fish"
    alias open="xdg-open"

    function fish_prompt
        set -l jj_desc ""
        set -l git_desc ""
        if test -d .jj
            set -l desc (jj log --no-graph -r @ -T 'description.first_line()' 2>/dev/null)
            if test -z "$desc"
                set jj_desc "$COLOR_GRAY7 (no desc)"
            else
                set jj_desc "$COLOR_GRAY7 ($desc)"
            end
        else
            if test -d .git
                set -l git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
                set -l git_dirty ""
                if test -n "$git_branch"
                    if test "$git_branch" = HEAD
                        set git_branch _
                    end
                    set -l vstatus (git status --porcelain 2>/dev/null)
                    if test -n "$vstatus"
                        set git_dirty "*"
                    end
                    set git_desc " $COLOR_GRAY7""git [$git_dirty$git_branch] "
                end
            end
        end
        set -l dir (string replace -r "^$HOME" "~" $PWD)
        printf "%s%s%s%s%s\n| " "$COLOR_GRAY5" "$dir" "$git_desc" "$jj_desc" "$COLOR_RESET"
    end

end
