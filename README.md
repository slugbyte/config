# [Mold](https://github.com/slugbyte/mold) Root
![Shreded green glitch with black moss](https://assets.slugbyte.com/github/github-header-00007.png)  

## About
This repository holds my dotfiles in *conf/* , shell script "plugins" in *plug/*, executable scripts in *exec/*, file templates in *leaf/*, and project scaffolds in *fold/*. I manage this repository it using a tool I created called [mold](https://github.com/slugbyte/mold), that enables me to both track and manage this repository's content and quickly sync its configuration on multiple machines. Below are some highlights of tools I created in this repository for enhancing my own coding workflow that might be useful for anyone. 

## Highlights
**NOTE:** I have developed the habbit of using a lot of single charicter alias shorthand, and 
It's allways worked well for me. I have heard many strong arguments aginst the practice
and would urge people to think twice before they create the habit. Since its allready been a part
of my workflow for a long time I have no intention to stop anytime soon. 

## f for find
 `f` is a bash function that will use [fzf](https://github.com/junegunn/fzf) to select output from [the_silver_searcher](https://github.com/ggreer/the_silver_searcher) and then open the selected line in vim.
 
######  `Usage: f [search string]`  
**Example:** `$ f todo`
![f-util-example](https://assets.slugbyte.com/github/misc/f-util-example.png)  
``` bash 
f(){
  local result=$( ag "$1" | fzf )
  local path=$( echo "$result" | cut -d ':' -f 1 )
  local linenum=$( echo "$result" | cut -d ':' -f 2 )
  [[ ! $path ]] && {
    echo "no match found"
    return 1
  }
  vim "+${linenum}" "$path"
}
```

## fuzz and defuzz
`fuzz` is a bash function that will use gpg to sign and encrypt a file or directory. If a directory is supplied fuzz will automaticly create a tarball from it and then encrypt the tarball. Once an encrypted file has been created fuzz will also delete the unencryped content.   
`defuzz` is a bash function that will use gpg to decrypt a file or encrypted tarbal. If the encryped file was a tarbal it will automaticly be unpacked into a directory. Once the encrypted file has been decrypedted into a normal file or direcotry, the encrypted file will be deleted.  
Fuzz and defuzz will both kill the gpg-agent after each run, this will force you to use your password each time you encryped or decrypt a file.  
**Example**
![fuzz and defuzz example](https://assets.slugbyte.com/github/misc/fuzz-defuzz-example.png)  
``` bash 
fuzz(){
  if [[ -z $1 ]]; then
    >2& echo "ERROR: no target supplied"
    return -1
  fi
  if [[ -d $1 ]]; then
    tar -czf $1.tar.gz $1
    gpg -sea -r $EMAIL $1.tar.gz
    rm -rf $1
    rm $1.tar.gz
    killall gpg-agent || echo ''
    return 0
  fi
  gpg -sea -r $EMAIL $1
  rm $1
  killall gpg-agent || echo ''
}

defuzz(){
  if [[ -z $1 ]]; then
    >2& echo "ERROR: no target supplied"
    return -1
  fi
  output=${1/.asc/}
  gpg -o $output -d $1 && rm $1
  if [[ $output == *.tar.gz ]];then
    tar -xzf $output
    rm $output
  fi
  killall gpg-agent || echo ''
}
```

## t is for todo list
The simplest todo list slash general notes utily I could think of is an alias that allways opens the same file in a text editor.  
`alias t='vim $HOME/.todo.md`  

## Git Shorthand  
#### c + [message] to `add -A && git commit -S [-m message]`
<!--TODO  -->
#### l + [args] to `git pull origin <current branch> [args]`
<!--TODO  -->
#### p + [args] to `git push origin <current branch> [args]`
<!--TODO  -->

## Favorite Open Source Tools
* [aria2c](https://aria2.github.io/) - An ultra-fast download utility with support for HTTP(S), FTP, SFTP, BitTorrent, and Metalink
* [bat](https://github.com/sharkdp/bat) - a cat clone with syntax highlighting 
* [commacd](https://github.com/shyiko/commacd) - a faster way to move around in bash
* [figlet](http://www.figlet.org/) - A program for makin large letters out of text
* [fzf](https://github.com/junegunn/fzf) - A command-line fuzzy finder
* [git aware prompt](https://github.com/jimeh/git-aware-prompt) - Display git branch name in your terminal prompt
* [goto](https://github.com/iridakos/goto) - A shell utility to quickly navigate to aliased directories supporting auto-completion
* [httpie](https://httpie.org/) - a command line HTTP client with an intuitive UI, JSON support, and syntax highlighting
* [the\_silver\_searcher](https://github.com/ggreer) - A code-searching tool similar to ack, but faster
* [tldr](https://tldr.sh/) - Simplified and community-driven man pages
* [tmux](https://github.com/tmux/tmux) - tmux is a terminal multiplexer
* [tree](http://mama.indstate.edu/users/ice/tree/) - list contents of directories in a tree-like-format

## Great Shell Resources
* [Awesome Shell](https://github.com/alebcay/awesome-shell): A curated list of awesome command line tools and resources
* [Bash Hackers Wiki](https://wiki.bash-hackers.org/): A great resource for everything bash scripting
* [GitHub Dotfiles](https://dotfiles.github.io/): Your unofficial guide to dotfiles on github
* [Bash completion project](https://github.com/GArik/bash-completion): programmable completion for the bash shell
