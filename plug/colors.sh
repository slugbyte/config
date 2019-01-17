color_count=$(tput colors)
if (( color_count > 0 ));then 
  color_black="$(tput setaf 0)" #black
  color_red="$(tput setaf 1)" #red
  color_green="$(tput setaf 2)" #green
  color_yellow="$(tput setaf 3)" #yellow
  color_blue="$(tput setaf 4)" #blue
  color_magenta="$(tput setaf 5)" #magenta
  color_cyan="$(tput setaf 6)" #cyan
  color_white="$(tput setaf 7)" #white
  color_reset="$(tput sgr0)" #default foreground color
fi 
