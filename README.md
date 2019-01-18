# [Mold](https://github.com/slugbyte/mold) Root
![Shreded green glitch with black moss](https://assets.slugbyte.com/github/github-header-00007.png)  

## About
This repository holds my dotfiles in *conf/* , shell script "plugins" in *plug/*, executable scripts in *exec/*, file templates in *leaf/*, and project scaffolds in *fold/*. I manage this repository it using a tool I created called [mold](https://github.com/slugbyte/mold), that enables me to both track and manage this repository's content and quickly sync its configuration on multiple machines. Below are some highlights of tools I created in this repository for enhancing my own coding workflow that might be useful for anyone. 

## Highlights

## f 
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
