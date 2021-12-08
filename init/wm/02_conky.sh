# kill conky if running
killall conky &> /dev/null || true

# start conky
conky &
