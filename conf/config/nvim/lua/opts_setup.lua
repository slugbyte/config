vim.o.encoding = 'utf-8'
vim.o.backspace = 'indent,eol,start'
vim.o.swapfile = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.incsearch = true
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.ignorecase = true
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.foldenable = false
vim.o.laststatus = 2
vim.o.foldnestmax = 4
vim.o.encoding = 'utf8'
vim.o.showbreak = '+++ '
vim.o.foldmethod = 'indent'
vim.o.completeopt = 'menu'
vim.o.wildmode = 'list:longest'
vim.o.wildmenu = true
vim.o.colorcolumn = '80'
vim.o.clipboard = 'unnamedplus'
vim.o.wrap = false
vim.o.undofile = true
vim.o.undodir = os.getenv('XDG_CACHE_HOME') .. '/nvim_undo'
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.g.is_bash = true
vim.o.termguicolors = true
vim.wo.signcolumn = 'yes'
vim.cmd('colorscheme wet')

vim.g.blamer_delay = 500
vim.g.blamer_date_format = '%y-%m-%d'
vim.g.blamer_enabled = 1
vim.g.blamer_relative_time = 1

vim.cmd('autocmd FileType markdown setlocal wrap')
vim.cmd('autocmd FileType markdown setlocal textwidth=80')
vim.cmd('autocmd FileType markdown setlocal linebreak')
vim.cmd('autocmd FileType markdown setlocal spell')
vim.cmd('autocmd FileType text setlocal spell')

-- auto remove trailing whitespace
-- vim.cmd('autocmd BufWritePre * :%s/\\s\\+$//e|norm!`` ')
