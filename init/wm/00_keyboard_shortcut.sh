# kill sxhkd if running
killall sxhkd &> /dev/null || true

# start sxhkd
sxhkd &
