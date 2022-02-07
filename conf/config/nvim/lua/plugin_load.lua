-- bootstrap paq
local paq_install_path = vim.fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if vim.fn.empty(vim.fn.glob(paq_install_path)) > 0 then
    vim.cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..paq_install_path)
end

-- plugin list
require('paq') {
  -- dependency
  'nvim-lua/plenary.nvim';
  'rktjmp/lush.nvim';

  -- slugbyte
  'slugbyte/unruly-worker';
  'slugbyte/wet-vim';

  -- general util
  'christoomey/vim-tmux-navigator';
  'norcalli/nvim-colorizer.lua';
  'numToStr/Comment.nvim';
  'tpope/vim-eunuch';
  'junegunn/fzf.vim';
  'junegunn/fzf';
  'windwp/nvim-autopairs';
  "blackCauldron7/surround.nvim";

  -- completion
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-nvim-lua';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';

  -- lsp and syntax
  'neovim/nvim-lspconfig';
  'williamboman/nvim-lsp-installer';
  'nvim-treesitter/nvim-treesitter';
  'jose-elias-alvarez/null-ls.nvim';

  -- status
  'nvim-lualine/lualine.nvim';
  'lewis6991/gitsigns.nvim';
  -- 'airblade/vim-gitgutter'; -- REPLACE WITH gitsigns.nvim

  -- syntax
  'clojure-vim/clojure.vim';
  'leafgarland/typescript-vim';
  'MaxMEllon/vim-jsx-pretty';
  'bakpakin/fennel.vim';
  'rust-lang/rust.vim';
  'cespare/vim-toml';

  -- lisp util
  'Olical/conjure';
  'vim-scripts/paredit.vim';
}
