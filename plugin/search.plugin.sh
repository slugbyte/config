search(){
  local output=$(ag $1 | fzf)
  local path=$(echo "$output" | cut -d ':' -f 1)
  local linenum=$(echo "$output" | cut -d ':' -f 2)
  $EDITOR +${linenum} $path
}
