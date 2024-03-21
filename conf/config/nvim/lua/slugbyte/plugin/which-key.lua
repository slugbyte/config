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

		local function new_rg_source(builtin_name, cwd)
			if cwd == nil then
				return function()
					telescope_builtin[builtin_name]({
						hidden = true,
					})
				end
			else
				return function()
					telescope_builtin[builtin_name]({
						hidden = true,
						cwd = cwd,
					})
				end
			end
		end

		local nvim_config_path = vim.fn.stdpath("config")
		local search_nvim_config_files = new_rg_source("find_files", nvim_config_path)
		local search_nvim_config_grep = new_rg_source("live_grep", nvim_config_path)


		local conf_path = vim.env.HOME .. "/workspace/conf"
		local search_conf_files = new_rg_source("find_files", conf_path)
		local search_conf_grep = new_rg_source("live_grep", conf_path)

		local search_files = new_rg_source("find_files")
		local search_grep = new_rg_source("live_grep")
		local search_grep_word = new_rg_source("grep_string")


		require("which-key").setup()
		require("which-key").register({
			["<C-d"] = { telescope_builtin.lsp_definitions, "[D]efinition" },
			["<leader>m"] = {
				name = "[M]ark Maintnence"
			},
			["<leader>b"] = {
				name = "[B]uffer",
				f = { ":only<CR>", "[B]uffer [F]ullscreen" },
				v = { ":vs<CR>", "[B]uffer [V]erticle split" },
				n = { ":n<CR>", "[B]uffer [N]ext" },
				p = { ":prev<CR>", "[B]uffer [P]rev" },
				h = { ":sp<CR>", "[B]uffer [H]orizontal split" },
				s = { telescope_builtin.buffers, "[B]uffer [S]earch " },
			},
			["<leader>s"] = {
				name = "[S]earch",
				h = { telescope_builtin.help_tags, "[S]earch [H]elp" },
				f = { search_files, "[S]earch [F]ile" },
				b = { telescope_builtin.buffers, "[S]earch [B]uffer" },
				w = { search_grep_word, "[S]earch current [W]ord" },
				k = { telescope_builtin.keymaps, "[S]earch [K]eymaps" },
				g = { search_grep, "[S]earch [G]rep" },
				d = { telescope_builtin.diagnostics, "[S]earch [D]iagnostics" },
				a = { telescope_builtin.resume, "[S]earch [A]gain" },
				r = { telescope_builtin.oldfiles, "[S]earch [R]ecent" },
				q = { telescope_builtin.quickfix, "[S]earch [Q]uickfix" },
				c = {
					name = "[C]onfig",
					f = { search_nvim_config_files, "[S]earch [C]onfig [F]ile" },
					g = { search_nvim_config_grep, "[S]earch [C]onfi [G]rep" },
					c = {
						name = "[C]onf",
						f = { search_conf_files, "[S]earch [C]onf [F]ile" },
						g = { search_conf_grep, "[S]earch [C]onf [G]rep" },
					},

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
				f = { vim.lsp.buf.format, "[L]sp [F]ormat" },
			},
			["<leader>/"] = { search_fuzzy, "[/] Fuzzy Search" },
			["<leader>k"] = { ":WhichKey<CR>", "[K]eys" },
		})
	end,
}
