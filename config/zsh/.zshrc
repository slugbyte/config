# Options
setopt no_clobber # let me overwrite files
setopt rm_star_silent # dont ask to delete
setopt chase_links # resolve symlinks
setopt extended_glob # better glob
setopt glob_dots # glob include dotfiles
zstyle ':completion:*' menu select # better zsh completion

#---- ENVIRON ---- ##############################################
#-ENV GENERAL
export SHELL=$(which zsh)
export PAGER=$(which less)
export TOPER=$(which htop)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=$(which nvim)
# export COPYER=$(which pbcopy)
export LC_ALL='en_US.UTF-8'
export TERM='screen-256color'

#-ENV XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_RUNTIME_DIR=$HOME/.runtime

#-ENV LESS
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE=-
export LESS_TERMCAP_so=$(tput setab 240)
export LESS_TERMCAP_se=$(echo -e '\e[0m')

#-ENV WHOAMI
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'
# NVIM
export PATH="/opt/nvim-linux64/bin:$PATH"

#-ENV RUST
export PATH="$HOME/.cargo/bin:$PATH"

#-ENV GO
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

#-ENV personal dirs dirs
export TRASH_DIR="$HOME/.Trash"
export trash="$TRASH_DIR"
export w="$HOME/workspace"
export code="$w/code"
export conf="$w/conf"
export data="$w/data"
export exec="$w/conf/exec"
export gang="$w/gang"
export hide="$w/hide"
export hist="$w/hist"
export lang="$w/lang"
export play="$w/play"
export temp="$HOME/Downloads"
export work="$w/work"
export PATH="$exec:$PATH"

#-ENV ZIG
export ZIG_DIR="$w/lang/zig"
export PATH="$ZIG_DIR:$PATH"
export PATH="$w/lang/zls/zig-out/bin:$PATH"

function zig-use-12(){
  /bin/rm $lang/zig $lang/zls
  ln -s "$lang/zig-0.12.0" "$lang/zig"
  ln -s "$lang/zls-0.12.0" "$lang/zls"
}

function zig-use-mach(){
  /bin/rm $lang/zig $lang/zls
  ln -s "$lang/zig-mach" "$lang/zig"
  ln -s "$lang/zls-mach" "$lang/zls"
}

function zig-use-master(){
  /bin/rm $lang/zig $lang/zls
  ln -s "$lang/zig-master" "$lang/zig"
  ln -s "$lang/zls-master" "$lang/zls"
}

#-ENV ZSH
export ZDOTDIR="$HOME/.config/zsh"

#-ENV FZF / RG
export FZF_DEFAULT_COMMAND='rg --files --hidden'

#-ENV-SECRETS
# for file in $hide/env/*.sh;do
#   source $file
# done


echo_red(){
  echo "$(tput setaf 1)$@$(tput sgr 0)"
}

echo_yellow (){
  echo "$(tput setaf 3)$@$(tput sgr 0)"
}

echo_green (){
  echo "$(tput setaf 2)$@$(tput sgr 0)"
}

echo_blue(){
  echo "$(tput setaf 4)$@$(tput sgr 0)"
}

