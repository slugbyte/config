# [Mold](https://github.com/slugbyte/mold) Root
![Shreded green glitch with black moss](https://assets.slugbyte.com/github/github-header-00007.png)  

 <!-- TODO: write about my system config highlights -->
 
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
