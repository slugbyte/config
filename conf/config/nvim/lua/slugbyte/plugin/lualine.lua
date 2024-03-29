return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		"unruly-worker",
	},
	config = function()
		local wet_lualine = require('wet').lualine
		local macro = require('unruly-worker.action.macro')
		local kopy = require('unruly-worker.action.kopy')
		local seek = require('unruly-worker.action.seek')
		local mark = require('unruly-worker.action.mark')

		-- vim.print({ yank = yank })


		require('lualine').setup {
			options = {
				icons_enabled = false,
				theme = wet_lualine,
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
				lualine_x = { 'branch', },
				lualine_y = { mark.get_status_text, macro.get_status_text, kopy.get_status_text, seek.get_status_text },
				lualine_z = { "searchcount", "selectioncount", 'diagnostics' },
			}
		}
	end
}
