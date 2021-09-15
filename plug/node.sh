# alias nt="npm run test -- -R tap"
# alias noli="npm run lint"
# alias nolf="npm run lint:fix"
# alias norel="npm run release:ci"
# alias nosy="npm run sync"
# alias nods="npm run docs:serve"

alias release="npm run release:ci"

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

alias nr='npm run'
alias ns='npm i -S'
alias nd='npm i -D'
alias nt='npm run test --'
