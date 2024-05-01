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
export SCRATCHPAD_PATH="$HOME/scratchpad.md"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=$(which nvim)
export COPYER=$(which pbcopy)
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

#-ENV WHOAMI
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'

#-ENV RUST
export PATH="$HOME/.cargo/bin:$PATH"
#
#-ENV GO
export PATH="$HOME/go/bin:$PATH"

#-ENV personal dirs dirs
export PATH="$HOME/workspace/exec:$PATH"
export TRASH_DIR="$HOME/.Trash"
export trash="$TRASH_DIR"
export w="$HOME/workspace"
export hist="$w/hist"
export code="$w/code"
export conf="$w/conf"
export data="$w/data"
export exec="$w/exec"
export hide="$w/hide"
export play="$w/play"
export lang="$w/lang"
export temp="$HOME/Downloads"
export work="$w/work"

#-ENV ZIG
export ZIG_DIR="$w/lang/zig"
export PATH="$ZIG_DIR:$PATH"
export PATH="$w/lang/zls/zig-out/bin:$PATH"

#-ENV ZSH
export ZDOTDIR="$HOME/.config/zsh"

#-ENV FZF / RG
export FZF_DEFAULT_COMMAND='rg --files --hidden'


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


#---- EXA ---- ##############################################
exa_fg(){
  echo "38;5;$1"
}

exa_make_color_group(){
  local result
  for item in "${@:2}"; do
    result+=":${item}=$(exa_fg $1)"
  done
  echo $result
}

exa_permisions=$(exa_make_color_group 137 ur uw ux ue gr gw gx tr tw tx)
special_files=$(exa_make_color_group 204 ".git*" .bashrc "*.test.js" .env .vimrc Makefile README.md)
export EXA_COLORS="di=$(exa_fg 111):ln=$(exa_fg 167):so=32:pi=33:ex=$(exa_fg 36):bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:da=$(exa_fg 58):uu=$(exa_fg 59):sn=$(exa_fg 111):sb=$(exa_fg 96):${exa_permisions}${special_files}"

alias ls="exa -F --group-directories-first $ls_flag"
alias ll="ls -lah"
alias la="ls -a"
alias l1="ls -1a"
alias tree='exa --tree --group-directories-first'

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
alias xi="brew install"                # I - install
alias xs="brew search"                 # S - search
alias xu="brew update && brew upgrade" # U - update
alias xr="brew uninstall"              # R - remove
alias xq="brew info"                   # R - query info 

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



#---- PROMPT ---- ##############################################
PROMPT_COLOR_DIR="$(tput setaf 95 2>/dev/null || echo '')"  
PROMPT_COLOR_GIT_BRANCH="$(tput setaf 102 2>/dev/null || echo '')"  
PROMPT_COLOR_GIT_DETACHED="$(tput setaf 214 2>/dev/null || echo '')"  
PROMPT_COLOR_GIT_DIRTY="$(tput setaf 111 2>/dev/null || echo '')"  
PROMPT_COLOR_RESET="$(tput sgr 0 2>/dev/null || echo '\e[0m')" 

prompt_set_git_remote(){
  PROMPT_GIT_REMOTE=$(git remote -v 2> /dev/null |grep origin |cut -d : -f 2 | cut -d ' ' -f 1 | cut -d '.' -f 1 | uniq) 
  return 0
}

prompt_set_git_branch() {
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      PROMPT_GIT_DETACHED='(detached)'
      PROMPT_GIT_BRANCH=''
     else 
      PROMPT_GIT_BRANCH="[$branch]"
      PROMPT_GIT_DETACHED=''
    fi
  else
    PROMPT_GIT_BRANCH=''
  fi
  return 0
}

prompt_set_get_dirty() {
  git_status_result=$(git status --porcelain 2> /dev/null)
  if [[ "$git_status_result" != "" ]]; then
    GIT_DIRTY='x'
  else
    GIT_DIRTY=''
  fi
  return 0
}

reset_prompt_vars(){
  prompt_set_get_dirty
  prompt_set_git_branch
  prompt_set_git_remote
  CURRENT_DIR_NAME=$(basename $PWD)
}

setopt prompt_subst
autoload -U add-zsh-hook 
add-zsh-hook precmd reset_prompt_vars

