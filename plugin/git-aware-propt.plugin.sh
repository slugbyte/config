export GITAWAREPROMPT=$DOT_ROOT/plugin/modules/git-aware-prompt

if [[ ! -e $GITAWAREPROMPT ]];then 
  echo "hello"
  git clone git://github.com/jimeh/git-aware-prompt.git $GITAWAREPROMPT
fi 

. "${GITAWAREPROMPT}/main.sh"
