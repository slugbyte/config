return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    dev = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
        -- set colorscheme
        local lackluster = require("lackluster")
        lackluster.setup({
            tweak_ui = {
                disable_undercurl = true,
                enable_end_of_buffer = true,
            },
            tweak_highlight = {
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
        vim.cmd.colorscheme("lackluster")
    end,
}
