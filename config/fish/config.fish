if status is-interactive
    set -U fish_greeting ""
    fish_add_path "$HOME/.cargo/bin"
    fish_add_path "$HOME/go/bin"
    fish_add_path /usr/local/go/bin
    fish_add_path "$HOME/workspace/conf/bin"
    fish_add_path "$HOME/workspace/exec/bin"

    # zoxide 
    zoxide init fish | source
    # fast node manager
    # fnm env --use-on-cd | source
    fnm env | source

    # colors
    set -gx COLOR_RESET \033'[0m'
    set -gx COLOR_LACK \033'[38;2;112;128;144m'
    set -gx COLOR_LUSTER \033'[38;2;222;238;237m'
    set -gx COLOR_ORANGE \033'[38;2;255;170;136m'
    set -gx COLOR_GREEN \033'[38;2;120;153;120m'
    set -gx COLOR_BLUE \033'[38;2;119;136;170m'
    set -gx COLOR_RED \033'[38;2;215;0;0m'
    set -gx COLOR_BLACK \033'[38;2;0;0;0m'
    set -gx COLOR_GRAY1 \033'[38;2;8;8;8m'
    set -gx COLOR_GRAY2 \033'[38;2;25;25;25m'
    set -gx COLOR_GRAY3 \033'[38;2;42;42;42m'
    set -gx COLOR_GRAY4 \033'[38;2;68;68;68m'
    set -gx COLOR_GRAY5 \033'[38;2;85;85;85m'
    set -gx COLOR_GRAY6 \033'[38;2;122;122;122m'
    set -gx COLOR_GRAY7 \033'[38;2;170;170;170m'
    set -gx COLOR_GRAY8 \033'[38;2;204;204;204m'
    set -gx COLOR_GRAY9 \033'[38;2;221;221;221m'

    set -gx COLOR_BG_LACK \033'[48;2;112;128;144m'
    set -gx COLOR_BG_LUSTER \033'[48;2;222;238;237m'
    set -gx COLOR_BG_ORANGE \033'[48;2;255;170;136m'
    set -gx COLOR_BG_GREEN \033'[48;2;120;153;120m'
    set -gx COLOR_BG_BLUE \033'[48;2;119;136;170m'
    set -gx COLOR_BG_RED \033'[48;2;215;0;0m'
    set -gx COLOR_BG_BLACK \033'[48;2;0;0;0m'
    set -gx COLOR_BG_GRAY1 \033'[48;2;8;8;8m'
    set -gx COLOR_BG_GRAY2 \033'[48;2;25;25;25m'
    set -gx COLOR_BG_GRAY3 \033'[48;2;42;42;42m'
    set -gx COLOR_BG_GRAY4 \033'[48;2;68;68;68m'
    set -gx COLOR_BG_GRAY5 \033'[48;2;85;85;85m'
    set -gx COLOR_BG_GRAY6 \033'[48;2;122;122;122m'
    set -gx COLOR_BG_GRAY7 \033'[48;2;170;170;170m'
    set -gx COLOR_BG_GRAY8 \033'[48;2;204;204;204m'
    set -gx COLOR_BG_GRAY9 \033'[48;2;221;221;221m'

    set -gx fish_color_end 7a7a7a
    set -gx fish_color_error ffaa88
    set -gx fish_color_quote 708090
    set -gx fish_color_param aaaaaa
    set -gx fish_color_option aaaaaa
    set -gx fish_color_normal CCCCCC
    set -gx fish_color_escape 789978
    set -gx fish_color_comment 555555
    set -gx fish_color_command CCCCCC
    set -gx fish_color_keyword 7a7a7a
    set -gx fish_color_operator 7788aa
    set -gx fish_color_redirection ffaa88
    set -gx fish_color_autosuggestion 2a2a2a
    set -gx fish_color_selection --background=555555
    set -gx fish_color_search_match --background=555555
    set -gx fish_pager_color_prefix 999999
    set -gx fish_pager_color_progress 555555
    set -gx fish_pager_color_completion cccccc
    set -gx fish_pager_color_description 7a7a7a
    set -gx fish_pager_color_selected_background --background=555555

    # Completion Pager Colors
    function log_lack
        echo $COLOR_LACK$argv$COLOR_RESET
    end
    function log_luster
        echo $COLOR_LUSTER$argv$COLOR_RESET
    end
    function log_orange
        echo $COLOR_ORANGE$argv$COLOR_RESET
    end
    function log_green
        echo $COLOR_GREEN$argv$COLOR_RESET
    end
    function log_blue
        echo $COLOR_BLUE$argv$COLOR_RESET
    end
    function log_red
        echo $COLOR_RED$argv$COLOR_RESET
    end
    function log_black
        echo $COLOR_BLACK$argv$COLOR_RESET
    end
    function log_gray1
        echo $COLOR_GRAY1$argv$COLOR_RESET
    end
    function log_gray2
        echo $COLOR_GRAY2$argv$COLOR_RESET
    end
    function log_gray3
        echo $COLOR_GRAY3$argv$COLOR_RESET
    end
    function log_gray4
        echo $COLOR_GRAY4$argv$COLOR_RESET
    end
    function log_gray5
        echo $COLOR_GRAY5$argv$COLOR_RESET
    end
    function log_gray6
        echo $COLOR_GRAY6$argv$COLOR_RESET
    end
    function log_gray7
        echo $COLOR_GRAY7$argv$COLOR_RESET
    end
    function log_gray8
        echo $COLOR_GRAY8$argv$COLOR_RESET
    end
    function log_gray9
        echo $COLOR_GRAY9$argv$COLOR_RESET
    end

    # test debug
    function check
        if test $argv
            log_green "TRUE [test $argv]"
        else
            log_red "FALSE [test $argv]"
        end
    end

    # ENV
    set -gx w "$HOME/workspace"
    set -gx code "$w/code"
    set -gx conf "$w/conf"
    set -gx data "$w/data"
    set -gx gang "$w/gang"
    set -gx hide "$w/hide"
    set -gx exec "$w/exec"
    set -gx temp "$HOME/Downloads"

    set -gx SHELL (which fish)
    set -gx PAGER (which less)
    set -gx TOPER (which htop)
    set -gx MANPAGER (which less)
    set -gx EDITOR (which hx)
    set -gx RUST_BACKTRACE full
    set -gx HELIX_RUNTIME "$HOME/workspace/code/helix/runtime"
    set -gx LC_ALL 'en_US.UTF-8'
    # set -gx TERM 'alacritty'
    set -gx EZA_COLORS 'ex=38;2;120;153;120:fi=38;2;204;204;204:di=38;2;85;85;85:b0=38;2;215;0;0:or=38;2;215;0;0:ln=38;2;112;128;144:lp=38;2;112;128;144:lc=38;2;112;128;144:lm=38;2;112;128;144:bd=38;2;119;136;170:cd=38;2;119;136;170:pi=38;2;119;136;170:so=38;2;119;136;170:ur=38;2;122;122;122:uw=38;2;122;122;122:ux=38;2;122;122;122:ue=38;2;122;122;122:gr=38;2;122;122;122:gw=38;2;122;122;122:gx=38;2;122;122;122:tr=38;2;122;122;122:tw=38;2;122;122;122:tx=38;2;122;122;122:su=38;2;122;122;122:sf=38;2;122;122;122:xa=38;2;122;122;122:hd=38;2;68;68;68:bl=38;2;122;122;122:cc=38;2;122;122;122:da=38;2;122;122;122:in=38;2;122;122;122:xx=38;2;122;122;122:ga=38;2;120;153;120:gd=38;2;255;170;136:gm=38;2;119;136;170:gv=38;2;119;136;170:gt=38;2;119;136;170:df=38;2;122;122;122:ds=38;2;122;122;122:sb=38;2;85;85;85:sn=38;2;170;170;170:uu=38;2;85;85;85:un=38;2;85;85;85:gu=38;2;85;85;85:gn=38;2;85;85;85:sc=38;2;204;204;204:bu=38;2;204;204;204:cm=38;2;122;122;122:tm=38;2;122;122;122:co=38;2;122;122;122:do=38;2;122;122;122:cr=38;2;255;170;136:im=38;2;122;122;122:lo=38;2;122;122;122:mu=38;2;122;122;122:vi=38;2;122;122;122:mp=38;2;122;122;122'
    # set -gx XDG_CONFIG_HOME $HOME/.config
    # set -gx XDG_CACHE_HOME $HOME/.cache
    # set -gx XDG_DATA_HOME $HOME/.local/share
    # set -gx XDG_RUNTIME_DIR $HOME/.runtime
    set -gx LESSKEY "$XDG_CONFIG_HOME/less/lesskey"
    set -gx LESSHISTFILE -
    set -gx LESS_TERMCAP_md $COLOR_GRAY6 # bold
    set -gx LESS_TERMCAP_mb $COLOR_BLUE # blink
    set -gx LESS_TERMCAP_us $COLOR_GREEN # underline
    set -gx LESS_TERMCAP_so $COLOR_BG_BLUE # standout
    set -gx LESS_TERMCAP_me $COLOR_RESET
    set -gx LESS_TERMCAP_se $COLOR_RESET
    set -gx LESS_TERMCAP_ue $COLOR_RESET
    set -gx EMAIL 'slugbyte@slugbyte.com'
    set -gx FULLNAME 'Duncan Marsh'
    set -gx ZIG_DIR "$w/exec/share/current"
    set -gx GO_DIR "$HOME/go"
    set -gx GNUPGHOME "$HOME/.config/gnupg"
    set -gx GPG_TTY (tty)

    set -gx WAYLAND_DISPLAY $WAYLAND_DISPLAY
    set -gx SWAYSOCK $SWAYSOCK

    set -gx PAINT_PROJECT_DIR $data/paint/project
    set -gx PAINT_DEBUG_DIR $data/paint/debug
    set -gx PAINT_DATA_DIR $data/paint/data
    set -gx PAINT_STATE_DIR $data/paint/state
    set -gx PAINT_CACHE_DIR $data/paint/cache

    # SECRET ENV
    if test -d $w/hide/env
        for env_file in $w/hide/env/*.fish
            source $env_file
        end
    end

    # env by uname
    switch (uname)
        case Linux
            if set -q WAYLAND_DISPLAY
                set -gx CLIPBOARD_CMD wl-copy
            else
                set -gx CLIPBOARD_CMD "xclip -in -selection clipboard"
            end
            set -gx trash "$HOME/.local/share/Trash/files"
        case Darwin
            set -gx CLIPBOARD_CMD (which pbcopy)
            set -gx trash "$HOME/.Trash"
    end

    # git
    function git_commit
        if test -d .jj
            jj desc $argv
            return
        end
        git commit -S $argv && git verify-commit HEAD
    end

    function git_open
        if test -d .jj
            git -C $(jj git root) open
            return
        end
        git open
    end

    function git_commit_amend
        if test -d .jj
            jj desc $argv
            return
        end
        git_commit --amend $argv
    end

    function git_stat
        if test -d .jj
            jj status --no-pager
            return
        end
        git status
    end

    function git_diff
        if test -d .jj
            jj diff $argv
            return
        end
        git diff $argv
    end

    function git_branch
        if test -d .jj
            jj bookmark $argv
            return
        end
        git branch $argv
    end

    function git_reset
        if test -d .jj
            jj abandon $argv
            return
        end
        git reset
    end

    function git_fetch
        if test -d .jj
            jj git fetch
            return
        end
        git fetch -pv
    end

    function git_pull_rebase
        if test (count $argv) -gt 0
            git pull origin $argv -v --rebase=interactive
            return
        end
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test -z $branch
            echo "Error: Not a git repository"
            return
        end
        echo "Pulling from $branch"
        git pull origin $branch -v --rebase=interactive
    end

    function git_pull
        if test -d ./.jj
            jj git fetch
            return
        end
        if test (count $argv) -gt 0
            git pull origin $argv -v
            return -1
        end
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test -z $branch
            echo "Error: Not a git repository"
            return -1
        end
        echo "Pulling from $branch"
        git pull origin $branch -v
    end

    function git_pull_upstream
        if test -d ./.jj
            jj git fetch
            return
        end
        if test (count $argv) -gt 0
            git pull upstream $argv -v
            return -1
        end
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test -z $branch
            echo "Error: Not a git repository"
            return -1
        end
        echo "Pulling from $branch"
        git pull upstream $branch -v
    end

    function git_push
        if test -d ./.jj
            jj bookmark set develop -r @- --allow-backwards
            jj git push -r develop --allow-new
            return
        end
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test $branch = HEAD
            echo "ERROR: cannot push from detatched state."
            return -1
        end
        git push origin $branch $argv --tags
    end

    function git_push_main
        if test -d ./.jj
            jj bookmark set main -r @- --allow-backwards
            jj git push -r main --allow-new
            return
        end
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test $branch = HEAD
            echo "ERROR: cannot push from detatched state."
            return -1
        end
        git push origin $branch $argv --tags
    end

    function git_log
        if test -d ./.jj
            jj log
            return
        end
        git log --graph --pretty=format:'%C(bold blue)%h%Creset %C(cyan)[%cr] %C(magenta)%an%Creset - %Creset%s%C(yellow)%d%Creset' --abbrev-commit
    end

    function trash_clean
        find $trash -maxdepth 1 -mtime +20 | xargs -I {} (which rm) -rfv {}
    end

    # screenshot

    function _linux_sc
        set -l OUTPUT_PATH (scfilepath $argv)
        if not test $status -eq 0
            echo $OUTPUT_PATH # its the error msg
            return 1
        end
        grim -g (slurp -d) $OUTPUT_PATH

        # scrot -s $OUTPUT_PATH
        log_blue "[SCREEN CAPTURE] "(basename $OUTPUT_PATH)
    end

    function _linux_sca
        set -l OUTPUT_PATH (scfilepath $argv)
        if not test $status -eq 0
            echo $OUTPUT_PATH # its the error msg
            return 1
        end
        grim -g (slurp -o) $OUTPUT_PATH
        # scrot $OUTPUT_PATH
        log_blue "[SCREEN CAPTURE] "(basename $OUTPUT_PATH)
    end

    # alias
    # force safeutils
    alias mv "echo use move or sysmv"
    alias cp "echo use copy or syscp"
    alias rm "echo use trash or sysrm"
    alias syscp=(which cp)
    alias sysmv=(which mv)
    alias sysrm=(which rm)

    alias ..="cd .."
    alias ,,="cd -"
    # alias a="git add"
    # alias A="git add ."
    alias b="zig build -freference-trace=10 --summary failures"
    alias t="zig test -freference-trace=10"
    alias bye="sudo shutdown -h now"
    alias zzz="sudo systemctl suspend"
    alias logout="swaymsg exit"
    # alias B="git branch -a"
    # alias c="git_commit"
    # alias c="git_commit"
    # alias C="git_commit_amend"
    # alias C="git_commit --amend --no-edit"
    alias clipboard=$CLIPBOARD_CMD
    # alias ch="git checkout"
    # alias d="git_diff"
    # alias del=(which rm)
    # alias mv="move"
    # alias cp="copy"
    alias e="hx"
    # alias f="git_fetch"
    # alias g="echo naw"
    # alias h="echo nam"
    # alias i="echo naw"
    alias j="e ."
    # alias J="e -c ':lua require(\"unruly-worker\").boost.telescope.live_grep()'"
    # alias k="echo naw"
    # alias l="git_log"
    alias ls="eza -F --group-directories-first"
    alias ll="ls -la --git --no-user --no-time"
    alias la="ls -a"
    alias l1="ls -1a"
    alias tree='eza -F --tree --group-directories-first -L 2'
    alias treee='eza -F --tree --group-directories-first'
    alias md="mkdir -p"
    alias n="z"
    alias N="zi"
    alias o='git_open'
    # alias O="xdg-open"
    alias p="git_push_main"
    alias P="git_push"
    # alias pu="git_push_upstream"
    # alias q="echo naw"
    # alias r="git rebase -Si"
    alias R="source ~/.config/fish/config.fish"
    # alias s="git status --short"
    alias s="git_stat"
    alias stream="QT_QPA_PLATFROM=xcb obs"
    # alias t="echo naw"
    alias tlist='tmux list-sessions'
    alias tname='tmux rename-session -t'
    alias tjoin='tmux attach-session -t'
    alias tswap='tmux switch-client -t'
    alias tkill='tmux kill-session -t'
    alias tkillall='killall tmux'
    alias tsync="tmux source ~/.config/tmux/tmux.conf"
    # alias u="echo naw"
    # alias v="echo naw"
    # alias w="e -c ':WhipFindFile'"
    # alias W="e -c ':WhipOpen'"
    # alias x="git_reset"
    # alias y="echo naw"

    # alias by uname
    switch (uname)
        case Linux
            alias scselect="_linux_sc"
            alias scmonitor="_linux_sca"
        case Darwin
            alias sc="_mac_sc"
            alias sca="_mac_sca"
    end

    function jj_prompt
        if test -d ./.jj
            set jj_desc (jj log --no-graph --template 'description' -r @ | head -n 1)
            if test -z $jj_desc
                echo "$COLOR_BLUE (no desc)"
                return
            end
            echo "$COLOR_BLUE ($jj_desc)"
        end
    end

    function fish_prompt
        set jj_desc (jj_prompt)
        set git_branch_color $COLOR_ORANGE
        set git_branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test $status -ne 0
            set git_branch ""
        end

        set git_status (git status --porcelain 2> /dev/null)
        if test -z "$git_status"
            set git_branch_color $COLOR_GRAY6
        end
        if test "$git_branch" = HEAD
            set git_branch $COLOR_RED"(detatched) "
        end
        if test -n "$git_branch"
            set git_branch $git_branch_color"[$git_branch] "
        end
        set dir (echo $PWD | string replace $HOME "")
        if test -z $dir
            set dir "~"
        end
        set dir $COLOR_GRAY5$dir
        printf "$git_branch$dir$jj_desc$COLOR_RESET\n| "
    end

end

function math
    echo "$argv" | bc
end

# jj util completion fish | source

if not pgrep -u $USER ssh-agent >/dev/null
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end
