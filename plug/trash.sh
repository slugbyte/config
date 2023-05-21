alias del='sudo rm'
alias wipe='/usr/bin/rm'

trash_ls_old(){
  find $TRASH_DIR -maxdepth 1 -mtime +20
}

help_trash(){
  echo "how to delete stuff"
  echo
  echo "TRASH_DIR is an env var that points to the trash directory"
  echo
  echo "DELETEING STUFF:"
  echo "trash            - moves stuff into TRASH_DIR"
  echo "wipe             - actually delete file"
  echo "del              - sudo actually delete file"
  echo
  echo "MANAGE TRASH_DIR:"
  echo "trash_clean      - delete files older than 20 days"
  echo "trash_set_fire   - delete everything in trash dir"
  echo "trash_ls_old     - list stuff in TRASH_DIR that is 20 days old"
  echo
  echo "HELP:"
  echo "help_trash|rm    - print this help message"
}

alias rm='help_trash'

trash_clean(){
  trash_ls_old | xargs -I {} rm -rfv {}
}

trash_set_fire(){
  del -rfv $TRASH_DIR/*
}