PROMPT=''
PROMPT+='%{$PROMPT_COLOR_GIT_BRANCH%}$PWD'
PROMPT+=$'\n'
PROMPT+='%{$PROMPT_COLOR_DIR%}$(basename $PWD) '
PROMPT+='%{$PROMPT_COLOR_GIT_BRANCH%}${PROMPT_GIT_BRANCH}'
PROMPT+='%{$PROMPT_COLOR_GIT_DETACHED%}${PROMPT_GIT_DETACHED}${GIT_DIRTY}'
PROMPT+='%{$PROMPT_COLOR_DIR%} ${PROMPT_GIT_REMOTE}'
PROMPT+='%{$PROMPT_COLOR_RESET%}'
PROMPT+=$'\n'"✿ "

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
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

#---- GO3 IMPORT ---- ##############################################
GOGOGO_SOURCE="/Volumes/gogogo/DCIM/Camera01"
GOGOGO_FLAG_COMPLETE_PATH="$GOGOGO_SOURCE/boing-ding.txt"

cam_gogogo_import(){
  GOGOGO_DATE=$(date +"%Y-%m-%d")
  GOGOGO_DEST="$HOME/_catalog/catalog_image/$GOGOGO_DATE-$1"

  if [[ -e $GOGOGO_FLAG_COMPLETE_PATH ]];then
    echo_red "ERROR: import is allready complete"
    echo "    if you really want to import again,"
    echo "    remove $GOGOGO_FLAG_COMPLETE_PATH"
    echo "    and then try again"
    return 1
  fi

  if [[ -z $1 ]]; then
    echo_red "ERROR: name required"
    echo "    $ cam_gogogo_import <folder-name>"
    return 1
  fi

  if [[ ! -e "$GOGOGO_SOURCE" ]];then
    echo_red "ERROR: gogogo camera data not found"
    return 1
  fi

  GOGOGO_FILEPATH_LIST=$(rg --files "$GOGOGO_SOURCE" | rg -v "Thumb")
  GOGOGO_FILE_COUNT=$(rg --files "$GOGOGO_SOURCE" | rg -v "Thumb" | wc -l | xargs)
  GOGOGO_COPY_COUNT=1

  # TODO print each file sizz
  # TODO find a way to make it faster (parrallel?)
  # TODO elapsed time
  # TODO capture elapsed time and time per file in a file so in the future estimations
  # can be given
  # TODO find a way to test the USB connection :)
  echo "[CAM GOGOGO IMPORT] START"
  echo "[CAM GOGOGO IMPORT] FETCHING METDATA"
  echo "[CAM GOGOGO IMPORT] SIZE: $(du -d 0 -h  $GOGOGO_SOURCE | cut -d "/" -f 1)"
  echo "[CAM GOGOGO IMPORT] FILE COUNT: $GOGOGO_FILE_COUNT"

  mkdir -p $GOGOGO_DEST
  for SOURCE_FILE_PATH in $(rg --files "$GOGOGO_SOURCE" | rg -v "Thumb"); do
    FILE_NAME=$(basename $SOURCE_FILE_PATH)
    FILE_SIZE=$(du -h -d 0 $SOURCE_FILE_PATH | xargs)
    DEST_FILE_PATH="$GOGOGO_DEST/$FILE_NAME"

    echo "$GOGOGO_COPY_COUNT/$GOGOGO_FILE_COUNT $FILE_SIZE $FILE_NAME"
    cp "$SOURCE_FILE_PATH" "$DEST_FILE_PATH"
    GOGOGO_COPY_COUNT=$(( $GOGOGO_COPY_COUNT+1 ))
  done
  echo "$GOGOGO_DEST\nLUCKY_NUMBER: $RANDOM" > "$GOGOGO_FLAG_COMPLETE_PATH"

  echo_blue "[CAM GOGOGO IMPORT COMPLETE] $GOGOGO_DEST"
}

cam_gogogo_clean(){
  if [[ ! -e $GOGOGO_FLAG_COMPLETE_PATH ]];then
    echo_red "ABORT: gogogo has not yet been imported!"
    echo_red "    import first, or use finder to manual clean."
    return 1
  fi

  echo boooyeee
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

alias copy=pbcopy

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
alias w="cd $w"
alias x="git reset"
alias y="echo naw"
# z is set by zoxide
alias Z="nvim $HOME/.config/zsh/.zshrc"

# man() {
#   LESS_TERMCAP_md=$'\e[01;31m' \
#   LESS_TERMCAP_me=$'\e[0m' \
#   LESS_TERMCAP_us=$'\e[01;32m' \
#   LESS_TERMCAP_ue=$'\e[0m' \
#   LESS_TERMCAP_so=$'\e[45;93m' \
#   LESS_TERMCAP_se=$'\e[0m' \
#   command man "$@"
# }
