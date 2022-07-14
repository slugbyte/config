#!/usr/bin/env bash

## SETUP ENV
LOG_DIR="$HOME/workspace/tail"
mkdir -p "$LOG_DIR"

alias pm2='/home/slugbyte/.config/nvm/versions/node/v16.16.0/bin/pm2'

## HELPER FUNCTIONS
log(){
  echo
  echo "$(tput setaf 141)[$1]$(tput setaf 105) $2$(tput sgr 0)"
}

err(){
  echo
  echo "$(tput setaf 1)[$1]$(tput setaf 209) $2$(tput sgr 0)"
}

update_project(){
  log "GIT PULL" "$1"
  git pull || {
    err "ERROR" "failled to git pull ($1)"
    exit 1
  }

  log "NPM INSTALL" "$1"
  npm i --force  || {
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
log "START" "launching and restarting all kiipo demons"

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
  -e "$LOG_DIR/labfront_admin_portal_backend.stderr.txt"

## ADMIN PORTAL FRONTEND
goto "/opt/legacy/labfront_admin_portal_frontend"
update_project "ADMIN PORTAL FRONTEND"
log "LAUNCHING" "ADMIN PORTAL FRONTEND"
pm2 start "bin/serve.js" \
  --name labfront_admin_portal_frontend \
  -o "$LOG_DIR/labfront_admin_portal_frontend.stdout.txt" \
  -e "$LOG_DIR/labfront_admin_portal_frontend.stderr.txt"
