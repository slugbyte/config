return {
    "https://github.com/petertriho/nvim-scrollbar",
    dependencies = {
        "kevinhwang91/nvim-hlslens",
        "lewis6991/gitsigns.nvim",
    },
    priority = 800,
    config = function()
        require("scrollbar").setup({
            set_highlights = false,

        })
        require("scrollbar.handlers.search").setup()
        require("scrollbar.handlers.gitsigns").setup()
    end,
}
