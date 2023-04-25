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
  "sqls",
  "tsserver",
  "zls",
}

require("mason").setup()

require("mason-lspconfig").setup {
  ensure_installed = lsp_server_list
}

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- TODO setup lsp keybindings here instead of keymap.lua
end
local lspconfig = require("lspconfig")
for _, server_name in ipairs(lsp_server_list) do
  lspconfig[server_name].setup {
    on_attach = on_attach,
  }
end
