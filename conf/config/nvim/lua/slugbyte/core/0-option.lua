vim.g.tmux_navigator_no_mappings = 1
vim.g.is_bash = true
vim.opt.encoding = "utf-8"
vim.opt.backspace = "indent,eol,start"
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.foldenable = false
vim.opt.laststatus = 2
vim.opt.foldnestmax = 4
vim.opt.encoding = "utf8"
vim.opt.showbreak = "+++ "
vim.opt.foldmethod = "indent"
vim.opt.completeopt = "menu"
vim.opt.wildmode = "list:longest"
vim.opt.wildmenu = true
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = " " }
vim.opt.inccommand = "split"
vim.opt.hlsearch = true
-- vim.g.loaded_matchit = true
-- vim.g.loaded_netrwPlugin = true

-- TODO move to keymaps
-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
pcall(vim.colorscheme, 'wet')

-- vim.cmd("hi DiagnosticWarn guifg=#2a2a2a")
-- vim.cmd("hi DiagnosticSignWarn guifg=#2a2a2a")
-- vim.cmd("hi DiagnosticSignWarn guibg=#555555")

vim.cmd("autocmd FileType markdown setlocal wrap")
vim.cmd("autocmd FileType markdown setlocal textwidth=80")
vim.cmd("autocmd FileType markdown setlocal linebreak")
vim.cmd("autocmd FileType markdown setlocal spell")
vim.cmd("autocmd FileType text setlocal spell")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command("UnrulyUpdate",
  function()
    vim.cmd(":Lazy update unruly-worker")
  end,
  {})

vim.api.nvim_create_user_command("PluginAdd",
  function(opt)
    -- local name = vim.fn.input("name: ")
    local name = opt.args
    vim.cmd(string.format(":e ~/.config/nvim/lua/slugbyte/plugin/%s.lua", name))
  end,
  { nargs = 1 }
)
