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


function Save()
  vim.cmd("silent! wall")
  print("[files saved]", string.sub(math.random() .. "", -4, -1))
end

-- window
map('n', '<leader>w', "'lua Save()<CR>", {})
map('n', '<leader>q', "'qall<CR>", {})

-- tmux
map('n', '<C-n>', ":TmuxNavigateDown<CR>", {silent = true})
map('n', '<C-e>', ":TmuxNavigateUp<CR>", {silent = true})
map('n', '<C-o>', ":TmuxNavigateRight<CR>", {silent = true})
map('n', '<C-y>', ":TmuxNavigateLeft<CR>", {silent = true})

-- surround
map("n", '<leader>r', "<Plug>SurroundReplace", {})
map("n", '<leader>d', "<Plug>SurroundDelete", {})
map("v", 's', "<Plug>SurroundAddVisual", {})

-- fzf
map('', 'j', ":Telescope find_files<CR>", {noremap = true})
map('', 'J', ":Telescope live_grep<CR>", {noremap = true})

-- jump scroll
map('', '@', "zt", {noremap = true})
map('', '$', "zz", {noremap = true})
map('', '#', "zb", {noremap = true})

-- lsp
map('', '&', ':lua vim.diagnostic.open_float()<CR>', {noremap = true})

-- conjure
vim.cmd('let g:conjure#mapping#prefix = ","')
