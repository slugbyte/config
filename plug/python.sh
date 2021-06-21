## init pyenv
export PYENV_VERSION=3.8.5
export PYENV_ROOT="$HOME/.config/pyenv"
prependpath "$PYENV_ROOT/bin"

pyup(){
  eval "$(pyenv init -)"
  pyenv shell $PYENV_VERSION
}

pydown(){
  eval "$(pyenv init -)"
  pyenv shell $PYENV_VERSION
}

if [[ $(uname -s) = 'Darwin' ]];then
 pyclean () {
   find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
 }
else
 pyclean () {
   find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
 }
fi 


## utils
##alias pyoff='deactivate'
##alias pyon='pipenv shell'
#if [[ $(uname -s) = 'Darwin' ]];then
 #pyclean () {
   #find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
 #}
#else
 #pyclean () {
   #find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
 #}
#fi 
