-- displays a popup with possible key bindings
-- https://github.com/folke/which-key.nvim

return {
	"folke/which-key.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local telescope_builtin = require("telescope.builtin")

		local function search_fuzzy()
			telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end

		local function search_config_files()
			telescope_builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end

		local function search_config_grep()
			telescope_builtin.live_grep({ cwd = vim.fn.stdpath("config") })
		end

		local function window_write_all()
			vim.cmd("silent! wall")
			print("[write all]", string.sub(math.random() .. "", -4, -1))
		end

		require("which-key").setup()
		require("which-key").register({
			["<leader>w"] = {
				name = "[W]indow",
				f = { ":only<CR>", "[W]indow [F]ullscreen" },
				h = { ":vs<CR>", "[W]indow [H]orizontal split" },
				n = { ":n<CR>", "[W]indow [N]ext" },
				p = { ":prev<CR>", "[W]indow [P]rev" },
				q = { ":wqall<CR>", "[W]indow [Q]uit all" },
				s = { window_write_all, "[W]indow [S]ave all" },
				v = { ":sp<CR>", "[W]indow [V]ertical split" },
			},
			["<leader>s"] = {
				name = "[S]earch",
				h = { telescope_builtin.help_tags, "[S]earch [H]elp" },
				f = { telescope_builtin.find_files, "[S]earch [F]ile" },
				b = { telescope_builtin.buffers, "[S]earch [B]uffer" },
				w = { telescope_builtin.grep_string, "[S]earch current [W]ord" },
				k = { TelescopeGlobalState.keymaps, "[S]earch [K]eymaps" },
				g = { telescope_builtin.live_grep, "[S]earch [G]rep" },
				d = { telescope_builtin.diagnostics, "[S]earch [D]iagnostics" },
				a = { telescope_builtin.resume, "[S]earch [A]gain" },
				r = { telescope_builtin.oldfiles, "[S]earch [R]ecent" },
				c = {
					name = "[C]onfig",
					f = { search_config_files, "[S]earch [C]onfig [F]ile" },
					g = { search_config_grep, "[S]earch [C]onfi [G]rep" },
				},
			},
			["<leader>l"] = {
				name = "[L]sp",
				d = { telescope_builtin.lsp_definitions, "[L]sp goto [D]efinitions" },
				D = { vim.lsp.buf.declaration, "[L]sp goto [D]eclaration" },
				R = { telescope_builtin.lsp_references, "[L]sp [R]eferences" },
				t = { telescope_builtin.lsp_type_definitions, "[L]sp [T]ypes" },
				s = { telescope_builtin.lsp_dynamic_workspace_symbols, "[L]sp [S]ymbols" },
				r = { vim.lsp.buf.rename, "[L]sp [R]ename" },
				a = { vim.lsp.buf.code_action, "[L]sp code [A]ction" },
				i = { telescope_builtin.lsp_implementations, "[G]oto [I]mplementation" },
				h = { vim.lsp.buf.hover, "[L]sp [H]over Documentation" },
			},
			["<leader>/"] = { search_fuzzy, "[/] Fuzzy Search" },
			["<leader>q"] = { ":qall<CR>", "[Q]uit" },
			["<leader>x"] = { ":close<CR>", "[X]out" },
			-- ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- ["<leader>w"] = { name = "[W]indow", _ = "which_key_ignore" },
			-- ["<leader>n"] = { name = "[N]umber", _ = "which_key_ignore" },
			-- ["<leader>l"] = { name = "[L]sp", _ = "which_key_ignore" },
			-- ["<leader>ls"] = { name = "[S]ymbols", _ = "which_key_ignore" },
		})
	end,
}
