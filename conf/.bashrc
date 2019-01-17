# OPTIONS
shopt -s histappend
history -a
set globstar
set nocaseglob

# LOAD PLUGINS
export DOT_ROOT=$HOME/workspace/slug-bench/config
for plugin in $DOT_ROOT/plugin/*.plugin.sh;do
  . $plugin
done

# ENV 
export DOT="$HOME/.dot"
export GOROOT="$HOME/.go/1.9.2"
export GOPATH="$HOME/workspace/gopath"
export PAGER=$(which less)
export EDITOR=$(which vim)
export PATH="$DOT_ROOT/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.cargo/bin:$PATH"
export PS1="\u@\h \[$color_cyan\]\W \[$color_yellow\]\$git_branch\[$color_red\]\$git_dirty\[$color_reset\]\n✿ "
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'

# TODO 
if [[ $(uname -s) = 'Darwin' ]];then
  ls_color_flag='-G'
  export LSCOLORS=gxfxcxdxcxegedabagacad
else 
  ls_color_flag='--color=auto'
  export LS_COLORS='di=32:ln=35:so=36:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi 

# ALIAS
# ------ NAV AND FS
alias ls="ls -F $ls_color_flag"
alias ll="ls -lah"
alias la="ls -a"
alias l1="ls -1a"
alias ..="$(which cd) .."
alias md="mkdir -p"
alias rimraf="rm -rf"
# ------ GIT
alias g='git'
alias a="git add"
alias A="git add ."
alias s="git status"
alias x="git commit"
alias c='git add . && git commit'
alias C="git add . && git commit -m"
alias tag='git tag' 
alias ch="git checkout"
alias p="git push origin HEAD"
alias l="git pull origin"
alias b="git branch -avv"
alias B='git branch'
# ------ UTIL
alias q='exit'
alias m='make'
alias e='edit.sh'
alias py='python3'
alias pe='pipenv'
alias less='less -r'
alias r=". ~/.bashrc"
alias pon='pipenv shell'
alias poff='deactivate'
alias ip="curl ipinfo.io/ip"
alias vim='echo use e'
#alias cd='echo use j, jj, or jjj'
alias h='j $HOME'
alias t="e $HOME/workspace/TODO.md"
alias vbox='/Applications/VirtualBox.app/Contents/Resources/VirtualBoxVM.app/Contents/MacOS/VBoxManage' 
alias gencerts='openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes'

bin(){
  mv $1 $HOME/.Trash/
}

# TRAPS
handle_error(){
  local status=$?
  echo "ERROR: command[$(history | tail -n 1| sed 's/.......//')] status($status)"
}
trap handle_error ERR
