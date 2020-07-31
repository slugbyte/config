alias nt="npm run test -- -R tap"
alias noli="npm run lint"
alias nolf="npm run lint:fix"

export NVM_DIR="$HOME/.nvm"
if [[ ! -e $NVM_DIR ]];then 
  git clone git@github.com:creationix/nvm.git $NVM_DIR
fi 

. "$NVM_DIR/nvm.sh"
