# rename file extensions
r_ext(){
  if [[ -z $1 ]]; then 
    >2& echo "ERROR: no target supplied" 
    return -1
  fi 

  filename="$1"
  f_len=${#filename}
  ext="$2"
  e_len=${#ext}
  extension=${1:f_len-e_len}

  if [[ "$extension" == "$ext" ]];then 
    mv $filename "${filename::f_len-e_len}"
    echo renamed  "${filename::f_len-e_len}"
  else 
    mv $filename "${filename}${ext}"
    echo renamed  "${filename}${ext}"
  fi 
}

txtify(){
  if [[ -z $1 ]]; then 
    >2& echo "ERROR: no target supplied" 
    return -1
  fi 
  r_ext "$1" ".txt"
}

backupify() {
  if [[ -z $1 ]]; then 
    >2& echo "ERROR: no target supplied" 
    return -1
  fi 
  r_ext "$1" ".backup"
}
