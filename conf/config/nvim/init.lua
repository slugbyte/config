-- plugin
require "paq" {
  'nvim-lua/plenary.nvim';
  {'slugbyte/unruly-worker', branch = 'stage-3'};
  'cespare/vim-toml';
  'leafgarland/typescript-vim';
  'christoomey/vim-tmux-navigator';
  'tpope/vim-eunuch';
  'tpope/vim-commentary';
  {'neoclide/coc.nvim', branch = 'release'};
  'junegunn/fzf.vim';
  'airblade/vim-gitgutter';
  'nvim-lualine/lualine.nvim';
  'itchyny/vim-gitbranch';
  'slugbyte/yuejiu';
}

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'everforest',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = { 'branch', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  }
}

HOME = os.getenv("HOME")
XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME")

vim.o.encoding = "utf-8"
vim.o.backspace = "indent,eol,start"
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
vim.o.encoding = "utf8"
vim.o.showbreak = "+++ "
vim.o.foldmethod = "indent"
vim.o.completeopt = "menu"
vim.o.wildmode = "list:longest"
vim.o.wildmenu = true
vim.o.colorcolumn = "80"
vim.o.clipboard = "unnamedplus"
vim.o.wrap = false
vim.o.undofile = true
vim.o.undodir = XDG_CACHE_HOME .. "/nvim_undo"
vim.o.hlsearch = false
vim.g.is_bash = true
vim.wo.signcolumn = 'yes'

vim.highlight.ExtraWhitespace = {
  ctermbg = 197
}

vim.cmd('colorscheme yuejiu')
vim.cmd('highlight ExtraWhitespace ctermbg=240')
vim.cmd('match ExtraWhitespace /\\s\\+$/')
  -- use 'cespare/vim-toml'
  -- use 'leafgarland/typescript-vim'

  -- use 'christoomey/vim-tmux-navigator'

  -- use 'tpope/vim-eunuch'

  -- use 'tpope/vim-commentary'

  -- use {
  --   'neoclide/coc.nvim', 
  --   branch = 'release'
  -- }

  -- use 'junegunn/fzf.vim'


-- set ruler                  "  show the cursor position in the status bar
-- set noswapfile             "  no more swap files
-- set nobackup               "  don't create backups before overwrite
-- set number relativenumber  "  hybrid relative number
-- set mouse=a                "  allow the mouse to interact with vim
-- set autoread               "  when you run checktime it will refresh the file
-- set incsearch              "  vim starts searching while typing search string
-- set tabstop=2              "  make \t appear to be two spaces wide
-- set expandtab              "  convert tab to spaces (unless a filetype plugin changes that)
-- set ignorecase             "  non-case sensitive search 
-- set smartcase              " ignorecase unless the search uses uppercase
-- set cursorline             "  highlight the line current cursor line
-- set shiftwidth=2           "  make vim indent functions apply or remove two spaces
-- set backspace=2            "  make backspace 
-- set scrolloff=5            "  when scrolling up keep 5 lines of code at the top of the screen
-- set nofoldenable           "  stop vim from folding indent levels when opening a file
-- set laststatus=2           "  show the status line
-- set foldnestmax=4          "  don't fold more than four levels deep
-- set encoding=utf8          "  treat all text as utf-8
-- set showbreak="+++ "       "  mark the lines that overflow screen width using +++
-- set foldmethod=indent      "  fold and unfold text based on indent level
-- set completeopt-=preview   "  stop plugins from adding a docs window on tab completion
-- set wildmode=list:longest  "  configure tab completion to list all matches when there is more than one
-- set wildmenu               "  enable tab completion in the command bar
-- set colorcolumn=80         "  enable a visible column on the 80th char -(see)->
-- set clipboard=unnamedplus  "  use tes system clipboard for copy and paste
-- set nowrap                 "  don't wrap lines around
-- set undofile               "  always keep an undo histroy
-- set undodir=~/.local/slugbyte/nvim_undo
-- let g:is_bash=1            "  treat .sh files as bash scripts
-- set nohlsearch

