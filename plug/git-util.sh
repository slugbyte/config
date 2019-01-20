git_push() {
  local branch
  if (( $# > 0 ));then 
    echo "Pushing to $@"
    git push origin $@
    return 0
  fi 
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
    echo "Pushing to $branch"
    git push origin $branch
    return 0
  else
    print "Error: Cannot push from detached state."
    return 1
  fi
}

git_pull() {
  local branch
  if (( $# > 0 ));then 
    echo "Pulling from $@"
    git pull origin $@
    return 0
  fi 
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
    echo "Pulling from $branch"
    git pull origin $branch
    return 0
  else
    print "Error: Cannot pull a detached state."
    return 1
  fi
}
