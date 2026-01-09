# SET ENVIRONMENT
# NOTE: env.sh MUST ALLWAYS SOUCE MY ENV (if PATH is not set properly it will bork everyting)
export SHELL=$(which bash)
source ~/.config/slugbyte/env.sh

# EXIT IF NOT INTERACTIVE
[[ $- != *i* ]] && return

# LOAD OMARCHY
source ~/.local/share/omarchy/default/bash/rc

# LOAD THEME
source ~/.config/bash/theme.sh

# SET ALIASES
unalias -a # remove all aliases
source ~/.config/slugbyte/alias.sh
alias R="source ~/.bashrc"
