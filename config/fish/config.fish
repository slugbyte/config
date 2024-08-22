if status is-interactive
    set -U fish_greeting ""
    fish_add_path "$HOME/.cargo/bin"
    fish_add_path "$HOME/go/bin"
    fish_add_path "/usr/local/go/bin"
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
    set -gx EDITOR (which nvim)
    set -gx LC_ALL 'en_US.UTF-8'
    set -gx TERM 'alacritty'
    set -gx EZA_COLORS 'ex=38;2;120;153;120:fi=38;2;204;204;204:di=38;2;85;85;85:b0=38;2;215;0;0:or=38;2;215;0;0:ln=38;2;112;128;144:lp=38;2;112;128;144:lc=38;2;112;128;144:lm=38;2;112;128;144:bd=38;2;119;136;170:cd=38;2;119;136;170:pi=38;2;119;136;170:so=38;2;119;136;170:ur=38;2;122;122;122:uw=38;2;122;122;122:ux=38;2;122;122;122:ue=38;2;122;122;122:gr=38;2;122;122;122:gw=38;2;122;122;122:gx=38;2;122;122;122:tr=38;2;122;122;122:tw=38;2;122;122;122:tx=38;2;122;122;122:su=38;2;122;122;122:sf=38;2;122;122;122:xa=38;2;122;122;122:hd=38;2;68;68;68:bl=38;2;122;122;122:cc=38;2;122;122;122:da=38;2;122;122;122:in=38;2;122;122;122:xx=38;2;122;122;122:ga=38;2;120;153;120:gd=38;2;255;170;136:gm=38;2;119;136;170:gv=38;2;119;136;170:gt=38;2;119;136;170:df=38;2;122;122;122:ds=38;2;122;122;122:sb=38;2;85;85;85:sn=38;2;170;170;170:uu=38;2;85;85;85:un=38;2;85;85;85:gu=38;2;85;85;85:gn=38;2;85;85;85:sc=38;2;204;204;204:bu=38;2;204;204;204:cm=38;2;122;122;122:tm=38;2;122;122;122:co=38;2;122;122;122:do=38;2;122;122;122:cr=38;2;255;170;136:im=38;2;122;122;122:lo=38;2;122;122;122:mu=38;2;122;122;122:vi=38;2;122;122;122:mp=38;2;122;122;122'
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_RUNTIME_DIR $HOME/.runtime
    set -gx LESSKEY "$XDG_CONFIG_HOME/less/lesskey"
    set -gx LESSHISTFILE -
    set -gx LESS_TERMCAP_md $COLOR_GRAY6 # bold
    set -gx LESS_TERMCAP_mb $COLOR_BLUE # blink
    set -gx LESS_TERMCAP_us $COLOR_GREEN # underline
    set -gx LESS_TERMCAP_so $COLOR_ORANGE # standout
    set -gx LESS_TERMCAP_me $COLOR_RESET
    set -gx LESS_TERMCAP_se $COLOR_RESET
    set -gx LESS_TERMCAP_ue $COLOR_RESET
    set -gx EMAIL 'slugbyte@slugbyte.com'
    set -gx FULLNAME 'Duncan Marsh'
    set -gx ZIG_DIR "$w/exec/share/current"
    set -gx GO_DIR "$HOME/go"
    set -gx GNUPGHOME "$HOME/.config/gnupg"
    set -gx GPG_TTY (tty)

    # SECRET ENV
    if test -d $w/hide/env
        for env_file in $w/hide/env/*.fish 
            source $env_file
        end
    end

    # env by uname
    switch (uname)
    case Linux
        set -gx COPYER "xclip -in -selection clipboard"
        set -gx trash "$HOME/.local/share/Trash/files"
    case Darwin
        set -gx COPYER (which pbcopy)
        set -gx trash "$HOME/.Trash"
    end

    # git
    function git_commit
       git commit -S $argv && git verify-commit HEAD
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
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test $branch = "HEAD"
            echo "ERROR: cannot push from detatched state."
            return -1
        end
        git push origin $branch $argv --tags
    end

    function git_push_upstream
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test $branch = "HEAD"
            echo "ERROR: cannot push from detatched state."
            return -1
        end
        git push upstream $branch $argv --tags
    end


    function git_log
      git log --graph --pretty=format:'%C(bold blue)%h%Creset %C(cyan)[%cr] %C(magenta)%an%Creset - %Creset%s%C(yellow)%d%Creset' --abbrev-commit 
    end

    # trash
    function trash 
        if not test -d $trash
            log_red "ERROR: no trash dir found"
        end
        if test (count $argv) -eq 0
            log_orange "USAGE ERROR: NOTHING TO TRASH"
            echo "trash <files..>"
        end
        for f in $argv
            set SOURCE_BASENAME (basename $f)
            set -l CURRENT_DATE (date +'%Y%m%d%H%M%S')
            # $f not exist
            if not test -e $f
                log_orange "WARN: no such file [$f]"
                continue
            end
            # $f is a directory
            if test -d $f
                set -l RANDOM_NUMBER (random 0 10000000000)
                set -l OUTPUT_BASENAME $SOURCE_BASENAME"_$CURRENT_DATE"_"$RANDOM_NUMBER"
                set -l OUTPUT_PATH "$trash/$OUTPUT_BASENAME"
                set -l SOURCE_PATH (readlink -f $f)
                mv "$f" "$OUTPUT_PATH"
                touch "$OUTPUT_PATH"
                echo "$SOURCE_BASENAME -> \$trash/$OUTPUT_BASENAME"
                continue
            end
            # $f is not a directory
            set -l CHECKSUM (shasum "$f" | cut -d ' ' -f 1 | sed -e 's/[[:space:]]*$//')
            set -l OUTPUT_BASENAME $SOURCE_BASENAME"_"$CURRENT_DATE"_"$CHECKSUM
            set -l OUTPUT_PATH "$trash/$OUTPUT_BASENAME"
            set -l SOURCE_PATH (readlink -f $f)
            mv "$f" "$OUTPUT_PATH"
            touch "$OUTPUT_PATH"
            echo "$SOURCE_BASENAME -> \$trash/$OUTPUT_BASENAME"
        end
    end

    function trash_clean
      find $trash -maxdepth 1 -mtime +20 | xargs -I {} (which rm) -rfv {}
    end

    function trash_help
      echo $COLOR_GRAY6"DELETEING STUFF:"$COLOR_RESET
      echo "trash            - move a file to the trash"
      echo "del              - actually delete file"
      echo
      echo $COLOR_GRAY6"MANAGE TRASH_DIR:"$COLOR_RESET
      echo "trash_clean      - delete files older than 20 days"
    end

    # screenshot
    function _sc_output_path
        if test (count $argv) -eq 0
            log_red "ERROR: screen capture requires a name"
            echo "\n\$ sc <name>\n"
            return 1
        end
        set -l DATE (date +"%Y-%m-%d-%H%M%S")
        set -l NAME "sc-"$DATE"-"$argv[1]".png"
        set -l NAME (echo $NAME | string replace -a " " "-" | string replace -a "_" "-")
        set -l OUTPUT_PATH "$temp/$NAME"
        echo "$OUTPUT_PATH"
    end

    # linux
    function _linux_xs
        if test (count $argv) -eq 0
            log_red "ERROR: must provide search term"
            return
        end
        sudo apt-cache search $argv | fzf
    end

    function _linux_xu
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
    end

    function _linux_sc 
        set -l OUTPUT_PATH (_sc_output_path $argv)
        if not test $status -eq 0
            printf "$OUTPUT_PATH"
            return $status
        end
        scrot -s $OUTPUT_PATH
        log_blue "[SCREEN CAPTURE] "(basename $OUTPUT_PATH)
    end

    function _linux_sca 
        set -l OUTPUT_PATH (_sc_output_path $argv)
        if not test $status -eq 0
            printf "$OUTPUT_PATH"
            return $status
        end
        scrot $OUTPUT_PATH
        log_blue "[SCREEN CAPTURE] "(basename $OUTPUT_PATH)
    end

    # mac
    function _mac_sc
        set -l OUTPUT_PATH (_sc_output_path $argv)
        if not test $status -eq 0
            printf "$OUTPUT_PATH"
            return $status
        end
        screencapture -t png -i -J selection "$SC_NAME"
        log_blue "[SCREEN CAPTURE] "(basename $OUTPUT_PATH)
    end

    function _mac_sca
        set -l OUTPUT_PATH (_sc_output_path $argv)
        if not test $status -eq 0
            printf "$OUTPUT_PATH"
            return $status
        end
        screencapture -t png "$SC_NAME"
        log_blue "[SCREEN CAPTURE] "(basename $OUTPUT_PATH)
    end

    function checkf
        set -gx CHECK_LAST (fzf)
        log_blue check $CHECK_LAST
        go test $CHECK_LAST
    end

    function check
        log_blue check $CHECK_LAST
        go test $CHECK_LAST
    end
    function checkv
        log_blue check $CHECK_LAST
        go test -v $CHECK_LAST
    end

    # alias
    alias ..="cd .."
    alias ,,="cd -"
    alias a="git add"
    alias A="git add ."
    alias b="git branch"
    alias bye="sudo shutdown -h now"
    alias B="git branch -a"
    alias c="git_commit"
    alias C="git_commit --amend --no-edit"
    alias copy=$COPYER
    alias ch="git checkout"
    alias d="git diff"
    alias D="git diff --cached"
    alias del=(which rm)
    alias e="nvim"
    alias f="git fetch -pv"
    alias g="echo naw"
    alias h="echo nam"
    alias i="echo naw"
    alias j="e -c ':lua require(\"unruly-worker\").boost.telescope.find_files()'"
    alias J="e -c ':lua require(\"unruly-worker\").boost.telescope.live_grep()'"
    alias k="echo naw"
    alias l="git_pull_rebase"
    alias L="git_pull"
    alias lu="git_pull_upstream"
    alias ls="eza -F --group-directories-first"
    alias ll="ls -la --git --no-user --no-time"
    alias llt="ls -la --total-size --git --no-user --time=created --time-style=long-iso"
    alias la="ls -a"
    alias l1="ls -1a"
    alias tree='eza -F --tree --group-directories-first -L 2'
    alias treee='eza -F --tree --group-directories-first'
    alias log="git_log"
    alias m="make" 
    alias md="mkdir -p"
    alias n="z"
    alias N="zi"
    alias o="open"
    alias O="gitopen"
    alias p="git_push"
    alias pu="git_push_upstream"
    alias q="echo naw"
    alias r="git rebase -Si"
    alias R="source ~/.config/fish/config.fish"
    alias rm="trash_help"
    alias s="git status --short"
    alias t="echo naw"
    alias tlist='tmux list-sessions'
    alias tname='tmux rename-session -t'
    alias tjoin='tmux attach-session -t'
    alias tswap='tmux switch-client -t'
    alias tkill='tmux kill-session -t'
    alias tkillall='killall tmux'
    alias tsync="tmux source ~/.config/tmux/tmux.conf"
    alias u="echo naw"
    alias v="echo naw"
    alias w="e -c ':WhipFindFile'"
    alias W="e -c ':WhipOpen'"
    alias x="git reset"
    alias y="echo naw"


    # alias by uname
    switch (uname)
    case Linux
        alias xi="sudo apt-get install"
        alias xr="sudo apt-get remove"
        alias xq="sudo apt-cache show"
        alias xu="_linux_xu"
        alias xs="_linux_xs"
        alias sc="_linux_sc"
        alias sca="_linux_sca"
    case Darwin
        alias xi="brew install"                # I - install
        alias xs="brew search"                 # S - search
        alias xu="brew update && brew upgrade" # U - update
        alias xr="brew uninstall"              # R - remove
        alias xq="brew info"                   # R - query info 
        alias sc="_mac_sc"
        alias sca="_mac_sca"
    end


    function fish_prompt
        set git_branch_color $COLOR_ORANGE
        set git_branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
        if test $status -ne 0
            set  git_branch ""
        end

        set git_status (git status --porcelain 2> /dev/null)
        if test -z "$git_status"
            set git_branch_color $COLOR_GRAY6
        end
        if test "$git_branch" = "HEAD" 
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
        printf "$git_branch$dir$COLOR_RESET\n| "
    end

end
