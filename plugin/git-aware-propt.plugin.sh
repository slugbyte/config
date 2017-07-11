export GITAWAREPROMPT=$BASH_PLUGIN_DIR/modules/git-aware-prompt

if [[ ! -e $GITAWAREPROMPT ]];then 
  echo "hello"
  git clone git://github.com/jimeh/git-aware-prompt.git $GITAWAREPROMPT
fi 

. "${GITAWAREPROMPT}/main.sh"
