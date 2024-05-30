vim.g.mapleader = " "
vim.g.local_leader = " "
vim.opt.runtimepath:append(',~/workspace/code/learn/learn-lua/nvim')

vim.opt.scrolloff = 4
vim.opt.shiftwidth = 4
-- vim.opt.scrolloff = 0  -- 5
-- vim.opt.shiftwidth = 0 -- 4
vim.opt.colorcolumn = "100"
-- vim.opt.colorcolumn = "85"

vim.g.is_bash = true
vim.g.tmux_navigator_no_mappings = 1
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 4
vim.opt.hlsearch = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = " " }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showbreak = "**"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = false
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.wrap = false
