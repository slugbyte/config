return {
    {
        'https://github.com/echasnovski/mini.trailspace',
        version = false,
        config = function()
            require("mini.trailspace").setup()
        end
    },
    {
        "https://github.com/folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            -- require("slugbyte.lackluster.noice")
        end
    },
    {
        "https://github.com/nvim-tree/nvim-web-devicons",
        config = function()
            require("slugbyte.lackluster.devicons")
        end
    },
    {
        "https://github.com/HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- require("slugbyte.lackluster.rainbow")
        end
    },
    {
        "https://github.com/nvim-tree/nvim-tree.lua",
        config = function()
            -- require("slugbyte.lackluster.nvim-tree")
        end
    },
    {
        "https://github.com/akinsho/bufferline.nvim",
        config = function()
            -- require("slugbyte.lackluster.bufferline")
        end
    },
    -- {
    --     "https://github.com/nvimdev/dashboard-nvim",
    --     event = 'VimEnter',
    --     dependencies = {
    --         "https://github.com/nvim-tree/nvim-web-devicons",
    --     },
    --     config = function()
    --         -- require("slugbyte.lackluster.dashboard")
    --     end
    -- },
}
