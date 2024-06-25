# CONFIG

# Install
* running `link.sh` with out flags will do a dry run
  * it will log all the commands that will run (without executing them)
* running `link.sh --plz` will install config files
  * it will **soft link** dirs in `config/` to `~/.config`
  * it will **hard link** files in `home/` to `~/`
