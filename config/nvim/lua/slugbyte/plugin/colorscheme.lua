return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    dev = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
        -- set colorscheme
        vim.cmd.colorscheme("lackluster-hack")
        vim.api.nvim_set_hl(0, 'spellcap', {
            link = 'normal',
            undercurl = false,
        })

        -- load colorscheme dev tools
        local lackluster_dev = require("lackluster.dev")
        lackluster_dev.create_usrcmds()
        lackluster_dev.try_fg("@function.builtin.javascript", "orange")
        lackluster_dev.try_fg("@function.builtin.typescript", "orange")
        lackluster_dev.try_fg("@module.builtin.typescript", "orange")
        lackluster_dev.try_fg("@module.builtin.javascript", "orange")
        -- lackluster_dev.try_fg("@keyword.return.javascript", "blue")
        -- lackluster_dev.try_fg("@keyword.return.typescript", "blue")
        -- lackluster_dev.try_fg("@keyword.return", "blue")
        -- lackluster_dev.try_fg("@keyword.exception", "orange")
        -- lackluster_dev.try_fg("@keyword.exception.typescript", "orange")
    end,
}
