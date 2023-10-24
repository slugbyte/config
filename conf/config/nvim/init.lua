-- vim globals
vim.g.tmux_navigator_no_mappings = 1
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
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.g.is_bash = true
vim.o.termguicolors = true
vim.wo.signcolumn = 'yes'
vim.cmd('colorscheme wet')
vim.cmd('hi DiagnosticWarn guifg=#2a2a2a')
vim.cmd('hi DiagnosticSignWarn guifg=#2a2a2a')
vim.cmd('hi DiagnosticSignWarn guibg=#555555')
local xdg_cache_home = os.getenv('XDG_CACHE_HOME') 
if (xdg_cache_home)
then
  vim.o.undodir = xdg_cache_home .. '/nvim_undo'
end

vim.cmd('autocmd FileType markdown setlocal wrap')
vim.cmd('autocmd FileType markdown setlocal textwidth=80')
vim.cmd('autocmd FileType markdown setlocal linebreak')
vim.cmd('autocmd FileType markdown setlocal spell')
vim.cmd('autocmd FileType text setlocal spell')

-- PACKAGE IMPORTS
require('paq') {
  -- dependency
  'nvim-lua/plenary.nvim';
  'rktjmp/lush.nvim';
  'folke/neodev.nvim';

  -- slugbyte
  'slugbyte/unruly-worker';
  'slugbyte/wet-nvim';

  -- general util
  'tpope/vim-eunuch';
  'tpope/vim-fugitive';
  'christoomey/vim-tmux-navigator';
  'numToStr/Comment.nvim';


  -- completion
  'L3MON4D3/LuaSnip';
  'nvim-telescope/telescope.nvim';
  'saadparwaiz1/cmp_luasnip';
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
  'jose-elias-alvarez/null-ls.nvim';
  'nvim-treesitter/nvim-treesitter';

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
  'LhKipp/nvim-nu';

  -- lisp
  'jpalardy/vim-slime';
  'windwp/nvim-autopairs';
  'ur4ltz/surround.nvim';
  'slugbyte/paredit.vim';
   'Olical/conjure';
  -- on pause
  -- 'j-hui/fidget.nvim'; TODO use legacy tag
  -- 'williamboman/nvim-lsp-installer';
  -- 'nvim-tree/nvim-web-devicons';
  -- 'nvimdev/lspsaga.nvim';
  -- 'tpope/vim-fireplace';
  -- 'github/copilot.vim';
}

-- COMMANDS
local telescope_builtin = require('telescope.builtin')
function Edit_Config()
  telescope_builtin.find_files({
    cwd = '~/.config/nvim',
    follow = true,
    hidden = true,
  })
end
vim.cmd('command! EditConfig :lua Edit_Config()')

function Highlight_Toggle()
  if vim.o.hlsearch then
    print("[highlight off]")
    vim.o.hlsearch = false
  else
    print("[highlight on]")
    vim.o.hlsearch = true
  end
end
vim.cmd('command! HighlightToggle :lua Highlight_Toggle()')

function Ignorecase_Toggle ()
  if vim.o.ignorecase then
    print("[ignorecase off]")
    vim.o.ignorecase = false
  else
    print("[ignorecase on]")
    vim.o.ignorecase = true
  end
end
vim.cmd('command! IgnorecaseToggle :lua Ignorecase_Toggle()')

function Pastemode_Toggle()
  if vim.o.paste then
    print("[paste off]")
    vim.o.paste = false
    vim.o.ruler = false
  else
    vim.o.paste = true
    vim.o.ruler = true
    print("[paste on]")
  end
end
vim.cmd('command! PastemodeToggle :lua Pastemode_Toggle()')
vim.cmd('command! TrimLines :%s/\\s\\+$//e|norm!`` ')
vim.cmd('command! Reload :luafile ~/.config/nvim/init.lua')

---- LSP
local lsp_server_list = {
  "bashls",
  "clangd",
  "clojure_lsp",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "rust_analyzer",
  "tsserver",
}

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = lsp_server_list
}

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local lspconfig = require("lspconfig")
lsp_server_list["lua_ls"] = nil
for _, server_name in ipairs(lsp_server_list) do
  lspconfig[server_name].setup {
    on_attach = on_attach,
  }
end

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

---- COMPLETION
local cmp = require'cmp'
cmp.setup({
  -- snippet = {
  --   expand = function(args)
  --     require('luasnip').lsp_expand(args.body)
  --   end
  -- },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
    { {
        name = 'buffer',
        option =  {
          -- use all loaded buffers
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      }, },
    { { name = 'nvim_lsp' }, },
    { { name = 'path' }, },
    { { name = 'nvim_lua' }, }
    -- { { name = 'luasnip' }, }
  ),
})

cmp.setup.cmdline('/', {
  -- cmp Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  }
})

-- cmp Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- cmp Setup lspconfig. (this breaks the ability to keep suggestions while typing?)
-- require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- cmp If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

