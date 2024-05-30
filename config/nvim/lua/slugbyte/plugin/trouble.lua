-- https://github.com/folke/trouble.nvim

return {
    "folke/trouble.nvim",
    opts = {
        icons = false,
        fold_open = "|",
        fold_close = "-",
        signs = {
            error = "!",
            warning = "!",
            hint = "-",
            information = "-",
            other = "?",
        },
    },
}
