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
    },
    config = function()
        local mason = require("mason")
        -- local mason_lsp_config = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local lsp_config = require("lspconfig")
        local define = require("slugbyte.define")

        local client_capabilities = vim.lsp.protocol.make_client_capabilities()
        local cmp_nvim_capabilities = cmp_nvim_lsp.default_capabilities()
        client_capabilities = vim.tbl_deep_extend("force", client_capabilities, cmp_nvim_capabilities)

        require("neodev").setup()
        require("fidget").setup({})
        mason.setup()

        local handle_on_attach = function(client, bufnr)
            vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {
                buf = bufnr,
            })
        end

        local lsp_servers = {
            rust_analyzer = {},
            bashls = {},
            clangd = {},
            html = {},
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
                        runtime = {
                            version = "LuaJIT",
                            path = define.runtime_path,
                        },
                        diagnostics = {
                            disable = { "missing-fields" },
                            globals = { "vim" }, -- Avoid 'undefined global vim'
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            },
            zls = {
                capabilities = {
                    offsetEncoding = { "utf-8" },
                },
                settings = {
                    zls = {
                        enable_snippets = true,
                        enable_autofix = false,
                        inlay_hints_exclude_single_argument = true,
                        inlay_hints_hide_redundant_param_names = false,
                        inlay_hints_hide_redundant_param_names_last_token = false,
                        inlay_hints_show_builtin = false,
                        inlay_hints_show_parameter_name = false,
                        inlay_hints_show_struct_literal_field_type = false,
                        inlay_hints_show_variable_type_hints = false,
                        warn_style = false,
                    },
                },
            },
        }

        for server_name, server_config in pairs(lsp_servers) do
            local server_capabilities = server_config.capabilities or {}
            lsp_config[server_name].setup(vim.tbl_deep_extend("force", server_config, {
                capabilities = vim.tbl_deep_extend("force", client_capabilities, server_capabilities),
                on_attach = handle_on_attach,
            }))
        end

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
