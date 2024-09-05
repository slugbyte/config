return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "unruly-worker",
    },
    config = function()
        local unruly_worker = require("unruly-worker")
        local lackluster = require("lackluster")

        require("lualine").setup({
            options = {
                icons_enabled = false,
                theme = "lackluster",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "filename", path = 4 } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { "searchcount", "selectioncount", "diagnostics", { "branch", color = { fg = lackluster.color.gray6 } }, "diff" },
                lualine_z = { { unruly_worker.hud.generate, color = { fg = lackluster.color.gray5 } } },
            },
        })
    end,
}
