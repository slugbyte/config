autolock_enable() { 
  xautolock -time 5 -locker slock -detectsleep &
}

autolock_disable() { 
  killall xautolock 2> /dev/null
}
