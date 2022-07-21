# SHORTHAND
alias hard="git reset --hard"
alias soft="git reset --hard"
alias stash="git stash -u"
alias unstash="git stash pop"
alias clone="git clone --recursive"
alias remote="git remote -v"


origin_set(){
  git remote remove origin 2> /dev/null
  git remote add origin $@
  git remote -v
}

tag_delete(){
  git tag -d $1
  git push origin :refs/tags/$1
}

git_rebase(){
  git rebase -S $@
}

git_update(){
  # update from arg or current branch
  local branch
  if (( $# > 0 ));then 
    echo "update from from origin/$@"
    git fetch -v
    git_rebase origin/$@ 
    return 0
  fi 
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot update from detached state."
      return 1
    fi 
    echo "update from from origin/$branch"
    git fetch -v
    git_rebase origin/$branch
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
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
    git push origin $branch $@ -v --tags
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
    git push upstream $branch $@ -v --tags
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
