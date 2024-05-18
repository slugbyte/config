-- https://github.com/AlexvZyl/nordic.nvim
-- savq/melange-nvim
return {
    "slugbyte/wet-nvim",
    lazy = false,
    dev = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
        vim.cmd.colorscheme("wet")
    end,
}
