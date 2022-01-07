alias xs="sudo xbps-query -Rs"
alias xq="sudo xbps-query"
alias xi="sudo xbps-install -y"
alias xr="sudo xbps-remove -R"

xu() {
  sudo xbps-install -Syu
  sudo update-grub
  xbps-reconfigure -fa
}
