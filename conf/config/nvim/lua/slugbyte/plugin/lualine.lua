return {
	'nvim-lualine/lualine.nvim',
	config = function()
		local wet_lualine = require('wet').lualine
		local hop = require('unruly-worker.hop')

		local function hop_mode()
			return string.format("[%s]", hop.HopModeGet())
		end

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
				lualine_x = { 'branch', 'filetype' },
				lualine_y = { hop_mode, },
				lualine_z = { 'location', 'diagnostics' },
			}
		}
	end
}
