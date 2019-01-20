# [Mold](https://github.com/slugbyte/mold) Root
![Shreded green glitch with black moss](https://assets.slugbyte.com/github/github-header-00007.png)  

## About This Repository
This repository holds my dotfiles in *conf/* , shell script "plugins" in *plug/*, executable scripts in *exec/*, file templates in *leaf/*, and project scaffolds in *fold/*. I manage this repository it using a tool I created called [mold](https://github.com/slugbyte/mold), that enables me to both track and manage this repository's content and quickly sync its configuration on multiple machines.  

## Great Shell Resources
Here are a few great resources that I use for reseaching shell and sys-config related information!   
* [Awesome Shell](https://github.com/alebcay/awesome-shell): A curated list of awesome command line tools and resources
* [Bash Hackers Wiki](https://wiki.bash-hackers.org/): A great resource for everything bash scripting
* [GitHub Dotfiles](https://dotfiles.github.io/): Your unofficial guide to dotfiles on github
* [Bash completion project](https://github.com/GArik/bash-completion): programmable completion for the bash shell


## My Favorite Open Source Tools
A list of some of my favorite CLI tools for boosting programming workflow in the command line.  
* [aria2c](https://aria2.github.io/) - An ultra-fast download utility with support for HTTP(S), FTP, SFTP, BitTorrent, and Metalink
* [bat](https://github.com/sharkdp/bat) - a cat clone with syntax highlighting 
* [commacd](https://github.com/shyiko/commacd) - a faster way to move around in bash
* [figlet](http://www.figlet.org/) - A program for makin large letters out of text
* [fzf](https://github.com/junegunn/fzf) - A command-line fuzzy finder
* [git aware prompt](https://github.com/jimeh/git-aware-prompt) - Display git branch name in your terminal prompt
* [goto](https://github.com/iridakos/goto) - A shell utility to quickly navigate to aliased directories supporting auto-completion
* [gpg](https://www.gnupg.org/) - allows you to encrypt and sign your data and communications
* [httpie](https://httpie.org/) - a command line HTTP client with an intuitive UI, JSON support, and syntax highlighting
* [nvim](https://neovim.io/) - the future of vim (the text editor) 
* [the\_silver\_searcher](https://github.com/ggreer) - A code-searching tool similar to ack, but faster
* [tldr](https://tldr.sh/) - Simplified and community-driven man pages
* [tmux](https://github.com/tmux/tmux) - tmux is a terminal multiplexer
* [tree](http://mama.indstate.edu/users/ice/tree/) - list contents of directories in a tree-like-format

## Config Highlights
Below are some highlights of tools I created in this repository for enhancing my own coding workflow.
**NOTE:** I have developed the habbit of using a lot of single charicter alias shorthand and 
It's allways worked well for me. However, I have heard many strong arguments aginst the practice
and would urge people to think twice before they create the habit. That said, Its allready been a part
of my workflow for a long time and I have no intention to stop anytime soon. 

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
    return 0
  fi
  gpg -sea -r $EMAIL $1
  rm $1
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
}
```

## todo
The simplest todo list slash general notes utily I could think of is an alias that allways opens the same file in a text editor.  
`alias toto='vim $HOME/.todo.md`  

## colors
Show a table of all the ansi color codes.  
**Example**  
`$ colors`
![colors cli example](https://assets.slugbyte.com/github/misc/colors-example.png)
``` bash 
#!/usr/bin/env bash
_colors(){
  figlet 'ansi color'
  for x in {0..63};do 
    x=$(( x * 4 ))
    for y in {0..3};do 
      color=$(( x + y ))
      echo -n $(tput setab $(( $color ))) $(tput setaf 15) 
      printf " %3g  " $color
      echo -n $(tput setab 0) 
    done; 
    for y in {0..3};do 
      color=$(( x + y ))
      echo -n $(tput setaf $(( $color ))) $(tput setab 0) 
      printf "%3g" $color
      echo -n $(tput setab 0) 
    done; 
    echo ""
  done
}
_colors | less -r
```

## Git Shorthand  
### `c [args]` - smart git commit
* First run `git add -A` to add all the untracked changes
* Then run `git commit` with the following flags
    * with `-S` to sign the commit using gpg (if the signing fails so does the commit)
    * with `-v` to show the git-diff in vim when writing the commit message
    * also allows users to pass args. *e.g.* `-m 'message'`
* Finnaly, run `git verify-commit HEAD`, to print a log that demonstrates if the commit was successfully signed
**EXAMPLES**  
Commit with vim: `$ c`  
Commit with a message: `$ c -m 'Initial commit'`  
``` bash 
c(){
  git add -A && git commit -v -S "$@" && git verify-commit HEAD
}
```  
### `l [branch]` - smart git pull
Pull from the current branch or a specific branch. `l` will also print errors for not a git repository, or trying to pull from a detached head.  
**EXAMPLES**  
Pull the current branch: `$ l`  
Pull the foobar branch: `$ l foobar`  
```bash
l() {
  local branch
  if (( $# > 0 ));then
    echo "Pulling from $@"
    git pull origin $@ -v
    return 0
  fi
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot pull from detached state without a branch name argument"
      return 1
    fi
    echo "Pulling from $branch"
    git pull origin $branch -v
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}
```
### `p [flags]` - smart git push
Push to the current branch and allow flags to be passed.  
**Example**  
Push to the current branch `$ p`  
Force push to the current branch `$ p --force`  
Push to the current branch with tags `$ p --follow-tags`  
``` bash
p() {
  local branch
  if branch=$(git rev-parse --abbrev-ref head 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      echo "Error: Cannot push from detached state."
      return 1
    fi
    echo "Pushing to $branch $@"
    git push origin $branch $@ -v
    return 0
  else
    echo "Error: Not a git repository"
    return 1
  fi
}
```
### `t [args]` - smart git tag
List tags, delete tags, and create/sign tags.  
**Examples**  
List tags with messages: `$ t`  
Create and sign tag: `$ t v0.1.1`  
Delete tag: `$ t v0.1.1` 
``` bash
t(){
  if (( $# < 1 ));then 
    git tag -n99
    return 0
  elif (( $# > 1 ));then 
    git tag "$@"
    return 0
  else
    git tag -s "$@" && git verify-tag $1
  fi 
}
```
### `b [args]` - smart git branch
List branches and delete branches.  
**Examples**  
Run `git branch -av`: `$ b`   
Delete branch: `$ b -D branch-name`  
``` bash
b(){
  if (( $# < 1 ));then 
    git branch -av
    return 0
  else
    git branch "$@"
  fi 
}
```
