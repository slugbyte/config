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
local xdg_cache_home = os.getenv('XDG_CACHE_HOME') 
if (xdg_cache_home)
then
  vim.o.undodir = xdg_cache_home .. '/nvim_undo'
end
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.g.is_bash = true
vim.o.termguicolors = true
vim.wo.signcolumn = 'yes'
vim.cmd('colorscheme adwaita')
vim.cmd('hi DiagnosticWarn guifg=#2a2a2a')
vim.cmd('hi DiagnosticSignWarn guifg=#2a2a2a')
vim.cmd('hi DiagnosticSignWarn guibg=#555555')
