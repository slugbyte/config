local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
map("n", '<leader>r', "<Plug>SurroundReplace", {})
map("n", '<leader>d', "<Plug>SurroundDelete", {})
map("v", '<leader>s', "<Plug>SurroundAddVisual", {})
map('n', '<leader>w', "'w<CR>", {})
map('n', '<leader>q', "'q<CR>", {})
map('n', '<leader>f', "'F<CR>", {})
map('n', '<leader>F', "'S<CR>", {})

-- new commands
vim.cmd('command! F Files')
vim.cmd('command! S Rg')
vim.cmd('command! Reload :source ~/.config/nvim/init.lua')
vim.cmd('command! EditConfig :e ~/.config/nvim/init.lua')
vim.cmd('command! Idea :e $HOME/workspace/note/idea.md')

-- conjure
vim.cmd('let g:conjure#mapping#prefix = ","')
