# Fish Shell Cheatsheet

## Redirects
```fish
cmd >/dev/null          # stdout to null
cmd 2>/dev/null         # stderr to null
cmd &>/dev/null         # both to null
cmd 2>&1                # stderr to stdout
cmd | tee file          # stdout to file and screen
```

## Variables
```fish
set myvar "value"       # local variable
set -x VAR "value"      # export (env var)
set -e VAR              # erase variable
set -g VAR "value"      # global scope
set -U VAR "value"      # universal (persists)
```

## Lists
```fish
set list a b c
echo $list[1]           # "a" (1-indexed!)
echo $list[-1]          # "c" (last element)
set -a list d           # append
set -p list z           # prepend
```

## Command Substitution
```fish
set result (command)    # capture output
echo (math 1+1)         # inline
```

## Conditionals
```fish
if test -f file; ...; end
if test "$var" = "val"; ...; end
test -d dir; and echo "exists"
test -z "$var"; or echo "not empty"
```

## Loops
```fish
for f in *.txt
    echo $f
end

while read line
    echo $line
end < file
```

## Functions
```fish
function greet
    echo "Hello $argv[1]"
end

function --on-event fish_prompt  # event handler
```

## String Manipulation
```fish
string match -r 'pattern' $var
string replace old new $var
string split ':' $PATH
string join ',' $list
```

## Status & Exit Codes
```fish
echo $status             # last exit code
command; or return 1     # short-circuit
command; and next_cmd    # run if success
```

## Useful Builtins
```fish
abbr -a g git            # abbreviation
alias ll 'ls -la'        # alias (just a function)
type command             # show definition
fish_add_path ~/bin      # add to PATH
```
