alias nt="npm run test -- -R tap"
alias nl="npm run lint"
alias nlf="npm run lint:fix"

export NVM_DIR="$HOME/.nvm"
if [[ ! -e $NVM_DIR ]];then 
  git clone git@github.com:creationix/nvm.git $NVM_DIR
fi 

. "$NVM_DIR/nvm.sh"
