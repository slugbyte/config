# init/x daemon
killall pulseaudio
killall xautolock
killall ibus-daemon
killall clipmenud
killall dropbox
pm2 kill

# init/wm daemon
killall sxhkd
killall polybar
killall conky
