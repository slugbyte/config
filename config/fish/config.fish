if status is-interactive
    set -U fish_greeting ""
    source ~/.config/fish/color.fish

    fish_add_path "$HOME/.cargo/bin"
    fish_add_path "$HOME/go/bin"
    fish_add_path /usr/local/go/bin
    fish_add_path "$HOME/workspace/conf/bin"
    fish_add_path "$HOME/workspace/exec/bin"

    # zoxide 
    zoxide init fish | source

    # ENV
    set -gx w "$HOME/workspace"
    set -gx code "$w/code"
    set -gx conf "$w/conf"
    set -gx data "$w/data"
    set -gx gang "$w/gang"
    set -gx hide "$w/hide"
    set -gx exec "$w/exec"
    set -gx temp "$HOME/Downloads"
    set -gx image "$data/image"

    set -gx EMAIL 'slugbyte@slugbyte.com'
    set -gx FULLNAME 'Duncan Marsh'
    set -gx SHELL (which fish)
    set -gx PAGER (which less)
    set -gx TOPER (which htop)
    set -gx MANPAGER (which less)
    set -gx EDITOR (which hx)
    set -gx LC_ALL 'en_US.UTF-8'

    set -gx PAINT_PROJECT_DIR $data/paint/project
    set -gx PAINT_DEBUG_DIR $data/paint/debug
    set -gx PAINT_DATA_DIR $data/paint/data
    set -gx PAINT_STATE_DIR $data/paint/state
    set -gx PAINT_CACHE_DIR $data/paint/cache

    set -gx ZIG_DIR "$w/exec/share/current"
    set -gx GO_DIR "$HOME/go"
    set -gx RUST_BACKTRACE full
    set -gx GNUPGHOME "$HOME/.config/gnupg"
    set -gx HELIX_RUNTIME "$HOME/workspace/code/helix/runtime"
    set -gx GPG_TTY (tty)
    set -gx EZA_COLORS 'ex=38;2;120;153;120:fi=38;2;204;204;204:di=38;2;85;85;85:b0=38;2;215;0;0:or=38;2;215;0;0:ln=38;2;112;128;144:lp=38;2;112;128;144:lc=38;2;112;128;144:lm=38;2;112;128;144:bd=38;2;119;136;170:cd=38;2;119;136;170:pi=38;2;119;136;170:so=38;2;119;136;170:ur=38;2;122;122;122:uw=38;2;122;122;122:ux=38;2;122;122;122:ue=38;2;122;122;122:gr=38;2;122;122;122:gw=38;2;122;122;122:gx=38;2;122;122;122:tr=38;2;122;122;122:tw=38;2;122;122;122:tx=38;2;122;122;122:su=38;2;122;122;122:sf=38;2;122;122;122:xa=38;2;122;122;122:hd=38;2;68;68;68:bl=38;2;122;122;122:cc=38;2;122;122;122:da=38;2;122;122;122:in=38;2;122;122;122:xx=38;2;122;122;122:ga=38;2;120;153;120:gd=38;2;255;170;136:gm=38;2;119;136;170:gv=38;2;119;136;170:gt=38;2;119;136;170:df=38;2;122;122;122:ds=38;2;122;122;122:sb=38;2;85;85;85:sn=38;2;170;170;170:uu=38;2;85;85;85:un=38;2;85;85;85:gu=38;2;85;85;85:gn=38;2;85;85;85:sc=38;2;204;204;204:bu=38;2;204;204;204:cm=38;2;122;122;122:tm=38;2;122;122;122:co=38;2;122;122;122:do=38;2;122;122;122:cr=38;2;255;170;136:im=38;2;122;122;122:lo=38;2;122;122;122:mu=38;2;122;122;122:vi=38;2;122;122;122:mp=38;2;122;122;122'

    set -gx LESSKEY "$XDG_CONFIG_HOME/less/lesskey"
    set -gx LESSHISTFILE -
    set -gx LESS_TERMCAP_md $COLOR_GRAY6 # bold
    set -gx LESS_TERMCAP_mb $COLOR_BLUE # blink
    set -gx LESS_TERMCAP_us $COLOR_GREEN # underline
    set -gx LESS_TERMCAP_so $COLOR_BG_BLUE # standout
    set -gx LESS_TERMCAP_me $COLOR_RESET
    set -gx LESS_TERMCAP_se $COLOR_RESET
    set -gx LESS_TERMCAP_ue $COLOR_RESET

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

    # alias
    # system
    alias bye="omarchy-cmd-shutdown"
    alias lock="omarchy-cmd-idle"
    alias reboot="omarchy-cmd-reboot"
    alias night="omarchy-toggle-nightlight"

    alias system_update="omarchy-update"

    # force safeutils
    alias mv "echo use move or sysmv"
    alias cp "echo use copy or syscp"
    alias rm "echo use trash or sysrm"
    alias syscp=(which cp)
    alias sysmv=(which mv)
    alias sysrm=(which rm)

    # ls/exa
    alias ls="eza -F --group-directories-first"
    alias ll="ls -la --git --no-user --no-time"
    alias la="ls -a"
    alias l1="ls -1a"

    alias ..="cd .."
    alias b="zig build -freference-trace=10 --summary failures"
    alias t="zig test -freference-trace=10"
    alias clip=$CLIPBOARD_CMD
    alias e="hx"
    alias j="e ."
    alias tree='eza -F --tree --group-directories-first -L 2'
    alias treee='eza -F --tree --group-directories-first'
    alias md="mkdir -p"
    alias n="z"
    alias N="zi"
    alias o='git_open'
    alias O="xdg-open"
    alias p="git_push_main"
    alias P="git_push"
    alias R="source ~/.config/fish/config.fish"
    alias s="git_stat"

    alias pkginstall="omarchy-pkg-install"
    alias pkgremove="omarchy-pkg-remove"

    alias screenshot "omarchy-cmd-screenshot smart clipboard"

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

if not pgrep -u $USER ssh-agent >/dev/null
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end

# deprecated tmux
# alias tlist='tmux list-sessions'
# alias tname='tmux rename-session -t'
# alias tjoin='tmux attach-session -t'
# alias tswap='tmux switch-client -t'
# alias tkill='tmux kill-session -t'
# alias tkillall='killall tmux'
# alias tsync="tmux source ~/.config/tmux/tmux.conf"
