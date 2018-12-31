# config and tools

![Shreded green glitch with black moss](https://assets.slugbyte.com/github/github-header-00007.png)  

## dot
> a bash function that helps me manage system configuration 

HELLO from iteration 3 or 4 of my homegrown tooling for managing system configuration. For years I've toyed around with different ways to setup and maintain computers. My current solution is a bash script called `dot`. Dot allows me to completely setup a fresh a VM in just a few minutes. Its only install dependencies are `curl` and `git`. dot is heavily inspired by lots of projects on https://dotfiles.github.io.   

Though there are many powerful sys-config tools out in the world. I have a deep love for noodling around with my computer, and rolling my own hacky tooling has taught me a lot about computers, and helped me develop my programing workflow. 

[check out dots source code](https://github.com/slugbyte/config/blob/master/plugin/dot.plugin.sh)

### Features
#### Bash Plugins
`dot` is written in bash and is loaded each time a shell is created. Dot's bash plugins are just shell scripts that are loaded each time bash is initialized. Im one of the many (or is it few) people prefer using a shell over an IDE, and these plugins are my reasons why. I have created them to automate away many tasks and speed up my workflows. Whenever I find my self repeating procedures I just use dot to create a new plugin.   

#### Project Scaffolding 
Dot allows me to create scaffolding directories that I can clone any time I have a new project. This makes setup for a new nodejs, c, web, react, or rust project a one liner.   

#### Dotfile managment
Dot links my dotfiles into my home directory using Hard Links. This way every time I make a change it happens in the git repository and its easy to commit and push changes.  

#### Executables 
Dot has a bin directory that gets added to the bash $PATH, nuf said.  

#### System Installers
When dot is install it has the option to run installers that are specific for different OS's. The installers fetch my favorite tools using the appropriate package manager.   

## Organization 
* **config/** -- the dotfiles 
* **bin/** -- the executable files  (added to `$PATH`)
* **plugin/** --  the bash scripts that should be sourced by interative shell
* **template/** -- project scafolding 
* **install/** -- OS specific tooling installers 

## INSTALL
#### `__DONT_DO_THIS__` unless your me 
* setup a box and insure git is installed
* generate new ssh public key and add to github settings
* `curl https://raw.githubusercontent.com/slugbyte/config/master/install.sh | bash`
