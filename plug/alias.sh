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

alias soundon="pulseaudio_set_card_profile && alsactl restore"

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

alias copy='xclip -selection c'
alias paste='xclip -selection c -o'

alias bubye='sudo shutdown -h now'

image() {
  echo "boom $PWD/$1"
	if [ -n "$DISPLAY" ]; then
		declare -p -A cmd=([action]=add [identifier]="PREVIEW" \
			[x]="$4" [y]="$5" [width]="$(($2-1))" [height]="$(($3-1))" [scaler]="contain" \
			[path]="$PWD/$1") > "$FIFO_UEBERZUG"
		return 1
	else
		chafa "$1" -s "${4}x${5}"
	fi
}
