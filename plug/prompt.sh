# Prompt Colors
color_user="$(tput setaf 130 2>/dev/null || echo '')"  
color_dir="$(tput setaf 95 2>/dev/null || echo '')"  
color_git_branch="$(tput setaf 102 2>/dev/null || echo '')"  
color_git_detached="$(tput setaf 214 2>/dev/null || echo '')"  
color_git_dirty="$(tput setaf 111 2>/dev/null || echo '')"  
color_reset="$(tput sgr 0 2>/dev/null || echo '\e[0m')" 

# Prompt Git Helpers
find_git_remote(){
  GIT_REMOTE=$(git remote -v 2> /dev/null |grep origin |cut -d : -f 2 | cut -d ' ' -f 1 | cut -d '.' -f 1 | uniq) 
  return 0
}

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      GIT_DETACHED='(detached)'
      GIT_BRANCH=''
     else 
      GIT_BRANCH="[$branch]"
      GIT_DETACHED=''
    fi
  else
    GIT_BRANCH=''
  fi
  return 0
}

find_git_dirty() {
  git_status_result=$(git status --porcelain 2> /dev/null)
  if [[ "$git_status_result" != "" ]]; then
    GIT_DIRTY='x'
  else
    GIT_DIRTY=''
  fi
  return 0
}

reset_prompt_vars(){
  find_git_dirty
  find_git_branch
  find_git_remote
  CURRENT_DIR_NAME=$(basename $PWD)
}

setopt prompt_subst
autoload -U add-zsh-hook 
add-zsh-hook precmd reset_prompt_vars

PROMPT=''
PROMPT+='%{$color_git_branch%}$PWD'
PROMPT+=$'\n'
PROMPT+='%{$color_dir%}$(basename $PWD) '
PROMPT+='%{$color_git_branch%}${GIT_BRANCH}'
PROMPT+='%{$color_git_detached%}${GIT_DETACHED}${GIT_DIRTY}'
PROMPT+='%{$color_dir%} ${GIT_REMOTE}'
PROMPT+='%{$color_reset%}'
PROMPT+=$'\n'"✿ "

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
