export TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -e $TPM_DIR ]];then 
  git clone git@github.com:creationix/nvm.git $TPM_DIR
fi 
