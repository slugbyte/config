-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
    'lewis6991/gitsigns.nvim',
    Lazy = false,
    -- priority 50 b/c needs to beloaded before scrollbar
    priority = 50,
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = '|' },
                change = { text = '|' },
                delete = { text = '|' },
                topdelete = { text = '|' },
                changedelete = { text = '|' },

            }
        })
    end,
}
