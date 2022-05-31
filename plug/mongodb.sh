mongod(){
   sudo docker kill mongodb &> /dev/null
   sudo docker rm mongodb &> /dev/null
   sudo docker run --network bridge -v $w/dump/mongodb:/data/db -p 27017:27017 --name mongodb \
  -e MONGO_INITDB_ROOT_USERNAME=$MONGO_INITDB_ROOT_USERNAME \
  -e MONGO_INITDB_ROOT_PASSWORD=$MONGO_INITDB_ROOT_PASSWORD \
  -dt mongo
}

mongo(){
  local name IP_LOCAL
  name="mongo_$RANDOM"
  IP_LOCAL=$(python3 -c "import socket; print([l for l in ([ip for ip in socket.gethostbyname_ex(socket.gethostname())[2] if not ip.startswith(\"127.\")][:1], [[(s.connect((\"8.8.8.8\", 53)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1]]) if l][0][0])")
  sudo docker run --name $name -it mongo /usr/bin/mongo \
    --host $IP_LOCAL \
    -u "$MONGO_INITDB_ROOT_USERNAME" \
    -p "$MONGO_INITDB_ROOT_PASSWORD"
  sudo docker rm $name
}

mongolog(){
  sudo docker logs -f mongodb
}
