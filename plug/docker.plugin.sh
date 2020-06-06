dockill(){
  docker kill $(docker ps -q)
}

docrm(){
  docker rm $(docker ps -a -q)
}
