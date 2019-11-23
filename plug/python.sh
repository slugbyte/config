# Python Related Utilitys

PYENV_VERSION=3.7.4
export PYTHON_CONFIGURE_OPTS="--enable-framework"
eval "$(pyenv init -)"
#alias py='python3'
alias pyoff='deactivate'
alias pyon='pipenv shell'

if [[ $(uname -s) = 'Darwin' ]];then
  pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
  }
else
  pyclean () {
    find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
  }
fi 

pyenv shell $PYENV_VERSION
