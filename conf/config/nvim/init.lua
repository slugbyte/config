-- alias
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.opt
local map = vim.api.nvim_set_keymap

-- plugin
local paq_install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if fn.empty(fn.glob(paq_install_path)) > 0 then
    cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..paq_install_path)
end

require('paq') {
  'nvim-lua/plenary.nvim';
  {'slugbyte/unruly-worker', branch = 'stage-3'};
  'cespare/vim-toml';
  'leafgarland/typescript-vim';
  'christoomey/vim-tmux-navigator';
  'tpope/vim-eunuch';
  'tpope/vim-commentary';
  {'neoclide/coc.nvim', branch = 'release'};
  'junegunn/fzf';
  'junegunn/fzf.vim';
  'airblade/vim-gitgutter'; -- REPLACE WITH gitsigns.nvim
  'nvim-lualine/lualine.nvim';
  'itchyny/vim-gitbranch';
  {'RRethy/vim-hexokinase', run = 'make hexokinase'};
  'rust-lang/rust.vim';
  'gelguy/wilder.nvim';
  'RRethy/vim-hexokinase';
  'Olical/conjure';
  'bakpakin/fennel.vim';
  'tpope/vim-surround';
  'Olical/aniseed';
  'supercollider/scvim';
  'slugbyte/yuejiu';
  'slugbyte/wet-vim';
  'morhetz/gruvbox';
}

cmd('let g:conjure#mapping#prefix = ","')

-- lualine
local wet_lualine = require ('wet').lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = wet_lualine,
    -- theme = 'everforest',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {{
      'filename',
      path = 1,
      file_status = true,
      symbols = {
        modified = ' [+]',
        readonly = ' [readonly]',
        unnamed = '[no name]',
      },
    }},
    lualine_c = {},
    lualine_x = { 'branch', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  }
}

-- settings
HOME = os.getenv('HOME')
XDG_CACHE_HOME = os.getenv('XDG_CACHE_HOME')

o.encoding = 'utf-8'
o.backspace = 'indent,eol,start'
o.swapfile = false
o.number = true
o.relativenumber = true
o.incsearch = true
o.tabstop = 2
o.expandtab = true
o.shiftwidth = 2
o.ignorecase = true
o.cursorline = true
o.scrolloff = 5
o.foldenable = false
o.laststatus = 2
o.foldnestmax = 4
o.encoding = 'utf8'
o.showbreak = '+++ '
o.foldmethod = 'indent'
o.completeopt = 'menu'
o.wildmode = 'list:longest'
o.wildmenu = true
o.colorcolumn = '80'
o.clipboard = 'unnamedplus'
o.wrap = false
o.undofile = true
o.undodir = XDG_CACHE_HOME .. '/nvim_undo'
o.hlsearch = false
o.mouse = 'a'
g.is_bash = true
o.termguicolors = true
vim.wo.signcolumn = 'yes'

cmd("let g:Hexokinase_highlighters = ['backgroundfull']")


cmd('colorscheme wet')
cmd('source ~/.config/nvim/coc.vim')

-- highlight
cmd('highlight ExtraWhitespace ctermbg=240')
cmd('match ExtraWhitespace /\\s\\+$/')

-- new commands
cmd('command! F Files')
cmd('command! S Rg')
cmd('command! Reload :source ~/.config/nvim/init.lua')
cmd('command! EditConfig :e ~/.config/nvim/init.lua')

function highlight_toggle()
  if vim.o.hlsearch then
    print("highlight off")
    vim.o.hlsearch = false
  else
    print("highlight on")
    vim.o.hlsearch = true
  end
end

cmd('command! HighlightToggle :lua highlight_toggle()')

function ignorecase_toggle ()
  if vim.o.ignorecase then
    print("ignorecase off")
    vim.o.ignorecase = false
  else
    print("ignorecase on")
    vim.o.ignorecase = true
  end
end

cmd('command! IgnorecaseToggle :lua ignorecase_toggle()')

function pastemode_toggle()
  if vim.o.paste then
    print("pastemode off")
    vim.o.paste = false
    vim.o.ruler = false
  else
    vim.o.paste = true
    vim.o.ruler = true
    print("pastemode on")
  end
end

cmd('command! PastemodeToggle :lua pastemode_toggle()')

-- keymap
vim.g.mapleader = ' '

-- shift lines up and down
map('n', '<C-Down>', ':m .+1<CR>==', {noremap = true})
map('n', '<C-Up>', ':m .-2<CR>==', {noremap = true})
map('i', '<C-Down>', ':m .+1<CR>==', {noremap = true})
map('i', '<C-Up>', ':m .-2<CR>==', {noremap = true})
map('v', '<C-Down>', ":m '>+1<CR>gv=gv", {noremap = true})
map('v', '<C-Up>', ":m '<-2<CR>gv=gv", {noremap = true})

cmd('autocmd FileType markdown setlocal wrap')
cmd('autocmd FileType markdown setlocal textwidth=80')
cmd('autocmd FileType markdown setlocal linebreak')
cmd('autocmd FileType markdown setlocal spell')

-- wilder menu
cmd("call wilder#setup({'modes': [':', '/', '?']})")

-- spellcheck
map('n', '<leader>s', '<Plug>(coc-codeaction-selected)aw', {})
map('n', '<leader>S', "'CocCommand cSpell.addWordToUserDictionnary<cr>", {})

-- shorthand
map('n', '<leader>c', 'gcc<esc>', {})
map('n', '<leader>w', "'w<CR>", {})
map('n', '<leader>q', "'q<CR>", {})
map('n', '<leader>f', "'F<CR>", {})
map('n', '<leader>F', "'S<CR>", {})
