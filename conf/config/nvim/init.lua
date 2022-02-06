-- alias
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.opt
local map = vim.api.nvim_set_keymap

-- bootstrap paq
local paq_install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if fn.empty(fn.glob(paq_install_path)) > 0 then
    cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..paq_install_path)
end

-- plugins
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

-- settings
require('nvim-autopairs').setup{}

-- settings
HOME = os.getenv('HOME')
XDG_CACHE_HOME = os.getenv('XDG_CACHE_HOME')

-- o.spell = true
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
cmd('colorscheme wet')

-- highlight
cmd('highlight ExtraWhitespace ctermbg=240')
cmd('match ExtraWhitespace /\\s\\+$/')

-- new commands
cmd('command! F Files')
cmd('command! S Rg')
cmd('command! Reload :source ~/.config/nvim/init.lua')
cmd('command! EditConfig :e ~/.config/nvim/init.lua')

function Highlight_toggle()
  if vim.o.hlsearch then
    print("highlight off")
    vim.o.hlsearch = false
  else
    print("highlight on")
    vim.o.hlsearch = true
  end
end

cmd('command! HighlightToggle :lua Highlight_toggle()')
function Ignorecase_toggle ()
  if vim.o.ignorecase then
    print("ignorecase off")
    vim.o.ignorecase = false
  else
    print("ignorecase on")
    vim.o.ignorecase = true
  end
end

cmd('command! IgnorecaseToggle :lua Ignorecase_toggle()')

function Pastemode_toggle()
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

cmd('command! PastemodeToggle :lua Pastemode_toggle()')

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
cmd('autocmd FileType text setlocal spell')

-- wilder menu
-- cmd("call wilder#setup({'modes': [':', '/', '?']})")

-- spellcheck
-- map('n', '<leader>s', '<Plug>(coc-codeaction-selected)aw', {})
-- map('n', '<leader>S', "'CocCommand cSpell.addWordToUserDictionnary<cr>", {})

-- shorthand
map('n', '<leader>w', "'w<CR>", {})
map('n', '<leader>q', "'q<CR>", {})
map('n', '<leader>f', "'F<CR>", {})
map('n', '<leader>F', "'S<CR>", {})

-- conjure
cmd('let g:conjure#mapping#prefix = ","')

-- fennel
cmd('au FileType fennel call PareditInitBuffer()')

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

-- auto show colors
require'colorizer'.setup()

-- cpm
local cmp = require'cmp'
cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources(
    { { name = 'buffer' }, },
    { { name = 'nvim_lsp' }, },
    { { name = 'nvim_lua' }, },
    { { name = 'path' }, }
  )
})

-- cmp Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- cmp Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- cmp Setup lspconfig.
require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- cmp If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


-- SETUP LSP
local lsp_installer_servers = require('nvim-lsp-installer.servers')

local servers = {
  "bashls",
  "clangd",
  "clojure_lsp",
  "cssls",
  "html",
  "pyright",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "tsserver",
}

-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
        server:on_ready(function ()
            -- When this particular server is ready (i.e. when installation is finished or the server is already installed),
            -- this function will be invoked. Make sure not to use the "catch-all" lsp_installer.on_server_ready()
            -- function to set up servers, to avoid doing setting up a server twice.

            if server_name == "sumneko_lua" then
              server:setup({
                settings = {
                  Lua = {
                    diagnostics = {globals = {'vim'}}
                  }
                },
              })
            else
              local opts = {}
              server:setup(opts)
            end

        end)
        if not server:is_installed() then
            -- Queue the server to be installed.
            server:install()
        end
    end
end

-- null-ls
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.completion.spell.with({
          filetypes = {"text", "markdown"}
        })
        -- TODO write a tool for cspell that auto adds words to a user dictionarry
        -- null_ls.builtins.diagnostics.cspell.with({
        --   command = "cspell",
        --   filetypes = {"text", "markdown", "lua"},
        --   args  = {"--config", HOME .. "/.cspell.json", "stdin"}
        -- }),
    },
})

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  sync_install = false,
  highlight = {
    enable = true,
  }
}

-- comment
require'Comment'.setup()

-- surround
require"surround".setup {
  context_offset = 100,
  load_autogroups = false,
  space_on_closing_char = false,
  load_keymaps = false,
  map_insert_mode = false,
  quotes = {"'", '"', '`'},
  brackets = {"(", '{', '['},
  pairs = {
    nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
    linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } }
  },
}

map("n", '<leader>r', "<Plug>SurroundReplace", {})
map("n", '<leader>d', "<Plug>SurroundDelete", {})
map("v", '<leader>s', "<Plug>SurroundAddVisual", {})

-- git signs
require'gitsigns'.setup{}
