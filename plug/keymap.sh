#!/usr/bin/env bash
alias a="git add"
alias A="git add ."
alias b="git branch"
alias ba="git_branch"
alias bubye='sudo shutdown -h now'
alias c="git_commit"
alias C="git_commit --amend --no-edit"
alias ch="git checkout"
alias cn="git_commit --no-verify"
alias cp='cp -r'
alias d="sudo docker"
alias e="edit.sh"
alias E="nvim -u $HOME/.vimrc"
alias ed='e $(find . -name "*.*" | grep "./" | grep -v node_modules)'
alias f="git fetch -pv"
alias g="echo naw"
# h is allready used by commacd.sh
alias i="ip_address"
alias j="e -c ':Telescope find_files'"
alias J="e -c ':Telescope live_grep'"
alias k="echo naw"
alias l="git_pull"
alias L="git_log"
alias lu="git_pull_upstream"

task_runner(){
  if [[ -f "./package.json" ]];then
    npm run $@
  else
    make $@
  fi
}

alias m="task_runner"
alias md="mkdir -p"
# n is allready used in n.sh
alias nd='echo naw'
alias o="lfcd"
alias p="git_push"
alias pu="git_push_upstream"
alias q="echo naw"
alias r="git_rebase"
alias ri="git_rebase -i"
alias R="source ~/.config/zsh/.zshrc"
alias s="git status"
alias t="tmux"
alias u="git_update"
alias v="echo naw"
alias w="cd $w"
alias x="git reset"
alias y="echo naw"
alias z="echo naw" 

alias pom='npm run pompom'
