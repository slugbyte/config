-- displays a popup with possible key bindings
-- https://github.com/folke/which-key.nvim
return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()
		require("which-key").register({
			w = {
				name = "[W]indow",
				n = { ":n<CR>", "[W]indow [N]ext" },
				p = { ":prev<CR>", "[W]indow [P]rev" },
				f = { ":only<CR>", "[W]indow [F]ullscreen" },
				h = { ":vs<CR>", "[W]indow [H]orizontal split" },
				v = { ":sp<CR>", "[W]indow [V]ertical split" },
				q = { ":qall<CR>", "[W]indow [Q]uit all" },
				s = {
					function()
						vim.cmd("silent! wall")
						print("[write all]", string.sub(math.random() .. "", -4, -1))
					end,
					"[W]indow [S]ave all",
				},
			},
			-- ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- ["<leader>w"] = { name = "[W]indow", _ = "which_key_ignore" },
			-- ["<leader>n"] = { name = "[N]umber", _ = "which_key_ignore" },
			-- ["<leader>l"] = { name = "[L]sp", _ = "which_key_ignore" },
			-- ["<leader>ls"] = { name = "[S]ymbols", _ = "which_key_ignore" },
		}, {
			prefix = "<leader>",
		})
	end,
}
