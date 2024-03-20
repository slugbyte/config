local keymap = vim.keymap
vim.g.mapleader = " "
vim.g.local_leader = " "

-- SAVE AND QUIT
-- keymap.set("n", "<leader>ws", function()
-- 	vim.cmd("silent! wall")
-- 	print("[write all]", string.sub(math.random() .. "", -4, -1))
-- end, {
-- 	expr = true,
-- 	desc = "[W]indow [S]ave all",
-- })
-- keymap.set("n", "<leader>wq", ":qall<CR>", { desc = "[W]indow [Q]uit all" })
--
-- -- BUFFER NAV
-- keymap.set("n", "<leader>wn", "'n<CR>", { desc = "[W]indow [N]ext" })
-- keymap.set("n", "<leader>wp", "'prev<CR>", { desc = "[W]indow [P]rev" })
--
-- -- SPLIT SCREEN
-- keymap.set("", "<leader>wf", ":on<CR>", { desc = "[W]indow [F]ullscreen" })
-- keymap.set("", "<leader>wc", ":close<CR>", { desc = "[W]indow [C]lose " })
-- keymap.set("", "<leader>wh", ":vs<CR>", { desc = "[W]indow [H]orizontal split" })
-- keymap.set("", "<leader>wv", ":sp<CR>", { desc = "[W]indow [V]erticle split" })

-- -- ALIGN CURRENT LINE
-- keymap.set("", "@", "zt", { noremap = true, desc = "move current line to top of window" })
-- keymap.set("", "$", "zz", { noremap = true, desc = "move current line to middle of window" })
-- keymap.set("", "#", "zb", { noremap = true, desc = "move current line to bottom of window" })

-- -- OTHER
-- vim.keymap.set("n", "<leader>ni", "<C-a>", { desc = "[N]umber [I]nc" })    -- increment
-- vim.keymap.set("n", "<leader>nd", "<C-x>", { desc = "[N]umber [D]ec" })    -- decrement

-- c-u should delete line (mostly for command mode)
-- vim.keymap.set("i", "<c-u>", "<esc>ddi", { desc = "Delete current line" }) -- decrement
