return {
	"folke/zen-mode.nvim",
	config = function()
		require("zen-mode").setup({
			window = {
				backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				width = 120, -- width of the Zen window
				height = 1,  -- height of the Zen window
			},
			plugins = {
				gitsigns = { enabled = true }, -- disables git signs
				tmux = { enabled = true }, -- disables the tmux statusline
			},
		})
	end,
}
