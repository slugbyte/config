-- A fuzzy finding tool that lets you look explore all the things
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
--
--
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	enabled = true,
	lazy = false,
	event = "VimEnter",
	priority = 10,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		-- local telescope_actions = require("telescope.actions")
		local unruly_telescope = require("unruly-worker.external.telescope")

		telescope.setup({
			defaults = {
				mappings = unruly_telescope.create_mappings({
					-- skip_list = { "<Up>" },
					-- insert_mappings = {
					-- 	["<Up>"] = telescope_actions.toggle_selection,
					-- },
					-- normal_mappings = {
					-- 	["<Up>"] = telescope_actions.toggle_selection,
					-- },
				}),
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
	end,
}
