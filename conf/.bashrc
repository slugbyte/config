shopt -s histappend
# Options
history -a
set globstar
set nocaseglob

# Environment Variabels
export BASH_SILENCE_DEPRECATION_WARNING=1
export EMAIL='slugbyte@slugbyte.com'
export FULLNAME='Duncan Marsh'
export PAGER=$(which less)
export EDITOR=$(which nvim)
export GPG_TTY=$(tty)
export LC_ALL='en_US.UTF-8'

# Mold Init
export MOLD_ROOT="$HOME/.mold"
export MOLD_SIGN='true'
export PATH="$MOLD_ROOT/exec:$PATH"
for plug in $MOLD_ROOT/plug/* ;do
  . $plug
done

# LOAD SECRETS
export SECRET_DIR="$HOME/.secret"
for  secret in $SECRET_DIR/*.secret.sh; do 
  . $secret
done

# Verbose Error Exit Status
handle_error(){
  local status=$?
  echo "ERROR: command[$(history | tail -n 1| sed 's/.......//')] status($status)"
}
trap handle_error ERR

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/slugbyte/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/slugbyte/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/slugbyte/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/slugbyte/Downloads/google-cloud-sdk/completion.bash.inc'; fi
