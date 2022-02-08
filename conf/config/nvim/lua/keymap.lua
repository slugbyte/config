local map = vim.api.nvim_set_keymap

local unruly_worker = require('unruly-worker')
unruly_worker.setup({
  enable_lsp_map = true,
  enable_select_map = true,
  enable_comment_map = true,
  enable_wrap_navigate = true,
  enable_visual_navigate = true,
  enable_easy_window_navigate = true,
  enable_quote_command = true,
  enable_alt_jump_scroll = true,
})

vim.g.mapleader = ' '

-- window
map('n', '<leader>w', "'w<CR>", {})
map('n', '<leader>q', "'q<CR>", {})

-- surround
map("n", '<leader>r', "<Plug>SurroundReplace", {})
map("n", '<leader>d', "<Plug>SurroundDelete", {})
map("v", 's', "<Plug>SurroundAddVisual", {})

-- fzf
map('', 'j', ":F<CR>", {noremap = true})
map('', 'J', ":S<CR>", {noremap = true})

-- conjure
vim.cmd('let g:conjure#mapping#prefix = ","')
