alias dock='sudo docker'

dkill(){
  dock kill $(dock ps -q)
  echo "killed all containers "
}

drm(){
  dock rm $(dock ps -a -q)
  echo "removed all containers"
}

dclean (){
  echo "docker cleanup"
  dkill
  drm
}

alias drun="dock run"
alias druni="doru -it"
alias drunsh="dori --entrypoint sh"
alias dbuild="dock build"
alias dpsa="dock ps -a"

alias deri="docker exec -it"

dexecsh(){
  docker exec -it $1 sh
}
