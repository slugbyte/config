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
        set -l vcs_info ""
        # try jj first (single call for desc + dirty via template)
        set -l jj_out (jj log --no-graph -r @ -T 'separate("\t", if(empty, "", "*"), description.first_line())' 2>/dev/null)
        if test $status -eq 0
            set -l parts (string split \t -- $jj_out)
            set -l dirty $parts[1]
            set -l desc $parts[2]
            if test -z "$desc"
                set desc "no desc"
            end
            set vcs_info "$COLOR_GRAY7 $dirty($desc)"
        else if git rev-parse --is-inside-work-tree &>/dev/null
            # fall back to git
            set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if test -n "$branch"
                if test "$branch" = HEAD
                    set branch _
                end
                set -l dirty ""
                if test -n "$(git status --porcelain 2>/dev/null)"
                    set dirty "*"
                end
                set vcs_info " $COLOR_GRAY7""git [$dirty$branch] "
            end
        end
        set -l dir (string replace -r "^$HOME" "~" $PWD)
        printf "%s%s%s%s\n| " "$COLOR_GRAY5" "$dir" "$vcs_info" "$COLOR_RESET"
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
