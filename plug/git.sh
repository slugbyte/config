alias stash="git stash -u"
alias unstash="git stash pop"
alias clone="git clone --recursive"


alias subu="git submodule update"

# add submodule
suba(){
  git submodule add $@
  git submodule init
}

# pretty log
# push to current branch with args
git_push() {
  local branch
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
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
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
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
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
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
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
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

