# OPTIONS
shopt -s histappend
history -a
set globstar
set nocaseglob

# PLUGINS
export DOT_ROOT=$HOME/workspace/config
for plugin in $DOT_ROOT/plugin/*.plugin.sh;do
  . $plugin
done

# ENV 
export LSCOLORS=gxfxcxdxcxegedabagacad
export GOROOT="$HOME/.go/1.9.2"
export GOPATH="$HOME/workspace/gopath"
export EDITOR=$(which nvim)
export PATH="$DOT_ROOT/bin:$GOROOT/bin:$GOPATH/bin:$PATH"
export PS1="\[$color_cyan\]\W \[$color_yellow\]\$git_branch\[$color_red\]\$git_dirty\[$color_reset\]\n✿ "

# ALIAS
alias ls="ls -GF"
alias ll="ls -lah"
alias la="ls -a"
alias l1="ls -1a"
alias r=". ~/.bashrc"
alias md="mkdir -p"
alias rimraf="rm -rf"
alias a="git add ."
alias s="git status"
alias c="git commit -m"
alias C='acp_fortune'
alias p="git push origin"
alias l="git pull origin"
alias b="git branch -a"
alias ch="git checkout"
alias vim='echo instead use: e'
alias e=edit.sh
alias ..="cd .."
alias t="e $HOME/workspace/TODO.md"

# TRAPS
handle_error(){
  local status=$?
  echo "ERROR: command[$(history | tail -n 1| sed 's/.......//')] status($status)"
}
trap handle_error ERR
