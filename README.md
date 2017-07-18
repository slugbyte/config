# config and tools

#### dot
> the config magnagement bash function
dot is defined in `plugin/dot.plugin.sh`. the dot utility is for managing my system config. its a small shell script with little user validation `:p`.

assets are organized by dot in the following dirs...
* **config** -- dot files 
* **bin** -- executable files  (added to `$PATH`)
* **plugin** -- bash scripts that should be sourced by interative shell

#### `__DONT_RUN_THIS__` unless your me 
`curl https://raw.githubusercontent.com/slugbyte/config/master/install.sh | bash`
