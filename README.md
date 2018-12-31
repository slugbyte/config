# config and tools

![Shreded green glitch with black moss](https://assets.slugbyte.com/github/github-header-00007.png)  

## dot
> the bash function that helps me maintain this repo

dot is defined in `plugin/dot.plugin.sh`. its a small shell script with little to no user validation `:p`.

config's assets are organized by dot in the following dirs...
* **config** -- the dotfiles 
* **bin** -- the executable files  (added to `$PATH`)
* **plugin** --  the bash scripts that should be sourced by interative shell

#### `__DONT_DO_THIS__` unless your me 
* setup a box and insure git is installed
* generate new ssh public key and add to github settings
* `curl https://raw.githubusercontent.com/slugbyte/config/master/install.sh | bash`
