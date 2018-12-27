vmboot(){
  vbox startvm $1 --type headless
}

vmkill(){
  vbox controlvm $1 acpipowerbutton
}
