thumb_unmount(){
  rm $HOME/thumb_drive
  sudo umount /mnt/thumb_drive
}

thumb_mount(){
  local drive
  thumb_unmount 2> /dev/null
  drive=$(sudo fdisk -l | grep dev |fzf)
  drive=$(echo $drive |cut -d ' ' -f 1)
  sudo mkdir -p /mnt/thumb_drive 
  sudo mount $drive /mnt/thumb_drive -o umask=000
  sudo chmod -R 777 /mnt/thumb_drive
  ln -s /mnt/thumb_drive $HOME/thumb_drive
}
