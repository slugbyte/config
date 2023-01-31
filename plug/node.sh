# LOAD NVM
## node
export NVM_DIR="$SLASH/lang/node"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# CONFIG NODE ENV
export NODE_ENV=test
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# alias helpers
alias nr='npm run'
alias ns='npm i -S'
alias nd='npm i -D'
alias tp='npm run pompom:test --'
