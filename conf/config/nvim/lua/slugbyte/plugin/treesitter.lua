-- use the Treesitter parser-generator to improve nav, highlight, and more
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
--
-- * Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
-- * Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- "nvim-treesitter/nvim-treesitter-context",
	},
	opts = {
		ensure_installed = {
			"arduino",
			"bash",
			"c",
			"clojure",
			"css",
			"csv",
			"diff",
			"gitcommit",
			"gitignore",
			"glsl",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"make",
			"markdown",
			"sql",
			"templ",
			"toml",
			"tsv",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
			"tmux",
			"zig",
		},
		auto_install = false,
		indent = {
			enable = true,
			-- disable = { 'ruby' }
		},
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

				if ok and stats and stats.size > max_filesize then
					return true
				end
				return false
			end,
			additional_vim_regex_highlighting = { "tmux" },
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = { query = "@function.outer", desc = "Select outer part of a loop" },
					["if"] = { query = "@function.inner", desc = "Select inner part of a loop" },
					["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
					["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
					["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
					["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
					["as"] = { query = "@class.outer", desc = "Select the outr part of a class region" },
					["is"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["aa"] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
					["ia"] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
					["ac"] = { query = "@call.outer", desc = "Select outer part of a function call" },
					["ic"] = { query = "@call.inner", desc = "Select inner part of a function call" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[")c"] = { query = "@call.outer", desc = "Next function call start" },
					[")f"] = { query = "@function.outer", desc = "Next method/function def start" },
					[")s"] = { query = "@class.outer", desc = "Next class start" },
					[")i"] = { query = "@conditional.outer", desc = "Next conditional start" },
					[")l"] = { query = "@loop.outer", desc = "Next loop start" },
				},
				goto_previous_start = {
					["(c"] = { query = "@call.outer", desc = "Prev function call start" },
					["(f"] = { query = "@function.outer", desc = "Prev method/function def start" },
					["(s"] = { query = "@class.outer", desc = "Prev class start" },
					["(i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
					["(l"] = { query = "@loop.outer", desc = "Prev loop start" },
				},
			},
		},
	},
	config = function(_, opts)
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup(opts)

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	end,
}
