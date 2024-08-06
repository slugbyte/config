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
            tweak_color = {
                -- lack = "#aaaa77",
            },
            tweak_syntax = {
                -- comment = lackluster.color.green,
            },
            tweak_background = {
                -- normal = 'none',       -- main background
                -- telescope = 'default', -- main background
            },
        })
        vim.cmd.colorscheme("lackluster-hack")

        local make_bold = function(name)
            -- local value = vim.api.nvim_get_hl(0, { name = name })
            -- value.bold = true
            -- vim.api.nvim_set_hl(0, name, value)
        end

        local make_italic = function(name)
            local value = vim.api.nvim_get_hl(0, { name = name })
            value.italic = true
            vim.api.nvim_set_hl(0, name, value)
        end

        make_bold("@keyword")
        make_italic("@keyword")

        -- vim.api.nvim_set_hl(0, "@function.call.lua", {
        -- 	bold = true,
        -- })

        vim.api.nvim_set_hl(0, "spellcap", {
            link = "normal",
            undercurl = false,
        })
        -- load colorscheme dev tools
        local lackluster_dev = require("lackluster.dev")
        lackluster_dev.create_usrcmds()
        lackluster_dev.try_fg("@function.builtin.javascript", "orange")
        lackluster_dev.try_fg("@function.builtin.typescript", "orange")
        lackluster_dev.try_fg("@module.builtin.typescript", "orange")
        lackluster_dev.try_fg("@module.builtin.javascript", "orange")
        -- lackluster_dev.try_fg("headline", "blue")
    end,
}
