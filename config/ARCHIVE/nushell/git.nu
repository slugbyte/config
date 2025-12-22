def _git_is_repo [] {
  git status out+err> /dev/null
  $env.LAST_EXIT_CODE == 0
}

def _git_branch_name_get [] {
  git rev-parse --abbrev-ref HEAD err> /dev/null | str trim
}

def git_push [] {
  echo "pushing"
  if (_git_is_repo) != true {
    echo "ERROR: this is not a git repo"
    return
  }

  let branch = (git rev-parse --abbrev-ref HEAD)
  if $branch == "HEAD" {
    echo "ERROR: you need to commit before pushing"
    return
  }

  git push origin $branch
}

echo "git loaded"
