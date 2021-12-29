# init/x daemon
killall pipewire || true
killall pipewire-pulse || true
killall xautolock || true
# killall ibus-daemon || true
killall clipmenud || true
killall dropbox || true
pm2 kill || true

# init/wm daemon
killall sxhkd || true
killall polybar || true
killall conky || true
