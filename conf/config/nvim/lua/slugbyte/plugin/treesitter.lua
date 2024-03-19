-- use the Treesitter parser-generator to improve nav, highlight, and more
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
--
-- * Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
-- * Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- "nvim-treesitter/nvim-treesitter-context",
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			modules = {},
			-- ensure_installed = {
			-- 	"arduino",
			-- 	"bash",
			-- 	"c",
			-- 	"clojure",
			-- 	"css",
			-- 	"csv",
			-- 	"diff",
			-- 	"gitcommit",
			-- 	"gitignore",
			-- 	"glsl",
			-- 	"go",
			-- 	"html",
			-- 	"javascript",
			-- 	"json",
			-- 	"lua",
			-- 	"make",
			-- 	"markdown",
			-- 	"sql",
			-- 	"templ",
			-- 	"toml",
			-- 	"tsv",
			-- 	"typescript",
			-- 	"vim",
			-- 	"vimdoc",
			-- 	"yaml",
			-- 	"tmux",
			-- 	"zig",
			-- },
			sync_install = false,
			auto_install = false,
			indent = {
				enable = true,
				-- disable = { 'ruby' }
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
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
						["aA"] = { query = "@assignment.outer", desc = "select outer assigment" },
						["aC"] = { query = "@call.outer", desc = "selct outer call" },
						["aF"] = { query = "@function.outer", desc = "select outer function" },
						["aL"] = { query = "@loop.outer", desc = "select outer loop" },
						["aP"] = { query = "@parameter.outer", desc = "select outer parameter" },
						["aS"] = { query = "@class.outer", desc = "select outer struct" },
						["aI"] = { query = "@conditional.outer", desc = "select outer conditional" },

						["iA"] = { query = "@assignment.inner", desc = "select inner assigment" },
						["iC"] = { query = "@call.inner", desc = "selct inner call" },
						["iF"] = { query = "@function.inner", desc = "select inner function" },
						["iL"] = { query = "@loop.inner", desc = "select inner loop" },
						["iP"] = { query = "@parameter.inner", desc = "select inner parameter" },
						["iS"] = { query = "@class.inner", desc = "select inner struct" },
						["iI"] = { query = "@conditional.inner", desc = "select inner conditional" },

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
						["gaa"] = { query = "@assignment.outer", desc = "next outer assignment" },
						["gac"] = { query = "@call.outer", desc = "next outer call" },
						["gaf"] = { query = "@function.outer", desc = "next outer function" },
						["gal"] = { query = "@loop.outer", desc = "next outer loop" },
						["gap"] = { query = "@parameter.outer", desc = "next outer parameter" },
						["gas"] = { query = "@class.outer", desc = "next outer struct" },
						["gai"] = { query = "@conditional.outer", desc = "next outer conditional" },
						["gar"] = { query = "@return.outer", desc = "next outer return" },
						["gad"] = { query = "@comment.outer", desc = "next outer comment" },
						["gab"] = { query = "@block.outer", desc = "next outer block" },

						["gia"] = { query = "@assignment.outer", desc = "next outer assignment" },
						["gic"] = { query = "@call.outer", desc = "next outer call" },
						["gif"] = { query = "@function.outer", desc = "next outer function" },
						["gil"] = { query = "@loop.outer", desc = "next outer loop" },
						["gip"] = { query = "@parameter.outer", desc = "next outer parameter" },
						["gis"] = { query = "@class.outer", desc = "next outer struct" },
						["gii"] = { query = "@conditional.outer", desc = "next outer conditional" },
						["gir"] = { query = "@return.outer", desc = "next outer return" },
						["gid"] = { query = "@comment.outer", desc = "next outer comment" },
						["gib"] = { query = "@block.outer", desc = "next outer block" },

						[")<"] = { query = "@assignment.outer", desc = "next outer assignment" },
						[")}"] = { query = "@call.outer", desc = "next outer call" },
						[")'"] = { query = "@function.outer", desc = "next outer function" },
						["):"] = { query = "@loop.outer", desc = "next outer loop" },
						[")`"] = { query = "@parameter.outer", desc = "next outer parameter" },
						[")>"] = { query = "@class.outer", desc = "next outer struct" },
						[")!"] = { query = "@conditional.outer", desc = "next outer conditional" },
						[")-"] = { query = "@return.outer", desc = "next outer return" },
						[")*"] = { query = "@comment.outer", desc = "next outer comment" },
						[")~"] = { query = "@block.outer", desc = "next outer block" },

						["}<"] = { query = "@assignment.inner", desc = "next inner assignment" },
						["}}"] = { query = "@call.inner", desc = "next inner call" },
						["}'"] = { query = "@function.inner", desc = "next inner function" },
						["}:"] = { query = "@loop.inner", desc = "next inner loop" },
						["}`"] = { query = "@parameter.inner", desc = "next inner parameter" },
						["}>"] = { query = "@class.inner", desc = "next inner struct" },
						["}!"] = { query = "@conditional.inner", desc = "next inner conditional" },
						["}-"] = { query = "@return.inner", desc = "next inner return" },
						["}*"] = { query = "@comment.inner", desc = "next inner comment" },
						["}~"] = { query = "@block.inner", desc = "next inner block" },
					},
					goto_previous_start = {
						["(<"] = { query = "@assignment.outer", desc = "prev outer assignment" },
						["(}"] = { query = "@call.outer", desc = "prev outer call" },
						["('"] = { query = "@function.outer", desc = "prev outer function" },
						["(:"] = { query = "@loop.outer", desc = "prev outer loop" },
						["(`"] = { query = "@parameter.outer", desc = "prev outer parameter" },
						["(>"] = { query = "@class.outer", desc = "prev outer struct" },
						["(!"] = { query = "@conditional.outer", desc = "prev outer conditional" },
						["(-"] = { query = "@return.outer", desc = "prev outer return" },
						["(*"] = { query = "@comment.outer", desc = "prev outer comment" },
						["(~"] = { query = "@block.outer", desc = "prev outer block" },

						["{<"] = { query = "@assignment.inner", desc = "prev inner assignment" },
						["{}"] = { query = "@call.inner", desc = "prev inner call" },
						["{'"] = { query = "@function.inner", desc = "prev inner function" },
						["{:"] = { query = "@loop.inner", desc = "prev inner loop" },
						["{`"] = { query = "@parameter.inner", desc = "prev inner parameter" },
						["{>"] = { query = "@class.inner", desc = "prev inner struct" },
						["{!"] = { query = "@conditional.inner", desc = "prev inner conditional" },
						["{-"] = { query = "@return.inner", desc = "prev inner return" },
						["{*"] = { query = "@comment.inner", desc = "prev inner comment" },
						["{~"] = { query = "@block.inner", desc = "prev inner block" },
					},
				},
			},
		})

		local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
		vim.keymap.set({ "n", "x", "o" }, "]]", ts_repeat_move.repeat_last_move_next, { desc = "next textobject" })
		vim.keymap.set({ "n", "x", "o" }, "[[", ts_repeat_move.repeat_last_move_previous, { desc = "prev textobject" })
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	end,
}
