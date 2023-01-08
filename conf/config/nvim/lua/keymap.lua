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
vim.g.local_leader = ' '


function Save()
  vim.cmd("silent! wall")
  print("[write all]", string.sub(math.random() .. "", -4, -1))
end

-- search

-- clear search
map('n', '<leader>/', ':let @/ = ""<CR>', {})

-- window
map('n', '<leader>w', "'lua Save()<CR>", {desc = "save all"})
map('n', '<leader>q', "'qall<CR>", { desc = "quit all"})
map('n', '<leader>n', "'n<CR>", {desc = "next buffer"})
map('n', '<leader>p', "'prev<CR>", {desc = "prev buffer"})
map('', '<C-g>', ':on<CR>', { desc = "hide all other panes"})

-- tmux
map('n', '<C-n>', ":TmuxNavigateDown<CR>", { silent = true , desc = "tmux down"})
map('n', '<C-e>', ":TmuxNavigateUp<CR>", { silent = true , desc = "tmux up"})
map('n', '<C-o>', ":TmuxNavigateRight<CR>", { silent = true, desc = "tmux right"})
map('n', '<C-y>', ":TmuxNavigateLeft<CR>", { silent = true , desc = "tmux left"})

-- surround
map("n", '<leader>r', "<Plug>SurroundReplace", {})
map("n", '<leader>d', "<Plug>SurroundDelete", {})
map("v", 's', "<Plug>SurroundAddVisual", {})

-- fzf
map('', 'j', ":Telescope find_files<CR>", { noremap = true, desc = "t find files"})
map('', 'J', ":Telescope live_grep<CR>", { noremap = true, desc = "t grep"})
map('', 'J', ":Telescope live_grep<CR>", { noremap = true, desc = "t grep"})
map('', 'J', ":Telescope live_grep<CR>", { noremap = true, desc = "t grep"})

vim.keymap.set('n', '<leader>,', ":ConjureEvalRootForm<CR>", { desc = 'Eval Root Form' })

vim.keymap.set('n', '<leader>tf', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>th', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>tw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>tg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>td', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>tb', require('telescope.builtin').registers, { desc = 'Search registers' })
vim.keymap.set('n', '<leader>tr', require('telescope.builtin').lsp_references, { desc = 'Search lsp lsp_references' })
vim.keymap.set('n', '<leader>ti', require('telescope.builtin').lsp_implementations, { desc = 'Search lsp_implementations' })
vim.keymap.set('n', '<leader>to', require('telescope.builtin').oldfiles, { desc = 'Search old files' })
vim.keymap.set('n', '<leader>tk', require('telescope.builtin').keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })


-- jump scroll
map('', '@', "zt", { noremap = true })
map('', '$', "zz", { noremap = true })
map('', '#', "zb", { noremap = true })

-- lsp
map('', '&', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- conjure
vim.cmd('let g:conjure#mapping#prefix = ","')
