s_vfatmount(){
  mkdir -p $2
  sudo mount -o umask=0000,uid=$UID,gid=$GID $1 $2
}

s_mount(){
  mkdir -p $2
  sudo mount $1 $2
  sudo chown -R slugbyte:slugbyte $2
}

sumount(){
  sudo umount $@
}
