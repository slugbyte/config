require('plugin_load')
require('opts_setup')
require('opts_toggle')
require('plugin_util')
require('plugin_complete')
require('plugin_statusline')
require('plugin_lsp')
require('keymap')

function Edit_Config()
  vim.api.nvim_call_function('fzf#run', {{
    source = 'rg --files ~/.config/nvim',
    sink = 'e'
  }})
end

vim.cmd('command! EditConfig :lua Edit_Config()')
