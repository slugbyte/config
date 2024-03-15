local keymap = vim.keymap

vim.g.mapleader = ' '
vim.g.local_leader = ' '

-- SAVE AND QUIT
keymap.set('n', '<leader>q', "'qall<CR>",     { desc = "quit all" })
keymap.set('n', '<leader>w',
function()
  vim.cmd("silent! wall")
  print("[write all]", string.sub(math.random() .. "", -4, -1))
end, {
  expr = true,
  desc = "save all files",
})

-- BUFFER NAV
keymap.set('n', '<leader>n', "'n<CR>",        { desc = "next buffer" })
keymap.set('n', '<leader>p', "'prev<CR>",     { desc = "prev buffer" })

-- SPLIT SCREEN
keymap.set('', '<leader>sf', ':on<CR>',       { desc = "split fullscreen" })
keymap.set('', '<leader>sx', ':close<CR>',    { desc = "split close" })
keymap.set('', '<leader>sh', ':vs<CR>',       { desc = "split horizontal" })
keymap.set('', '<leader>sv', ':sp<CR>',       { desc = "split verticle" })

-- ALIGN CURRENT LINE
keymap.set('', '@', "zt", { noremap = true, desc = "move current line to top of window"})
keymap.set('', '$', "zz", { noremap = true, desc = "move current line to middle of window"})
keymap.set('', '#', "zb", { noremap = true, desc = "move current line to bottom of window"})

-- OTHER
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement
vim.keymap.set("i", "<c-u>", "<esc>ddi",  { desc = "Delete current line" }) -- decrement

print("keymaps loaded")
