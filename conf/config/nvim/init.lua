-- original
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
  -- dependency and neovim config help
  'nvim-lua/plenary.nvim';
  'rktjmp/lush.nvim';
  'folke/neodev.nvim';

  -- slugbyte
  'slugbyte/unruly-worker';
  'slugbyte/wet-nvim';

  -- general util
  'numToStr/Comment.nvim';
  'christoomey/vim-tmux-navigator';
  'tpope/vim-eunuch';
  'tpope/vim-fugitive';

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

  -- AI
  "zbirenbaum/copilot.lua";

  -- lsp and syntax
  'neovim/nvim-lspconfig';
  'williamboman/mason.nvim';
  'williamboman/mason-lspconfig.nvim';
  'nvim-treesitter/nvim-treesitter';
  'nvim-treesitter/nvim-treesitter-textobjects';
  'nvim-treesitter/nvim-treesitter-context';
  'jose-elias-alvarez/null-ls.nvim';

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
  'olexsmir/gopher.nvim';

  -- lisp
  'jpalardy/vim-slime';
  'windwp/nvim-autopairs';
  'ur4ltz/surround.nvim';
  'slugbyte/paredit.vim';

  -- on pause
  -- 'Olical/conjure';
  -- 'j-hui/fidget.nvim'; TODO use legacy tag
}

-- COMMANDS
-- local telescope_builtin = require('telescope.builtin')
-- function Edit_Config()
--   telescope_builtin.find_files({
--     cwd = '~/.config/nvim',
--     follow = true,
--     hidden = true,
--   })
-- end
-- vim.cmd('command! EditConfig :lua Edit_Config()')
vim.cmd('command! EditConfig :e ~/.config/nvim/init.lua')

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

-- neodev
require("neodev").setup({})

-- COMPLETION
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

-- cmp If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

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
  "rust_analyzer",
  "tsserver",
  "zls",
  "lua_ls",
}

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = lsp_server_list
}

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
lsp_server_list["gopls"] = nil
lsp_server_list["lua_ls"] = nil

for _, server_name in ipairs(lsp_server_list) do
  lspconfig[server_name].setup {
    capabilities,
    on_attach = on_attach,
  }
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  cmd = {"gopls"},
  filetype = {"go", "gomod", "gowork", "gotmpl"},
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
    }
  }
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      diagnostics = {
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true),
          '/opt/homebrew/share/lua/5.4',
          '/opt/homebrew/share/luajit-2.1',
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- GOLANG
require("gopher").setup {
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    impl = "impl",
    iferr = "iferr",
    gotests = "",
    dlv = "",
  },
}

---- COMPLETION

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

-- LISP
vim.g.slime_target = "tmux"
vim.g.paredit_smartjump = 1
vim.cmd('au FileType fennel call PareditInitBuffer()')
vim.cmd('au FileType clojure call PareditInitBuffer()')
vim.cmd('au FileType clojurescript call PareditInitBuffer()')

-- NU
require'nu'.setup{}

require'nvim-treesitter.configs'.setup ({
  modules = {},
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "zig", "sql", "typescript", "glsl", "http", "clojure"},
  ignore_install = {},
  sync_install = false,
  auto_install = false,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  highlight = {
    enable = true,
    disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer part of a loop" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a loop" },
        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
        ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
        ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
        ["as"] = { query = "@class.outer", desc = "Select the outr part of a class region"},
        ["is"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["aa"] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
        ["ia"] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
        ["ac"] = { query = "@call.outer", desc = "Select outer part of a function call" },
        ["ic"] = { query = "@call.inner", desc = "Select inner part of a function call" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = false,
    },
     move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [")c"] = { query = "@call.outer", desc = "Next function call start" },
          [")f"] = { query = "@function.outer", desc = "Next method/function def start" },
          [")s"] = { query = "@class.outer", desc = "Next class start" },
          [")i"] = { query = "@conditional.outer", desc = "Next conditional start" },
          [")l"] = { query = "@loop.outer", desc = "Next loop start" },
        },
        goto_previous_start = {
          ["(c"] = { query = "@call.outer", desc = "Prev function call start" },
          ["(f"] = { query = "@function.outer", desc = "Prev method/function def start" },
          ["(s"] = { query = "@class.outer", desc = "Prev class start" },
          ["(i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
          ["(l"] = { query = "@loop.outer", desc = "Prev loop start" },
        },
      },
  },
})

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 10, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 5, -- Maximum number of lines to show for a single context
  trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

vim.cmd("hi TreesitterContext gui=underline guibg=#123312")
vim.cmd("hi TreesitterContextLineNumber gui=underline guibg=#123312")

require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<C-q>",
      accept_word = false,
      accept_line = false,
      next = "<leader>cn",
      prev = "<leader>cp",
      dismiss = "<esc>",
    },
  },
  filetypes = {
    go = true,
    c = true,
    ["*"] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

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

map('n', '<leader>gj', ":GoTagAdd json<CR>", {desc = "add json tags to go struct"})
map('n', '<leader>gi', ":GoImpl ", {desc = "add impl"})
map('n', '<leader>ge', ":GoIfErr<CR>", {desc = "add if err return err"})

-- tmux
map('n', '<C-n>', ":TmuxNavigateDown<CR>", { silent = true , desc = "tmux down"})
map('n', '<C-e>', ":TmuxNavigateUp<CR>", { silent = true , desc = "tmux up"})
map('n', '<C-o>', ":TmuxNavigateRight<CR>", { silent = true, desc = "tmux right"})
map('n', '<C-y>', ":TmuxNavigateLeft<CR>", { silent = true , desc = "tmux left"})

-- surround
map("n", '<leader>sr', "<Plug>SurroundReplace", {})
map("n", '<leader>sd', "<Plug>SurroundDelete", {})
map("v", '<leader>s', "<Plug>SurroundAddVisual", {})

-- telescope
map('', 'j', ":Telescope find_files<CR>", { noremap = true, desc = "t find files"})
map('', 'J', ":Telescope live_grep<CR>", { noremap = true, desc = "t grep"})
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').registers, { desc = 'Search registers' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = 'Search lsp lsp_references' })
vim.keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_implementations, { desc = 'Search lsp_implementations' })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = 'Search old files' })
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>f/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- conjure
vim.keymap.set('n', '<leader>,', ":ConjureEvalRootForm<CR>", { desc = 'Eval Root Form' })
vim.cmd('let g:conjure#mapping#prefix = ","')

-- jump scroll
map('', '@', "zt", { noremap = true })
map('', '$', "zz", { noremap = true })
map('', '#', "zb", { noremap = true })

-- lsp
map('', '&', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- inc/dec number
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- tree sitter
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
vim.keymap.set({ "n", "x", "o" }, "}", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, "{", ts_repeat_move.repeat_last_move_opposite)

-- clear line
vim.cmd("imap <c-u> <esc>ddi")

-- copilot
--vim.cmd("let g:copilot_filetypes = { '*' : false }")
-- vim.cmd("let g:copilot_no_tab_map = v:true")
-- vim.cmd("let g:copilot_enabled = v:false")
-- vim.cmd('imap <silent><script><expr> <C-q> copilot#Accept("\\<CR>")')
