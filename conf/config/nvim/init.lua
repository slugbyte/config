require('plugin_load')
require('opts_setup')
require('opts_toggle')
require('plugin_util')
require('plugin_complete')
require('plugin_statusline')
require('plugin_search')
require('plugin_lsp')
require('keymap')

local telescope = require('telescope.builtin')
function Edit_Config()
  telescope.find_files({
    cwd = '~/.config/nvim',
    follow = true,
    hidden = true,
  })
end

vim.cmd('command! EditConfig :lua Edit_Config()')
vim.cmd("command! Files :Telescope find_files")
vim.cmd("command! Rg :Telescope live_grep")

vim.cmd("imap <c-u> <esc>ddi")