#---- EZA ---- ##############################################
export EZA_COLORS='ex=38;2;120;153;120:fi=38;2;204;204;204:di=38;2;85;85;85:b0=38;2;215;0;0:or=38;2;215;0;0:ln=38;2;112;128;144:lp=38;2;112;128;144:lc=38;2;112;128;144:lm=38;2;112;128;144:bd=38;2;119;136;170:cd=38;2;119;136;170:pi=38;2;119;136;170:so=38;2;119;136;170:ur=38;2;122;122;122:uw=38;2;122;122;122:ux=38;2;122;122;122:ue=38;2;122;122;122:gr=38;2;122;122;122:gw=38;2;122;122;122:gx=38;2;122;122;122:tr=38;2;122;122;122:tw=38;2;122;122;122:tx=38;2;122;122;122:su=38;2;122;122;122:sf=38;2;122;122;122:xa=38;2;122;122;122:hd=38;2;68;68;68:bl=38;2;122;122;122:cc=38;2;122;122;122:da=38;2;122;122;122:in=38;2;122;122;122:xx=38;2;122;122;122:ga=38;2;120;153;120:gd=38;2;255;170;136:gm=38;2;119;136;170:gv=38;2;119;136;170:gt=38;2;119;136;170:df=38;2;122;122;122:ds=38;2;122;122;122:sb=38;2;85;85;85:sn=38;2;170;170;170:uu=38;2;85;85;85:un=38;2;85;85;85:gu=38;2;85;85;85:gn=38;2;85;85;85:sc=38;2;204;204;204:bu=38;2;204;204;204:cm=38;2;122;122;122:tm=38;2;122;122;122:co=38;2;122;122;122:do=38;2;122;122;122:cr=38;2;255;170;136:im=38;2;122;122;122:lo=38;2;122;122;122:mu=38;2;122;122;122:vi=38;2;122;122;122:mp=38;2;122;122;122'

alias ls="eza -F --group-directories-first"
alias ll="ls -lah --git --no-user --no-time"
alias llt="ls -lah --total-size --git --no-user --time=created --time-style=long-iso"
alias la="ls -a"
alias l1="ls -1a"
alias tree='eza -F --tree --group-directories-first'

#---- ZOXIDE / CD ---- ##############################################
eval "$(zoxide init zsh)"
alias ..="cd .."
alias ,,="cd -"

#---- TMUX ---- ##############################################
alias tlist='tmux list-sessions'
alias tname='tmux rename-session -t'
alias tjoin='tmux attach-session -t'
alias tswap='tmux switch-client -t'
alias tkill='tmux kill-session -t'
alias tkillall='killall tmux'
alias tsync="tmux source ~/.config/tmux/tmux.conf"

#---- GPG ---- ##############################################
export GNUPGHOME="$HOME/.config/gnupg"
export GPG_TTY=$(tty)
mkdir -p $GNUPGHOME

#---- PACKAGE MANAGER / BREW / XBPS / PACMAN / APT ---- ###########################################
osname=$(uname)

_xu_linux(){
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
}

if [[ "$osname" == 'Linux' ]]; then
    alias xi="sudo apt-get install"
    alias xs="sudo apt-cache search"
    alias xr="sudo apt-get remove"
    alias xq="sudo apt-cache show"
    alias xu="_xu_linux"
    alias docker="sudo docker"
    export COPYER="xclip -in -selection clipboard"
    alias copy="xclip -in -selection clipboard"
else
    alias xi="brew install"                # I - install
    alias xs="brew search"                 # S - search
    alias xu="brew update && brew upgrade" # U - update
    alias xr="brew uninstall"              # R - remove
    alias xq="brew info"                   # R - query info 
    export COPYER=$(which pbcopy)
    alias copy=pbcopy
fi

#---- TASK RUNNER
task_runner(){
  if [[ -f "./Build.zig" ]];then
    zig build $@
    return 0
  fi

  if [[ -f "./Makefile" ]];then
    make $@
    return 0
  fi

  if [[ -f "./package.json" ]];then
    npm run $@
    return 0
  fi

  echo ERROR: no project config file found
  return 1
}

#---- TEST RUNNER
test_runner(){
  if [ -e Build.zig ];then
    zig test
    return 0
  fi

  if [[ -e Cargo.toml ]];then 
    cargo test $@
    return 0
  fi

  if [ -e package.json ];then 
    npm run test -- $@
    return 0
  fi

  echo ERROR: no project config file found
  return 1
}

#---- TRASH ---- ##############################################
trash(){
  if [[ -d $TRASH_DIR ]]; then
    for f in "$@"; do
      name=$(basename "$f")
      if [[ -d "$f" ]];then
        source_path=$(readlink -f $f)
        date=$(date +'%Y%m%d%H%M%S')
        output_path="$TRASH_DIR/${date}_${RANDOM}_${name}"
        mv "$f" "$output_path"
        touch "$output_path"
      else
        checksum=$(shasum "$f" | cut -d ' ' -f 1 | sed -e 's/[[:space:]]*$//')
        output_path="$TRASH_DIR/${checksum}_${name}"
        mv "$f" "$output_path"
        touch "$output_path"
      fi
    done
  else
    echo ERROR: no trash bin
    >&2 exit 1
  fi
}

