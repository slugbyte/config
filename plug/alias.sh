# Alias

# ------ NAV AND FS
if [[ $(uname -s) = 'Darwin' ]];then
  ls_flag='-G'
  export LSCOLORS=gxfxcxdxcxegedabagacad
else 
  ls_flag='--color=auto --group-directories-first'
  export LS_COLORS='di=32:ln=35:so=36:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi 

alias ls="ls -F $ls_flag"
alias ll="ls -lah"
alias la="ls -a"
alias l1="ls -1a"
alias ..="$(which cd) .."

# ------ UTIL
alias py='python3'
alias pe='pipenv'
alias md="mkdir -p"
alias rimraf="rm -rf"
alias less='less -r'
alias vim='echo use e'
alias poff='deactivate'
alias pon='pipenv shell'
alias todo='e ~/workspace/TODO.md'
alias vbox='/Applications/VirtualBox.app/Contents/Resources/VirtualBoxVM.app/Contents/MacOS/VBoxManage' 
alias gencerts='openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes'
