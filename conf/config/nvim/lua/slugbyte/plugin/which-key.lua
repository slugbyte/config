-- displays a popup with possible key bindings
-- https://github.com/folke/which-key.nvim
return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()
		require("which-key").register({
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]indow", _ = "which_key_ignore" },
			["<leader>n"] = { name = "[N]umber", _ = "which_key_ignore" },
		})
	end,
}
