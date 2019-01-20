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

