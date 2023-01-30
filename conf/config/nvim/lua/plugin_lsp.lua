local lsp_installer_servers = require('nvim-lsp-installer.servers')

local servers = {
  "bashls",
  "clangd",
  "clojure_lsp",
  "cssls",
  "html",
  "lsqls",
  "pyright",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  -- "rome",
  "tsserver",
  "zls",
}

for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
        server:on_ready(function ()
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
local lspconfig = require('lspconfig')
local manual_servers = {'zls'}
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- require('completion').on_attach()
end
for _, lsp in ipairs(manual_servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
    }
end
