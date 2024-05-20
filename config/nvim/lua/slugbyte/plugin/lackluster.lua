return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    dev = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
        vim.cmd.colorscheme("lackluster")
    end,
}
