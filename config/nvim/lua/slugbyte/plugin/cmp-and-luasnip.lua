-- nvim-cmp is the auto completion engine
-- https://github.com/hrsh7th/nvim-cmp
-- nvim-cmp sources are used to provide things to auto complte
-- * https://github.com/hrsh7th/cmp-nvim-lsp
-- * https://github.com/hrsh7th/cmp-cmdline
-- * https://github.com/hrsh7th/cmp-buffer
-- * https://github.com/hrsh7th/cmp-emoji
-- * https://github.com/hrsh7th/cmp-path
-- * https://github.com/hrsh7th/cmp-git
--
-- luasnip is a powerful snippet engine
-- * https://github.com/L3MON4D3/LuaSnip
-- * https://github.com/saadparwaiz1/cmp_luasnip
--
-- HOW TO FORMAT LONG MENU ITEMS:
-- https://github.com/hrsh7th/nvim-cmp/issues/1154

return {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    dependencies = {
        "slugbyte/unruly-worker",
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        {
            "petertriho/cmp-git",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local unruly_cmp = require("unruly-worker.external.nvim-cmp")

        luasnip.config.setup({})

        cmp.setup({
            window = {
                completion = vim.tbl_extend("force", cmp.config.window.bordered(), {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                }),
                documentation = vim.tbl_extend("force", cmp.config.window.bordered(), {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                }),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },
            -- completion = { completeopt = "menu,menuone,noselect" },
            mapping = unruly_cmp.create_insert_mapping({
                -- skip_list = { "<Right>" },
                -- mapping = {
                -- 	["<Up>"] = cmp.mapping.confirm(),
                -- },
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
        })

        cmp.setup.filetype("zig", {
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = nil
                    return vim_item
                end,
            },
        })

        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" },
                { name = "buffer" },
                { name = "path" },
            }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = unruly_cmp.create_cmdline_mapping(),
            sources = cmp.config.sources({
                { name = "buffer" },
                { name = "nvim_lsp" },
            }),
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = unruly_cmp.create_cmdline_mapping(),
            sources = cmp.config.sources({
                { name = "cmdline" },
                { name = "path" },
            }),
        })

        require("cmp_git").setup()
    end,
}
