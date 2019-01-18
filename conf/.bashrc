# OPTIONS
shopt -s histappend
history -a
set globstar
set nocaseglob

# Environment Variabels
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'
export PAGER=$(which less)
export EDITOR=$(which vim)

# Mold Init
export MOLD_ROOT="$HOME/workspace/slug-bench/config"
export PATH="$MOLD_ROOT/exec:$PATH"
for plug in $MOLD_ROOT/plug/* ;do
  . $plug
done

# Verbose Error Exit Status
handle_error(){
  local status=$?
  echo "ERROR: command[$(history | tail -n 1| sed 's/.......//')] status($status)"
}
trap handle_error ERR
