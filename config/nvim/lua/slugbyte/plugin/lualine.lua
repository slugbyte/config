return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        "unruly-worker",
    },
    config = function()
        -- local wet_lualine = require('wet').lualine
        local unruly_worker = require('unruly-worker')

        require('lualine').setup {
            options = {
                icons_enabled = false,
                theme = "lackluster",
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { {
                    'filename',
                    path = 1,
                    file_status = true,
                    symbols = {
                        modified = ' [+]',
                        readonly = ' [readonly]',
                        unnamed = '[no name]',
                    },
                } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { "searchcount", "selectioncount", 'diagnostics', 'filetype', 'branch' },
                -- lualine_z = { unruly_worker.hud.generate },
                lualine_z = {},
            }
        }
    end
}
