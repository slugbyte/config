require'Comment'.setup()
require"fidget".setup{}
require('nvim-autopairs').setup{}
require'gitsigns'.setup{}
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
