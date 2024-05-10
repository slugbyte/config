-- https://github.com/slugbyte/scratchpad.nvim
-- scrathpad manager
return {
    "slugbyte/scratchpad.nvim",
    branch = "develop",
    dev = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("scratchpad").setup({
            root_dir = "/Users/slugbyte/workspace/data/text"
        })
    end,
}
