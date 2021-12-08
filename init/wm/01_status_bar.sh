# kill polybar if running
killall polybar &> /dev/null || true

polybar left &
polybar right &
