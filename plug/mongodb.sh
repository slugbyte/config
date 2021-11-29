mongod(){
   sudo docker run --network bridge -v $w/dump/mongodb:/data/db -p 27017:27017 --name mongodb \
  -e MONGO_INITDB_ROOT_USERNAME=$MONGO_INITDB_ROOT_USERNAME \
  -e MONGO_INITDB_ROOT_PASSWORD=$MONGO_INITDB_ROOT_PASSWORD \
  -dt mongo
}

mongo(){
  local name
  name="mongo_$RANDOM"
  sudo docker run --name $name -it mongo /usr/bin/mongo \
    --host 192.168.50.106 \
    -u $MONGO_INITDB_ROOT_USERNAME \
    -p $MONGO_INITDB_ROOT_PASSWORD
  sudo docker rm $name
}

mongolog(){
  sudo docker logs -f mongodb
}
