xrandr --output 'DisplayPort-1' --mode '1920x1080' --rate 120 --rotate normal --right-of 'HDMI-A-0' \
  --output 'HDMI-A-0' --mode '1920x1080' --rate 60 --rotate normal 

xrandr --output 'DisplayPort-1' --set TearFree on
xrandr --output 'HDMI-A-0' --set TearFree on
