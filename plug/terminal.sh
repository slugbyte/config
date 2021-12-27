# set the window titile for the exec/terminal script
terminal_title_set(){
  print -n "\e]2;__XOXO__:$PWD"
}
terminal_title_set
precmd(){
 terminal_title_set 
}
