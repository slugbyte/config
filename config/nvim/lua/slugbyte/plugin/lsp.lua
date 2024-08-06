-- lspconfig helsp to easily configure diffrent lsp servers
-- https://github.com/neovim/nvim-lspconfig/tree/master
--
-- mason installs and configures lsp servers
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/williamboman/WhoIsSethDaniel/mason-tool-installer.nvim
--
-- neodev helps configure lsp to work well with neovim apis
-- https://github.com/folke/neodev.nvim
--
-- fidget is just a pretty ui to help keep track of what lsp biz is goin on
-- https://github.com/j-hui/fidget.nvim
--
-- JSON schemas for Neovim
-- https://github.com/b0o/SchemaStore.nvim

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
        "b0o/schemastore.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_installer = require("mason-tool-installer")
        local mason_lsp_config = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local lsp_config = require("lspconfig")

        require("neodev").setup()
        require("fidget").setup({})

        local mason_servers = {
            bashls = {},
            clangd = {},
            clojure_lsp = {},
            html = {},
            stylua = {},
            tailwindcss = {},
            tsserver = {},
            yamlls = {},
            rescriptls = {},
            jsonls = {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            },
            gopls = {
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                    },
                },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                        diagnostics = { disable = { "missing-fields" } },
                    },
                },
            },
        }

        local handle_on_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, bufnr)
            end
            vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {
                buf = bufnr,
            })
        end

        local client_capabilities = vim.lsp.protocol.make_client_capabilities()
        local cmp_nvim_capabilities = cmp_nvim_lsp.default_capabilities()
        client_capabilities = vim.tbl_deep_extend("force", client_capabilities, cmp_nvim_capabilities)

        mason.setup()
        mason_installer.setup({ ensure_installed = vim.tbl_keys(mason_servers or {}) })
        mason_lsp_config.setup({
            handlers = {
                function(server_name)
                    local server = mason_servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, client_capabilities, server.capabilities or {})

                    -- DISABLE highlighting
                    -- server.capabilities.semanticTokensProvider = nil

                    server.on_attach = handle_on_attach
                    lsp_config[server_name].setup(server)
                end,
            },
        })

        local zls_config = {}
        zls_config.capabilities = client_capabilities
        zls_config.on_attach = handle_on_attach
        lsp_config.zls.setup(zls_config)

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client ~= nil then
                    client.server_capabilities.semanticTokensProvider = nil
                end
            end,
        })
    end,
}
