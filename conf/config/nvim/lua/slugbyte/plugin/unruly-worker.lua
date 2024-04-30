-- this is my own keymap plugin for the workman keyboard layout
-- https://github.com/slugbyte/unruly-worker
return {
	"slugbyte/unruly-worker",
	-- dir = "/Users/slugbyte/workspace/code/unruly-worker",
	-- name = "unruly-worker",
	lazy = false,
	branch = "develop",
	dev = true,
	priority = 0, -- make sure to load this before all the other start plugins

	-- event = "VimEnter",
	config = function()
		local unruly_worker = require("unruly-worker")
		unruly_worker.setup({
			unruly_options = {
				-- seek_mode = unruly_worker.seek_mode.loclist,
				-- kopy_reg = 'o',
				-- macro_reg = 'n',
				swap_q_and_z = true,
				enable_greeting = true,
				-- mark_mode_is_global = true,

			},
			-- you can use the skip_list = {} to stop unruly from creating certain mappings
			-- skip_list = { "z", "Z", "<C-z>"},  skip z related mappings
			skip_list = {},
			booster = {
				default                     = true,
				-- easy stuff are just additional opt in keymaps
				-- goop                        = false,
				easy_swap                   = true,
				easy_line                   = true,
				easy_search                 = true,
				easy_window                 = true,
				easy_focus                  = true,
				easy_scroll                 = true,
				easy_hlsearch               = true,
				easy_incrament              = true,
				easy_spellcheck             = true,
				easy_jumplist               = true,
				easy_source                 = true,
				easy_lsp                    = true,
				easy_lsp_leader             = true,
				easy_diagnostic             = true,
				-- easy_diagnostic_leader             = true,
				-- unruly stuff change neovim's normal behavior
				unruly_seek                 = true,
				unruly_mark                 = true,
				unruly_macro                = true,
				unruly_kopy                 = true,
				unruly_quit                 = true,
				-- plugin stuff have external dependencies
				plugin_navigator            = true,
				plugin_comment              = true,
				plugin_luasnip              = true,
				plugin_textobject           = true,
				plugin_telescope_leader     = true,
				plugin_telescope_lsp_leader = true,
				plugin_telescope_easy_jump  = true,
				-- plugin_telescope_diagnostic_leader = true,
			},
		})

		vim.keymap.set("", "<leader>d", unruly_worker.boost.telescope.diagnostics)
	end,
}