require'Comment'.setup()
-- require"fidget".setup{}
require('nvim-autopairs').setup{}
-- require'gitsigns'.setup{}
require'surround'.setup {
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

-- neodev
require("neodev").setup({
  library = {
    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
    -- these settings will be used for your Neovim config directory
    runtime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
  -- for your Neovim config directory, the config.library settings will be used as is
  -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
  -- for any other directory, config.library.enabled will be set to false
  override = function(root_dir, options) end,
  -- With lspconfig, Neodev will automatically setup your lua-language-server
  -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
  -- in your lsp start options
  lspconfig = true,
})

-- paredit
vim.g.slime_target = "tmux"
vim.g.paredit_smartjump = 1
vim.cmd('au FileType fennel call PareditInitBuffer()')

-- copilot
--vim.cmd("let g:copilot_filetypes = { '*' : false }")
vim.cmd("let g:copilot_no_tab_map = v:true")
vim.cmd("let g:copilot_enabled = v:false")

require'nu'.setup{}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query",
  "zig", "sql", "typescript", "glsl", "http", "clojure"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local telescope = require('telescope')
telescope.setup({
  pickers = {
    find_files = {
      find_command = {
        'find_files'
      },
    },
  },
  defaults = {
    layout_strategy = 'flex',
    layout_config = { height = 0.7 },
    mappings = {
      i = {
        -- ["<C-u>"] = "which_key",
      }
    }
  },
})

local wet_lualine = require ('wet').lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = wet_lualine,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode' },
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
    lualine_z = { 'location', 'diagnostics' },
  }
}

local map = vim.api.nvim_set_keymap

-- clear line
vim.cmd("imap <c-u> <esc>ddi")

local unruly_worker = require('unruly-worker')
unruly_worker.setup({
  enable_lsp_map = true,
  enable_select_map = true,
  enable_comment_map = true,
  enable_wrap_navigate = true,
  enable_visual_navigate = true,
  enable_easy_window_navigate = true,
  enable_quote_command = true,
  enable_alt_jump_scroll = true,
})

vim.g.mapleader = ' '
vim.g.local_leader = ' '

-- save all files
function Save()
  vim.cmd("silent! wall")
  print("[write all]", string.sub(math.random() .. "", -4, -1))
end

map('n', '<leader>w', "'lua Save()<CR>", {desc = "save all"})

-- window
map('n', '<leader>q', "'qall<CR>", { desc = "quit all"})
map('n', '<leader>n', "'n<CR>", {desc = "next buffer"})
map('n', '<leader>p', "'prev<CR>", {desc = "prev buffer"})
map('', '<C-g>', ':on<CR>', { desc = "hide all other panes"})

-- tmux
map('n', '<C-n>', ":TmuxNavigateDown<CR>", { silent = true , desc = "tmux down"})
map('n', '<C-e>', ":TmuxNavigateUp<CR>", { silent = true , desc = "tmux up"})
map('n', '<C-o>', ":TmuxNavigateRight<CR>", { silent = true, desc = "tmux right"})
map('n', '<C-y>', ":TmuxNavigateLeft<CR>", { silent = true , desc = "tmux left"})

-- surround
map("n", '<leader>r', "<Plug>SurroundReplace", {})
map("n", '<leader>d', "<Plug>SurroundDelete", {})
map("v", 's', "<Plug>SurroundAddVisual", {})

-- telescope
map('', 'j', ":Telescope find_files<CR>", { noremap = true, desc = "t find files"})
map('', 'J', ":Telescope live_grep<CR>", { noremap = true, desc = "t grep"})
vim.keymap.set('n', '<leader>tf', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>th', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>tw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>tg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>td', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>tb', require('telescope.builtin').registers, { desc = 'Search registers' })
vim.keymap.set('n', '<leader>tr', require('telescope.builtin').lsp_references, { desc = 'Search lsp lsp_references' })
vim.keymap.set('n', '<leader>ti', require('telescope.builtin').lsp_implementations, { desc = 'Search lsp_implementations' })
vim.keymap.set('n', '<leader>to', require('telescope.builtin').oldfiles, { desc = 'Search old files' })
vim.keymap.set('n', '<leader>tk', require('telescope.builtin').keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- conjure
vim.keymap.set('n', '<leader>,', ":ConjureEvalRootForm<CR>", { desc = 'Eval Root Form' })

-- jump scroll
map('', '@', "zt", { noremap = true })
map('', '$', "zz", { noremap = true })
map('', '#', "zb", { noremap = true })

-- lsp
map('', '&', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- conjure
vim.cmd('let g:conjure#mapping#prefix = ","')

-- copilot
vim.cmd('imap <silent><script><expr> <C-q> copilot#Accept("\\<CR>")')
vim.cmd('imap <silent><script><expr> <C-d>s <Plug>(copilot-suggest)')
