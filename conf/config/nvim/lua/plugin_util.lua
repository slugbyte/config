require('nvim-autopairs').setup{}
vim.cmd('au FileType fennel call PareditInitBuffer()')
require'colorizer'.setup()
require'Comment'.setup()
require'gitsigns'.setup{}
require("nvim-surround").setup()


-- require'surround'.setup {
--   context_offset = 100,
--   load_autogroups = false,
--   space_on_closing_char = false,
--   load_keymaps = false,
--   map_insert_mode = false,
--   quotes = {"'", '"', '`'},
--   brackets = {"(", '{', '['},
--   pairs = {
--     nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
--     linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } }
--   },
-- }
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = 'all',
--   sync_install = false,
--   highlight = {
--     enable = true,
--   }
-- }
