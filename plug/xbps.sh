alias xs="sudo xbps-query -Rs"
alias xi="sudo xbps-install -y"
alias xr="sudo xbps-remove -R"

xu() {
  sudo xbps-install -Syu
  sudo update-grub
}
