if [[ $(uname -s) = 'Darwin' ]];then
  pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
  }
else
  pyclean () {
    find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
  }
fi 
