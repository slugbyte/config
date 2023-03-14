const chalk = require('chalk')

let username = null
const getUsername = () => {
  if (username) return username
  const userData = db.runCommand({connectionStatus : 1}).authInfo.authenticatedUsers[0];
  if (userData) {
    username = userData.user
  } else {
    username = "unknown-user"
  }
}

const doesUsernameIncludeReader = () => {
  return -1 !== getUsername().indexOf('reader')
}

const getPromptAccountPermissionDescription = () => {
  if (doesUsernameIncludeReader()) {
    return chalk.white('(reader)')
  }
  return chalk.red('! WRITER !')
}

/** username @ database_name color coded for danger level 
 * (blue is safe)
 * (red and yellow are dangerous) */
const getPromptLogin = () => {
  const database_name = db.getName()
  const is_release = -1 !== database_name.indexOf('release')
  const colorizeDatabaseName = chalk[is_release ? 'red' : 'blue']
  const account_username = getUsername()
  const is_reader = doesUsernameIncludeReader()
  const colorizeUsername = chalk[is_reader ? 'blue' : 'yellow']
  return `${colorizeUsername(account_username)}${chalk.white('@')}${colorizeDatabaseName(database_name)}`
}

const prompt = () => {
  const prompt_permission = getPromptAccountPermissionDescription()
  const prompt_login = getPromptLogin()
  return `${prompt_permission} ${prompt_login}\n> `
}

module.exports =  { prompt }
