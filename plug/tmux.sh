alias tlist='tmux list-sessions'
alias tname='tmux rename-session -t'
alias tjoin='tmux attach-session -t'
alias tswap='tmux switch-client -t'
alias tkill='tmux kill-session -t'

tmain(){
  tmux rename-session -t "$1" main
  tmux rename-window -t main:0 edit
}

talt(){
  tmux rename-session -t "$1" alt
  tmux rename-window -t alt:0 test
}

tdouble(){
  tmain 0
  talt 1
}
