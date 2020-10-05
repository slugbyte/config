# SHORTHAND
alias pt="git push --tag"
alias chd='git checkout development'
alias chs='git checkout staging'
alias chp='git checkout production'
alias chm='git checkout master'
alias stash="git stash -u"
alias unstash="git stash pop"
alias clone="git clone --recursive"
alias subu="git submodule update"
alias acp="A && c && p"
# ACP at bottom 
suba(){
  git submodule add $@
}

git_log(){
  git log --graph --pretty=format:'%C(bold blue)%h%Creset %C(cyan)[%cr] %C(magenta)%an%Creset - %Creset%s%C(yellow)%d%Creset' --abbrev-commit
}

# push to current branch with args
# TODO: refacotr git_push and git_push_upstream to use a helper fn
git_push() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot push from detached state."
      return 1
    fi 
    echo "Pushing to $branch $@" 
    git push origin $branch $@ -v
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}

# pull from arg or current branch
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

git_branch(){
  if (( $# < 1 ));then 
    git branch -av
    return 0
  else
    git branch "$@"
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
    git push upstream $branch $@ -v
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}

# pull from arg or current branch
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

# a c-m p
ACP(){
  git add .
  git_commit_message $@
  git_push
}
