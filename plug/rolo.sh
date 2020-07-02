ROLO_TOOL=$HOME/workspace/rolo-bench/tool
export PATH=$ROLO_TOOL/bin:$PATH

fix(){
  eslint --fix $@
}
