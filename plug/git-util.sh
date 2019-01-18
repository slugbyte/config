# Git Helper Aliases and Functions
alias g='git'
alias a="git add"
alias A="git add ."
alias s="git status"
alias x="git commit"
alias c='git add . && git commit'
alias C="git add . && git commit -m"
alias tag='git tag' 
alias ch="git checkout"
alias b="git branch -avv"
alias B='git branch'

# TODO make "p" and "l" default to the current branch 
# but also accect an arg for specifying the branch
alias p="git push origin HEAD"
alias l="git pull origin"
