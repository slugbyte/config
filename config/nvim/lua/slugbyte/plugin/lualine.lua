return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "unruly-worker",
    },
    config = function()
        local unruly_worker = require("unruly-worker")

        require("lualine").setup({
            options = {
                icons_enabled = false,
                theme = "lackluster",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = { "navic" },
                lualine_y = { "searchcount", "selectioncount", "diagnostics", "filetype", "branch" },
                lualine_z = { unruly_worker.hud.generate },
            },
        })
    end,
}
