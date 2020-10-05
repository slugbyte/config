# Alias
# warning
# alias vim='echo dude, use e!'
#alias cd='echo dude, use j!'

# ------ NAV AND FS
alias ls="exa -F --group-directories-first $ls_flag"
alias ll="ls -lah"
alias la="ls -a"
alias l1="ls -1a"
alias ..="cd .."

#alias liquid='java -jar $MOLD_ROOT/exec/liq.jar'

# ------ UTIL
alias md="mkdir -p"
alias cp='cp -r'
alias rimraf="rm -rf"
#alias less='less -r'
alias todo='eureka'
alias vbox='/Applications/VirtualBox.app/Contents/Resources/VirtualBoxVM.app/Contents/MacOS/VBoxManage' 
alias gencerts='openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes'
alias wifi='osx-wifi-cli'

alias tree='tree -I "node_modules|target"'

alias xs="sudo xbps-query -Rs"
alias xi="sudo xbps-install -y"
alias xr="sudo xbps-remove -R"
alias xu="sudo xbps-install -Syu"

alias copy='xclip -selection c'
alias paste='xclip -selection c -o'

alias bubye='sudo shutdown -h now'
