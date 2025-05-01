#!/bin/sh
eval $(gnome-keyring-daemon --start --components=secrets,ssh)
export SSH_AUTH_SOCK
