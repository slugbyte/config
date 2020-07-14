screenshot_location(){
  defaults write com.apple.screencapture location "$1"
}

screenshot_location_reset(){
  defaults write com.apple.screencapture location "$HOME/Desktop/screenshot"
}
