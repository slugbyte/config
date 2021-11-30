wacom_device_list(){
  echo "wacom devices:"
  xsetwacom --list devices
}

wacom_right_monitor(){
  xsetwacom --set $1 MapToOutput $WM_STYLE_MONITOR_RIGHT
}

wacom_left_monitor(){
  xsetwacom --set $1 MapToOutput $WM_STYLE_MONITOR_LEFT
}
