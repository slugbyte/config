-- A fuzzy finding tool that lets you look explore all the things
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    enabled = true,
    lazy = false,
    event = "VimEnter",
    priority = 10,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "jvgrootveld/telescope-zoxide",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
        local telescope = require("telescope")
        local unruly_telescope = require("unruly-worker.external.telescope")

        telescope.setup({
            defaults = {
                disable_devicons = true, -- doen't work
                mappings = unruly_telescope.create_mappings({}),
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
                ["zoxide"] = {
                    prompt_title = "Zoxide",
                },
            },
        })

        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "ui-select")
        pcall(telescope.load_extension, "zoxide")
    end,
}
