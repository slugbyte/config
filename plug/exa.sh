alias ls="exa -F --group-directories-first $ls_flag"
alias ll="ls -lah"
alias la="ls -a"
alias l1="ls -1a"

exa_fg(){
  echo "38;5;$1"
}

exa_make_color_group(){
  local result
  for item in "${@:2}"; do
    result+=":${item}=$(exa_fg $1)"
  done
  echo $result
}

exa_permisions=$(exa_make_color_group 137 ur uw ux ue gr gw gx tr tw tx)
special_files=$(exa_make_color_group 204 ".git*" .bashrc "*.test.js" .env .vimrc Makefile README.md)

export EXA_COLORS="di=$(exa_fg 111):ln=$(exa_fg 167):so=32:pi=33:ex=$(exa_fg 36):bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:da=$(exa_fg 58):uu=$(exa_fg 59):sn=$(exa_fg 111):sb=$(exa_fg 96):${exa_permisions}${special_files}"

alias tree='exa --tree --group-directories-first'
