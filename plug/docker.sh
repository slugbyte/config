dokill(){
  docker kill $(docker ps -q)
  echo "killed all containers "
}

dorm(){
  docker rm $(docker ps -a -q)
  echo "removed all containers"
}

donuke(){
  dokill
  dorm
}

alias dock="docker"
alias doru="dock run"
alias dori="doru -it"
alias dorsh="dori --entrypoint sh"
alias dorvosh="dorsh -v $(pwd):/mnt"
alias dob="dock build"
alias dops="dock ps -a"

alias deri="docker exec -it"

dersh(){
  docker exec -it $1 sh
}
