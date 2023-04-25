-- bootstrap paq
-- local paq_install_path = vim.fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'
--
-- if vim.fn.empty(vim.fn.glob(paq_install_path)) > 0 then
--     vim.cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..paq_install_path)
-- end
--
-- set disable globals
vim.g.tmux_navigator_no_mappings = 1

-- plugin list
require('paq') {
  -- dependency
  'nvim-lua/plenary.nvim';
  'rktjmp/lush.nvim';
  'folke/neodev.nvim';
  -- 'APZelos/blamer.nvim';

  -- slugbyte
  'slugbyte/unruly-worker';
  'slugbyte/wet-nvim';

  -- colorscheme
  'sainnhe/everforest';

  -- general util
  'christoomey/vim-tmux-navigator';
  'norcalli/nvim-colorizer.lua';
  'numToStr/Comment.nvim';
  'tpope/vim-eunuch';
  'jpalardy/vim-slime';
  'tpope/vim-fugitive';

  -- 'junegunn/fzf.vim';
  -- 'junegunn/fzf';
  'nvim-telescope/telescope.nvim';
  'windwp/nvim-autopairs';
  'ur4ltz/surround.nvim';

  -- completion
  -- 'L3MON4D3/LuaSnip';
  -- 'saadparwaiz1/cmp_luasnip';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-nvim-lua';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/nvim-cmp';

  -- lsp and syntax
  'neovim/nvim-lspconfig';
  'williamboman/mason.nvim';
  'williamboman/mason-lspconfig.nvim';
  'j-hui/fidget.nvim';
  -- 'williamboman/nvim-lsp-installer';
  'jose-elias-alvarez/null-ls.nvim';
  -- 'nvim-treesitter/nvim-treesitter';

  -- status
  'nvim-lualine/lualine.nvim';
  'lewis6991/gitsigns.nvim';

  -- syntax
  'clojure-vim/clojure.vim';
  'leafgarland/typescript-vim';
  'MaxMEllon/vim-jsx-pretty';
  'bakpakin/fennel.vim';
  'rust-lang/rust.vim';
  'cespare/vim-toml';
  'ziglang/zig.vim';

  -- lisp util
   'Olical/conjure';
  'slugbyte/paredit.vim';
  'tpope/vim-fireplace';
  -- 'github/copilot.vim';
}
