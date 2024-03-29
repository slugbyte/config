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
		-- { "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local actions = require("telescope.actions")

		local mappings = {
			n = {
				["@"] = actions.move_to_top,
				["$"] = actions.move_to_middle,
				["#"] = actions.move_to_bottom,

				["<c-a>"] = actions.select_all,
				["<c-d>"] = actions.drop_all,
				["<c-q>"] = actions.add_selected_to_qflist + actions.open_qflist,
				["<c-l>"] = actions.add_selected_to_loclist + actions.open_loclist,
				["<c-r>"] = actions.remove_selection,
				["<c-s>"] = actions.add_selection,

				["a"] = actions.select_all,
				["d"] = actions.drop_all,
				["q"] = actions.add_selected_to_qflist + actions.open_qflist,
				["l"] = actions.add_selected_to_loclist + actions.open_loclist,
				["r"] = actions.remove_selection,
				["s"] = actions.add_selection,

				["n"] = actions.move_selection_next,
				["e"] = actions.move_selection_previous,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

				["<c-x>"] = actions.close,
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-h>"] = actions.select_horizontal,
				["<C-s>"] = actions.select_vertical,

				["<C-e>"] = actions.preview_scrolling_up,
				["<C-n>"] = actions.preview_scrolling_down,
				["<C-Up>"] = actions.preview_scrolling_up,
				["<C-Down>"] = actions.preview_scrolling_down,
				["<c-k>"] = actions.which_key,
			},
			i = {
				["<c-a>"] = actions.select_all,
				["<c-d>"] = actions.drop_all,
				["<c-q>"] = actions.add_selected_to_qflist + actions.open_qflist,
				["<c-l>"] = actions.add_selected_to_loclist + actions.open_loclist,
				["<c-r>"] = actions.remove_selection,
				["<c-s>"] = actions.add_selection,

				["<CR>"] = actions.select_default,
				["<C-h>"] = actions.select_horizontal,
				["<C-s>"] = actions.select_vertical,
				["<c-x>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

				["<C-e>"] = actions.preview_scrolling_up,
				["<C-n>"] = actions.preview_scrolling_down,
				["<C-Up>"] = actions.preview_scrolling_up,
				["<C-Down>"] = actions.preview_scrolling_down,
				["<c-k>"] = actions.which_key,
			},
		}

		local default_noop = require("telescope.mappings").default_mappings

		for key in pairs(default_noop.i) do
			default_noop.i[key] = actions.nop
		end
		for key in pairs(default_noop.n) do
			default_noop.n[key] = actions.nop
		end


		-- mappings = vim.tbl_deep_extend("force", default_noop, mappings)

		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			defaults = {
				mappings = mappings,
			},
			-- pickers = {}
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- Kemaps are managed by which-key

		-- See `:help telescope.builtin`
		-- local builtin = require("telescope.builtin")
		-- vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		-- vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		-- vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		-- vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		-- vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
		-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		-- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
		-- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		-- vim.keymap.set("n", "<leader>sa", builtin.resume, { desc = "[S]earch [A]gain" })
		-- vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "[S]earch [R]ecent" })

		-- Slightly advanced example of overriding default behavior and theme
		-- vim.keymap.set("n", "<leader>/", function()
		-- 	-- You can pass additional configuration to telescope to change theme, layout, etc.
		-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		-- 		winblend = 10,
		-- 		previewer = false,
		-- 	}))
		-- end, { desc = "[/] Fuzzily search in current buffer" })

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		-- vim.keymap.set("n", "<leader>s/", function()
		-- 	builtin.live_grep({
		-- 		grep_open_files = true,
		-- 		prompt_title = "Live Grep in Open Files",
		-- 	})
		-- end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your neovim configuration files
		-- vim.keymap.set("n", "<leader>sn", function()
		-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
		-- end, { desc = "[S]earch [N]eovim files" })
	end,
}
