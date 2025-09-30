-- this is my own keymap plugin for the workman keyboard layout
-- https://github.com/slugbyte/unruly-worker
-- return {}
return {
    "slugbyte/unruly-worker.nvim",
    lazy = false,
    dev = true, -- if your not me you dont need this line
    priority = 9000, -- make sure to load this before all the other start plugins
    config = function()
        local util = require("slugbyte.util")
        local unruly_worker = require("unruly-worker")
        unruly_worker.setup({
            unruly_options = {
                swap_q_and_z = true,
                enable_greeting = true,

                -- TESTING
                -- seek_mode = unruly_worker.seek_mode.loclist,
                -- kopy_reg = 'o',
                -- macro_reg = 'n',
                -- mark_mode_is_global = true,
            },
            skip_list = { "s", "S" }, -- using s for flaSh
            booster = {
                default = true,
                -- easy stuff are just additional opt in keymaps
                easy_diagnostic = true,
                easy_focus = true,
                easy_hlsearch = true,
                easy_incrament = true,
                easy_jumplist = true,
                easy_line = true,
                easy_lsp = true,
                easy_lsp_leader = true,
                easy_scroll = true,
                easy_search = true,
                easy_source = true,
                easy_swap = true,
                easy_window = true,
                -- unruly stuff change neovim's normal behavior
                unruly_seek = true,
                unruly_mark = false,
                unruly_macro = true,
                unruly_kopy = true,
                unruly_quit = true,
                -- plugin stuff have external dependencies
                plugin_navigator = true,
                plugin_comment = true,
                plugin_luasnip = true,
                plugin_telescope_leader = true,
                plugin_telescope_lsp_leader = true,
                plugin_telescope_easy_jump = true,

                -- nope
                easy_diagnostic_leader = false,
                easy_spellcheck = false,
                plugin_textobject = false,
            },
        })
    end,
}
