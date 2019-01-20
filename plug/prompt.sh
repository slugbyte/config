# Prompt Colors
color_user="$(tput setaf 130 2>/dev/null || echo '')"  
color_dir="$(tput setaf 95 2>/dev/null || echo '')"  
color_git_branch="$(tput setaf 102 2>/dev/null || echo '')"  
color_git_detached="$(tput setaf 102 2>/dev/null || echo '')"  
color_git_dirty="$(tput setaf 111 2>/dev/null || echo '')"  
color_reset="$(tput sgr 0 2>/dev/null || echo '\e[0m')" 

# Prompt Git Helpers
find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch="\[$color_git_detached\](detached)"
    fi
    GIT_BRANCH="\[$color_git_branch\][$branch]"
  else
    GIT_BRANCH=""
  fi
}
find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    GIT_DIRTY="\[$color_git_dirty\]%"
  else
    GIT_DIRTY=''
  fi
}
PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"


# Prompt content
(( $UID == 0 )) && PROMPT_USER="\[$color_user\]\u "
PROMPT_DIR="\[$color_dir\]\W "
PROMPT_GIT="${GIT_BRANCH}${GIT_DIRTY}"

# Set Prompt
PS1="${PROMPT_USER}${PROMPT_DIR}${PROMPT_GIT}\[$color_reset\]\n✿ "
