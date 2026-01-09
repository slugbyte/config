# LOAD ENV
set -gx SHELL (which fish)

# ALLWAYS LOAD ENV
source ~/.config/slugbyte/env.sh

if status is-interactive
    # DISABLE GREETING
    set -U fish_greeting ""

    # LOAD EXTERNAL
    try-cli init | source
    zoxide init fish | source
    mise activate fish | source

    # SET THEME
    source ~/.config/fish/theme.fish

    # SET ALIASES
    source ~/.config/slugbyte/alias.sh
    alias R="source ~/.config/fish/config.fish"

    # SET PROMPT
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

    # FUNCS
    function binedit
        hx (which $argv[1])
    end
    complete -c binedit -a "(complete -C '')" --no-files # ebin autocomplets commands

    function binbat
        bat (which $argv[1])
    end
    complete -c binbat -a "(complete -C '')" --no-files # ebin autocomplets commands
end
