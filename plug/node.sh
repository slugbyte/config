alias nt="npm run test -- -R tap"

export NVM_DIR="$HOME/.nvm"
if [[ ! -e $NVM_DIR ]];then 
  git clone git@github.com:creationix/nvm.git $NVM_DIR
fi 

. "$NVM_DIR/nvm.sh"
