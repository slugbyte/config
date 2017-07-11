acp_fortune(){
  git add . 
  git commit -m "$(fortune)"
  git push origin ${1:-master}
}
