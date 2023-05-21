alias copy='xclip -selection c'
alias paste='xclip -selection c -o'

copycat(){
  cat $@ | copy
}
