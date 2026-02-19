# LOAD ENV
set -gx SHELL (which fish)

# ALLWAYS LOAD ENV
source ~/.config/slugbyte/env.sh

if status is-interactive
    # DISABLE GREETING
    set -g fish_greeting ""

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
        set -l last_status $status
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
        else
            # fall back to git (single call)
            set -l porcelain (git status --porcelain -b 2>/dev/null)
            if test $status -eq 0
                set -l branch (string replace -r '^## (.+?)(\.\.\..+)?$' '$1' -- $porcelain[1])
                if test "$branch" = "HEAD (no branch)"
                    set branch _
                end
                set -l dirty ""
                if test (count $porcelain) -gt 1
                    set dirty "*"
                end
                set vcs_info " $COLOR_GRAY7""git [$dirty$branch] "
            end
        end

        # duration info (always shown)
        set -l duration_info ""
        if test $CMD_DURATION -lt 1000
            set duration_info " $COLOR_GRAY5""$CMD_DURATION"ms
        else
            set -l secs (echo "scale=1; $CMD_DURATION / 1000" | bc)
            set duration_info " $COLOR_GRAY5""$secs"s
        end

        # red prompt indicator on failure
        set -l prompt_color "$COLOR_GRAY5"
        if test $last_status -ne 0
            set prompt_color "$COLOR_ORANGE"
        end

        set -l dir (string replace -r "^$HOME" "~" $PWD)
        printf "%s%s%s%s%s\n%s| %s" "$COLOR_GRAY5" "$dir" "$duration_info" "$vcs_info" "$COLOR_RESET" "$prompt_color" "$COLOR_RESET"
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
