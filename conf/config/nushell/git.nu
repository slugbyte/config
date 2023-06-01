if (which z | is-empty) {
  echo "ERROR: zoxide must be available before loding git.nu"
  return
}

def _git_is_repo [] {
  git status out+err> /dev/null
  $env.LAST_EXIT_CODE == 0
}

def _git_branch_name_get [] {
  git rev-parse --abbrev-ref HEAD | complete | get stdout | str trim
}

def _git_root_dir_get [] {
   git rev-parse --show-toplevel | complete | get stdout | str trim
}

def git_push [] {
  if (_git_is_repo) != true {
    echo "ERROR: this is not a git repo"
    return
  }

  let branch = (_git_branch_name_get)
  if $branch == "HEAD" {
    echo "ERROR: you need to commit before pushing"
    return
  }

  git push origin $branch
}

def git_pull [] {
  if (_git_is_repo) != true {
    echo "ERROR: this is not a git repo"
    return
  }

  let branch = (_git_branch_name_get)
  if $branch == "HEAD" {
    echo "ERROR: you need to commit before pushing"
    return
  }

  git pull origin $branch
}

def-env git_goto_root_dir [] {
   let root_dir = (_git_root_dir_get)
   z $root_dir
}

def git_commit [] {
  git commit -S
  git verify-commit HEAD
}

def git_commit_message [message: string] {
  git commit -S -m $message
  git verify-commit HEAD
}

alias git_log = git log --graph --pretty=format:'%C(bold blue)%h%Creset %C(cyan)[%cr] %C(magenta)%an%Creset - %Creset%s%C(yellow)%d%Creset' --abbrev-commit
