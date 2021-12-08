# INIT
> startup scripts

# x
* all scripts in `init/x/start` will be sourced by the `.xinitrc`
* all scripts in `init/x/stop` will be run when `exec/wm_quit_x_server` is run

# wm
all scripts in this directory will be sourced by the `.bspwmrc`.

**NOTE:** in order to support bspwm reload, these scripts should kill old running
daemons before starting them.

