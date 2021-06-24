# zsh traps
traps are hooks that enable you to run a zsh function when certain hooks occur

## handle error
this example will print the failed exit code, if a progam exits with a non-zero exit code. This can be helpful knowing when programs fail but don't print any error message.
``` zsh
# 
handle_error(){
  echo "FAILED: status code $?"
}

trap handle_error ERR
```
