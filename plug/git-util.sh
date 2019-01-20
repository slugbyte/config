# push to current branch with args
git_push() {
  local branch
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      print "Error: Cannot push from detached state."
      return 1
    fi 
    echo "Pushing to $branch $@" 
    git push origin $branch $@
    return 0
  else
    print "Error: Not a git repository"
    return 1
  fi
}

# pull from arg or current branch
git_pull() {
  local branch
  if (( $# > 0 ));then 
    echo "Pulling from $@"
    git pull origin $@
    return 0
  fi 
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      print "Error: Cannot push from detached state."
      return 1
    fi 
    echo "Pulling from $branch"
    git pull origin $branch
    return 0
  else
    print "Error: Not a git repository"
    return 1
  fi
}

git_commit(){
  if (( $# > 0 ));then 
    echo "Pulling from $@"
    git commit -m $@
    return 0
  fi 
  git commit
}
