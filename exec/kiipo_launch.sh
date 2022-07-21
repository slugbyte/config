#!/usr/bin/env zsh

## SETUP ENV
LOG_DIR="$HOME/workspace/tail"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/kiipo_launch.log.txt"

alias pullhead='git pull origin $(git rev-parse --abbrev-ref HEAD)'

pm2() {
  /home/slugbyte/.config/nvm/versions/node/v16.16.0/bin/pm2 $@ |tee -a "$LOG_FILE"
}

write(){
  echo $@ >>&! $LOG_FILE
}

## HELPER FUNCTIONS
log(){
  write ""
  write "[$1] $2"

  echo ""
  echo "$(tput setaf 141)[$1]$(tput setaf 105) $2$(tput sgr 0)"  
}

err(){
  write ""
  write "($1) $2" 

  echo
  echo "$(tput setaf 141)[$1]$(tput setaf 105) $2$(tput sgr 0)"  
}

update_project(){
  pwd
  log "GIT PULL" "$1"
  pullhead | tee -a "$LOG_FILE" || {
    err "ERROR" "failled to git pull ($1)"
    exit 1
  }

  log "NPM INSTALL" "$1"
  npm i --force | tee -a "$LOG_FILE" || {
    err "ERROR" "failled to npm install ($1)"
    exit 1
  }
}

goto() {
  cd "$1" || {
    err "GOTO ERROR" "unable to cd to $1"
    exit 1
  }
}

## MAIN
/bin/rm $LOG_FILE

log "START" "launching and restarting all kiipo demons"
log "DATE" "$(date)"

## KILLALL KIIPOO DAEMONS
log "RESET" "stoping all running kiipo daemons"
pm2 kill --force || true

## ADMIN PORTAL BACKEND
goto "/opt/legacy/labfront_admin_portal_backend"
update_project "ADMIN PORTAL BACKEND"
log "LAUNCHING" "ADMIN PORTAL BACKEND"
pm2 start "bin/www" \
  --name labfront_admin_portal_backend \
  -o "$LOG_DIR/labfront_admin_portal_backend.stdout.txt" \
  -e "$LOG_DIR/labfront_admin_portal_backend.stderr.txt" \
  --force

## ADMIN PORTAL FRONTEND
goto "/opt/legacy/labfront_admin_portal_frontend"
update_project "ADMIN PORTAL FRONTEND"
log "LAUNCHING" "ADMIN PORTAL FRONTEND"
pm2 start "bin/serve.js" \
  --name labfront_admin_portal_frontend \
  -o "$LOG_DIR/labfront_admin_portal_frontend.stdout.txt" \
  -e "$LOG_DIR/labfront_admin_portal_frontend.stderr.txt" \
  --force