trash_ls_old(){
  find $TRASH_DIR -maxdepth 1 -mtime +20
}

trash_help(){
  echo "how to delete stuff"
  echo
  echo "TRASH_DIR is an env var that points to the trash directory"
  echo
  echo "DELETEING STUFF:"
  echo "trash            - moves stuff into TRASH_DIR"
  echo "wipe             - actually delete file"
  echo "del              - sudo actually delete file"
  echo
  echo "MANAGE TRASH_DIR:"
  echo "trash_clean      - delete files older than 20 days"
  echo "trash_set_fire   - delete everything in trash dir"
  echo "trash_ls_old     - list stuff in TRASH_DIR that is 20 days old"
  echo
  echo "HELP:"
  echo "help_trash|rm    - print this help message"
}

alias rm='help_trash'

trash_clean(){
  trash_ls_old | xargs -I {} rm -rfv {}
}

trash_clean_hard(){
  del -rfv $TRASH_DIR/*
}

#---- GIT ---- ##############################################
git_branch(){
  if (( $# < 1 ));then 
    git branch -av
    return 0
  else
    git branch "$@"
  fi 
}

git_log(){
  git log --graph --pretty=format:'%C(bold blue)%h%Creset %C(cyan)[%cr] %C(magenta)%an%Creset - %Creset%s%C(yellow)%d%Creset' --abbrev-commit 
}

git_rebase(){
  git rebase -S $@
}

git_push() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot push from detached state."
      return 1
    fi
    echo "Pushing to $branch $@"
    git push origin $branch $@ --tags
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}

git_pull() {
  local branch
  if (( $# > 0 ));then 
    echo "Pulling from $@"
    git pull origin $@ -v
    return 0
  fi 
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot pull from detached state."
      return 1
    fi 
    echo "Pulling from $branch"
    git pull origin $branch -v
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}

git_push_upstream() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot push from detached state."
      return 1
    fi 
    echo "Pushing to $branch $@" 
    git push upstream $branch $@ -v --tags
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}

git_pull_upstream() {
  local branch
  if (( $# > 0 ));then 
    echo "Pulling from $@"
    git pull upstream $@ -v
    return 0
  fi
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot pull from detached state."
      return 1
    fi 
    echo "Pulling from $branch"
    git pull upstream $branch -v
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}

git_commit(){
  git commit -S "$@" && git verify-commit HEAD
}

git_commit_message(){
  git_commit -m "$(echo $@)"
}

git_tag(){
  if (( $# < 1 ));then 
    return 1
  elif (( $# > 1 ));then 
    git tag -a -s $@
    return 0
  else
    git tag -s -a $@ && git verify-tag $1
    return 0
  fi 
}

git_tag_delete(){
  git tag -d $1
  git push origin :refs/tags/$1
}

export COLOR_RESET=$'\x1b[0m'
export COLOR_LACK=$'\x1b[38;2;112;128;144m'
export COLOR_LUSTER=$'\x1b[38;2;222;238;237m'
export COLOR_ORANGE=$'\x1b[38;2;255;170;136m'
export COLOR_GREEN=$'\x1b[38;2;120;153;120m'
export COLOR_BLUE=$'\x1b[38;2;119;136;170m'
export COLOR_RED=$'\x1b[38;2;215;0;0m'
export COLOR_BLACK=$'\x1b[38;2;0;0;0m'
export COLOR_GRAY1=$'\x1b[38;2;8;8;8m'
export COLOR_GRAY2=$'\x1b[38;2;25;25;25m'
export COLOR_GRAY3=$'\x1b[38;2;42;42;42m'
export COLOR_GRAY4=$'\x1b[38;2;68;68;68m'
export COLOR_GRAY5=$'\x1b[38;2;85;85;85m'
export COLOR_GRAY6=$'\x1b[38;2;122;122;122m'
export COLOR_GRAY7=$'\x1b[38;2;170;170;170m'
export COLOR_GRAY8=$'\x1b[38;2;204;204;204m'
export COLOR_GRAY9=$'\x1b[38;2;221;221;221m'

#---- PROMPT ---- ##############################################
reset_ll_prompt(){
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      LL_BRANCH_NAME='(detached)'
     else 
      LL_BRANCH_NAME="[$branch]"
    fi
  else 
    LL_BRANCH_NAME=''
  fi

  git_status_result=$(git status --porcelain 2> /dev/null)
  if [[ "$git_status_result" != "" ]]; then
     # branch is dirty
     LL_BRANCH_COLOR=$COLOR_ORANGE
  else
     # branch is clean
     LL_BRANCH_COLOR=$COLOR_GRAY6
  fi

  LL_PWD=${PWD/$HOME/}
  if [[ $LL_PWD = "" ]];then
      LL_PWD="~"
  fi

  LL_PROMPT=$'\n'"| "
  return 0
}

setopt prompt_subst
autoload -U add-zsh-hook 
add-zsh-hook precmd reset_ll_prompt

PROMPT='%{$LL_BRANCH_COLOR%}${LL_BRANCH_NAME} %{$COLOR_GRAY5%}${LL_PWD}%{$COLOR_RESET%}${LL_PROMPT}'

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/N}/(main|viins)/ I}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

#---- ZSH KEY REMAP ---- ##############################################
bindkey -v                           # enable vim mode
bindkey "^W" backward-kill-word      # ctl-w delete word backward insert mode
bindkey -a "^W" backward-kill-word   # ctl-w delete word backward normal mode
bindkey "^?" backward-delete-char    # delete key to work like normal
bindkey "^U" backward-kill-line      # ctl-u delete cur line insert mode
bindkey -a "^U" backward-kill-line   # ctl-u delete cur line normal mode
bindkey '^a' vi-beginning-of-line    # ctl a jumps to beginning of line insert mode
bindkey -a '^a' vi-beginning-of-line # ctl a jumps to beginning of line normal mode

bindkey -a '^g' vi-end-of-line       # cta s jumps to end of line normal mode
bindkey '^r' history-incremental-pattern-search-backward

bindkey -a 'n' down-line-or-history
bindkey -a 'e' up-line-or-history
bindkey -a 'y' vi-backward-char
bindkey -a 'o' vi-forward-char
bindkey -a 'Y' vi-beginning-of-line  # shift y jumps to beginning of lin in normal mode
bindkey -a 'O' vi-end-of-line        # shift o jumps to end of line in normal mode

bindkey -a 't' vi-find-next-char
bindkey -a 'T' vi-find-prev-char

bindkey -a "h" vi-repeat-find
bindkey -a 'H' vi-rev-repeat-find

bindkey -a 'f' vi-repeat-search
bindkey -a 'F' vi-rev-repeat-search

bindkey -a 'k' vi-yank
bindkey -a 'K' vi-yank-whole-line

bindkey -a 'w' vi-forward-word
bindkey -a 'W' vi-backward-word

bindkey -a 'E' vi-forward-word-end
bindkey -a 'J' vi-forward-blank-word-end
bindkey -a 'l' vi-open-line-below
bindkey -a 'L' vi-open-line-above

# C-x C-e edit this command in vim 
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-t\C-t' edit-command-line


# [Shift - Tab] move through the completion menu backwards :)
if [[ "${terminfo[kcbt]}" != "" ]]; then
	bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi
#---- SCREEN CAPTURE, SC ---- ##############################################
# defaults write com.apple.screencapture location $HOME/_data/_inbox
# sc all screen

sc_test(){
  if [[ -z $1 ]]; then
    echo_red "ERROR: name required"
    echo "    $ sc <name>"
    return 1
  fi
}

sc_name(){
  SC_DATE=$(date +"%Y-%m-%d-%H%M%S")
  SC_NAME="$1"
  SC_EXT="$2"
  echo "$HOME/_data/_inbox/$SC_DATE-$SC_NAME.$SC_EXT"
}

sca(){
  if sc_test "$1"; then
    SC_NAME=$(sc_name "$1" "png")
    screencapture -t png "$SC_NAME"
    echo_blue "[SCREEN CAPTURE] $SC_NAME"
  fi
}

# sc select
scs(){
  if sc_test "$1"; then
    SC_NAME=$(sc_name "$1" "png")
    screencapture -t png -i -J selection "$SC_NAME"
    if [[ -e $SC_NAME ]];then
      echo_blue "[SCREEN CAPTURE] $SC_NAME"
    else
      echo_red "ABORTED"
    fi
  fi
}

# sc window
scw(){
  if sc_test "$1"; then
    SC_NAME=$(sc_name "$1" "png")
    screencapture -t png -i -W "$SC_NAME"
    if [[ -e $SC_NAME ]];then
      echo_blue "[SCREEN CAPTURE] $SC_NAME"
    else
      echo_red "ABORTED"
    fi
  fi
}

# sc select to clipboard
scc(){
  screencapture -c -t png -i -J selection
  echo_blue "[SCREEN CAPTURE] copied to clipboard"
}

#---- SHORTHAND ---- ##############################################
alias bubye='sudo shutdown -h now'
alias reboot='sudo reboot'
alias del='sudo rm'
alias wipe='/bin/rm'
path(){
  echo $PATH | tr ':' '\n'
}

alias edit_alacritty="nvim ~/.config/alacritty/alacritty.yml"
alias edit_git="nvim ~/.config/git/git.yml"
alias edit_nvim="nvim ~/.config/nvim/init.lua"
alias edit_tmux="nvim ~/.config/tmux/tmux.conf"
alias edit_zsh="nvim ~/.config/zsh/.zshrc"


alias a="git add"
alias A="git add ."
alias b="git branch"
alias ba="git_branch"
alias c="git_commit"
alias C="git_commit --amend --no-edit"
alias ch="git checkout"
alias cn="git_commit --no-verify"
alias cp='cp -r'
alias d="git diff"
alias D="git diff HEAD~1"
alias e="nvim"
alias E="nvim -u $HOME/.vimrc"
alias ed='e $(find . -name "*.*" | grep "./" | grep -v node_modules)'
alias f="git fetch -pv"
alias g="echo naw"
alias h="echo nam"
alias i="echo naw"
alias j="e -c ':lua require(\"unruly-worker\").boost.telescope.find_files()'"
alias J="e -c ':lua require(\"unruly-worker\").boost.telescope.live_grep()'"
alias k="echo naw"
alias l="git_pull"
alias lu="git_pull_upstream"
alias L="git_log"
alias m="task_runner" 
alias md="mkdir -p"
alias n="z"
alias N="zi"
alias o="echo naw"
alias p="git_push"
alias pu="git_push_upstream"
alias q="echo naw"
alias r="git_rebase"
alias ri="git_rebase -i"
alias R="source ~/.config/zsh/.zshrc"
alias s="git status"
alias t="test_runner"
alias T="cd $TRASH_DIR"
alias u="echo naw"
alias v="echo naw"
alias w="e -c ':WhipOpen'"
alias W="e -c ':WhipFindFile'"
alias x="git reset"
alias y="echo naw"
# z is set by zoxide
alias Z="nvim $HOME/.config/zsh/.zshrc"

CF(){
    git add .
    git_commit -m "$(fortune -s -n 50)"
}

# man() {
#   LESS_TERMCAP_md=$'\e[01;31m' \
#   LESS_TERMCAP_me=$'\e[0m' \
#   LESS_TERMCAP_us=$'\e[01;32m' \
#   LESS_TERMCAP_ue=$'\e[0m' \
#   LESS_TERMCAP_so=$'\e[45;93m' \
#   LESS_TERMCAP_se=$'\e[0m' \
#   command man "$@"
# }

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# pnpm
export PNPM_HOME="/Users/slugbyte/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
