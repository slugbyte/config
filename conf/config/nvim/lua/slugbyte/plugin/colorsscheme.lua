-- https://github.com/AlexvZyl/nordic.nvim
-- savq/melange-nvim
return {
	"slugbyte/wet-nvim",
	lazy = false,
	dev = true,
	priority = 1000, -- make sure to load this before all the other start plugins
	init = function()
		vim.cmd.colorscheme("wet")
		vim.cmd("hi DiagnosticWarn guifg=#2a2a2a")
		vim.cmd("hi DiagnosticSignWarn guifg=#2a2a2a")
		vim.cmd("hi DiagnosticSignWarn guibg=#555555")
		vim.cmd("hi TreesitterContext gui=underline guibg=#123312")
		vim.cmd("hi TreesitterContextLineNumber gui=underline guibg=#123312")

		-- require("nordic").load()
		-- vim.cmd.colorscheme("nordic")
		-- vim.cmd.hi("Comment gui=none")
		-- vim.cmd.hi("Whitespace guifg=#111111")
	end,
}
