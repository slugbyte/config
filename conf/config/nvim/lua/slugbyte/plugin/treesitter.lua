-- use the Treesitter parser-generator to improve nav, highlight, and more
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
--
-- * Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
-- * Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- "nvim-treesitter/nvim-treesitter-context",
-- https://github.com/theHamsta/crazy-node-movement
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			modules = {},
			-- ensure_installed = { "arduino", "bash", "c", "clojure", "css", "csv",
			-- "diff", "gitcommit", "gitignore", "glsl", "go", "html", "javascript",
			-- "json", "lua", "make", "markdown", "sql", "templ", "toml", "tsv",
			-- "typescript", "vim", "vimdoc", "yaml", "tmux", "zig", },
			sync_install = false,
			auto_install = false,
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					node_decremental = "<bs>",
					scope_incremental = false,
				},
			},
			highlight = {
				enable = true,
				disable = function(lang, buf)
					if lang == "tmux" then
						return false
					end

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
					include_surrounding_whitespace = false,
					keymaps = {
						["oa"] = { query = "@assignment.outer", desc = "select outer assigment" },
						["oc"] = { query = "@call.outer", desc = "selct outer call" },
						["of"] = { query = "@function.outer", desc = "select outer function" },
						["ol"] = { query = "@loop.outer", desc = "select outer loop" },
						["op"] = { query = "@parameter.outer", desc = "select outer parameter" },
						["os"] = { query = "@class.outer", desc = "select outer struct" },
						["oi"] = { query = "@conditional.outer", desc = "select outer conditional" },
						["ob"] = { query = "@block.outer", desc = "select outer block" },

						["ia"] = { query = "@assignment.inner", desc = "select inner assigment" },
						["ic"] = { query = "@call.inner", desc = "selct inner call" },
						["if"] = { query = "@function.inner", desc = "select inner function" },
						["il"] = { query = "@loop.inner", desc = "select inner loop" },
						["ip"] = { query = "@parameter.inner", desc = "select inner parameter" },
						["is"] = { query = "@class.inner", desc = "select inner struct" },
						["ii"] = { query = "@conditional.inner", desc = "select inner conditional" },
						["ib"] = { query = "@block.inner", desc = "select inner block" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["goa"] = { query = "@assignment.outer", desc = "next outer assignment" },
						["goc"] = { query = "@call.outer", desc = "next outer call" },
						["gof"] = { query = "@function.outer", desc = "next outer function" },
						["gol"] = { query = "@loop.outer", desc = "next outer loop" },
						["gop"] = { query = "@parameter.outer", desc = "next outer parameter" },
						["gos"] = { query = "@class.outer", desc = "next outer struct" },
						["goi"] = { query = "@conditional.outer", desc = "next outer conditional" },
						["gor"] = { query = "@return.outer", desc = "next outer return" },
						["god"] = { query = "@comment.outer", desc = "next outer comment" },
						["gob"] = { query = "@block.outer", desc = "next outer block" },

						["gia"] = { query = "@assignment.inner", desc = "next inner assignment" },
						["gic"] = { query = "@call.inner", desc = "next inner call" },
						["gif"] = { query = "@function.inner", desc = "next inner function" },
						["gil"] = { query = "@loop.inner", desc = "next inner loop" },
						["gip"] = { query = "@parameter.inner", desc = "next inner parameter" },
						["gis"] = { query = "@class.inner", desc = "next inner struct" },
						["gii"] = { query = "@conditional.inner", desc = "next inner conditional" },
						["gir"] = { query = "@return.inner", desc = "next inner return" },
						["gid"] = { query = "@comment.inner", desc = "next inner comment" },
						["gib"] = { query = "@block.inner", desc = "next inner block" },
					},
					goto_previous_start = {
						["Goa"] = { query = "@assignment.outer", desc = "prev outer assignment" },
						["Goc"] = { query = "@call.outer", desc = "prev outer call" },
						["Gof"] = { query = "@function.outer", desc = "prev outer function" },
						["Gol"] = { query = "@loop.outer", desc = "prev outer loop" },
						["Gop"] = { query = "@parameter.outer", desc = "prev outer parameter" },
						["Gos"] = { query = "@class.outer", desc = "prev outer struct" },
						["Goi"] = { query = "@conditional.outer", desc = "prev outer conditional" },
						["Gor"] = { query = "@return.outer", desc = "prev outer return" },
						["God"] = { query = "@comment.outer", desc = "prev outer comment" },
						["Gob"] = { query = "@block.outer", desc = "prev outer block" },

						["GiA"] = { query = "@assignment.inner", desc = "prev inner assignment" },
						["GiC"] = { query = "@call.inner", desc = "prev inner call" },
						["GiF"] = { query = "@function.inner", desc = "prev inner function" },
						["GiL"] = { query = "@loop.inner", desc = "prev inner loop" },
						["GiP"] = { query = "@parameter.inner", desc = "prev inner parameter" },
						["GiS"] = { query = "@class.inner", desc = "prev inner struct" },
						["GiI"] = { query = "@conditional.inner", desc = "prev inner conditional" },
						["GiR"] = { query = "@return.inner", desc = "prev inner return" },
						["GiD"] = { query = "@comment.inner", desc = "prev inner comment" },
						["GiB"] = { query = "@block.inner", desc = "prev inner block" },
					},
					goto_next_end = {
						["gea"] = { query = "@assignment.outer", desc = "next end assignment" },
						["gec"] = { query = "@call.outer", desc = "next end call" },
						["gef"] = { query = "@function.outer", desc = "next end function" },
						["gel"] = { query = "@loop.outer", desc = "next end loop" },
						["gep"] = { query = "@parameter.outer", desc = "next end parameter" },
						["ges"] = { query = "@class.outer", desc = "next end struct" },
						["gei"] = { query = "@conditional.outer", desc = "next end conditional" },
						["ger"] = { query = "@return.outer", desc = "next end return" },
						["ged"] = { query = "@comment.outer", desc = "next end comment" },
						["geb"] = { query = "@block.outer", desc = "next end block" },
					},
					goto_prev_end = {
						["Gea"] = { query = "@assignment.outer", desc = "prev end assignment" },
						["Gec"] = { query = "@call.outer", desc = "prev end call" },
						["Gef"] = { query = "@function.outer", desc = "prev end function" },
						["Gel"] = { query = "@loop.outer", desc = "prev end loop" },
						["Gep"] = { query = "@parameter.outer", desc = "prev end parameter" },
						["Ges"] = { query = "@class.outer", desc = "prev end struct" },
						["Gei"] = { query = "@conditional.outer", desc = "prev end conditional" },
						["Ger"] = { query = "@return.outer", desc = "prev end return" },
						["Ged"] = { query = "@comment.outer", desc = "prev end comment" },
						["Geb"] = { query = "@block.outer", desc = "prev end block" },
					},
				},
			},
		})

		-- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
		-- vim.keymap.set({ "n", "x", "o" }, "s", ts_repeat_move.repeat_last_move_next, { desc = "next textobject" })
		-- vim.keymap.set({ "n", "x", "o" }, "S", ts_repeat_move.repeat_last_move_previous, { desc = "prev textobject" })
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	end,
}
