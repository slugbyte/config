f(){
  local result=$( ag "$1" | fzf ) 
  local path=$( echo "$result" | cut -d ':' -f 1 )
  local linenum=$( echo "$result" | cut -d ':' -f 2 )
  [[ ! $path ]] && {
    echo "no match found"
    return 1
  }
  $EDITOR "+${linenum}" "$path"
}
