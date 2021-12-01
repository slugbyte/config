redis(){
  REDISCLI_AUTH=$REDIS_PASSWORD redis-cli --user $REDIS_USER
}
