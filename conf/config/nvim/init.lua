require('plugin_load')
require('opts_setup')
require('opts_toggle')
require('plugin_util')
require('plugin_complete')
require('plugin_statusline')
require('plugin_search')
require('plugin_neodev')
require('plugin_fidget')
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

-- trim all the whitespace at the end of lines
vim.cmd('command! TrimLines :%s/\\s\\+$//e|norm!`` ')
vim.cmd('command! EditConfig :lua Edit_Config()')

-- <c-u> will clear the line when in : mode or insert mode
vim.cmd("imap <c-u> <esc>ddi")
vim.cmd('hi DiagnosticWarn guifg=#2a2a2a')
vim.cmd('hi DiagnosticSignWarn guifg=#2a2a2a')
vim.cmd('hi DiagnosticSignWarn guibg=#555555')
