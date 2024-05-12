-- lazy config

require("slugbyte")

vim.opt.runtimepath:append(',~/workspace/code/learn/learn-lua/nvim')


--[[
-- neovim tips
-- run `:checkhealth` to check if things are working
--
-- lua & neovim scripting resources
--
-- * https://learnxinyminutes.com/docs/lua/
-- * https://neovim.io/doc/user/lua-guide.html
-- * run `:help lua-guide`
-- * run `:help lua-guide-autocommands`
--]]

-- scratchpad
-- diagnostic stuff
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
--
-- snippet ideas
-- https://github.com/rafamadriz/friendly-snippets


-- "zbirenbaum/copilot.lua";
-- 'nvim-lualine/lualine.nvim';
-- 'clojure-vim/clojure.vim';
-- 'leafgarland/typescript-vim';
-- 'MaxMEllon/vim-jsx-pretty';
-- 'bakpakin/fennel.vim';
-- 'rust-lang/rust.vim';
-- 'cespare/vim-toml';
-- 'ziglang/zig.vim';
-- 'LhKipp/nvim-nu';
-- 'olexsmir/gopher.nvim';
-- https://github.com/julienvincent/nvim-paredit
