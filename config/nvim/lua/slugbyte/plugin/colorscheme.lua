return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    dev = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
        "https://github.com/norcalli/nvim-colorizer.lua",
    },
    init = function()
        -- set colorscheme
        local lackluster = require("lackluster")
        lackluster.dev.create_usrcmds()

        lackluster.setup({
            tweak_ui = {
                disable_undercurl = true,
                enable_end_of_buffer = true,
            },
            tweak_highlight = {
                -- FloatBorder = {
                --     fg = lackluster.color.gray5,
                --     bg = lackluster.color_special.main_background,
                -- },
                ["@keyword"] = {
                    italic = true,
                },
                ["spellcap"] = {
                    overwrite = true,
                    link = "normal",
                    undercurl = false,
                },
                ["@function.builtin.javascript"] = {
                    fg = lackluster.color.orange,
                },
                ["@function.builtin.typescript"] = {
                    fg = lackluster.color.orange,
                },
                ["@module.builtin.javascript"] = {
                    fg = lackluster.color.orange,
                },
                ["@module.builtin.typescript"] = {
                    fg = lackluster.color.orange,
                },
            },
        })
        require("colorizer").setup({
            ["*"] = {
                names = false,
            },
        })
        vim.cmd.colorscheme("lackluster-hack")
    end,
}
