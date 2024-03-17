-- nvim-cmp is the auto completion engine
-- https://github.com/hrsh7th/nvim-cmp
-- nvim-cmp sources are used to provide things to auto complte
-- * https://github.com/hrsh7th/cmp-nvim-lsp
-- * https://github.com/hrsh7th/cmp-cmdline
-- * https://github.com/hrsh7th/cmp-buffer
-- * https://github.com/hrsh7th/cmp-emoji
-- * https://github.com/hrsh7th/cmp-path
-- * https://github.com/hrsh7th/cmp-git
--
-- luasnip is a powerful snippet engine
-- * https://github.com/L3MON4D3/LuaSnip
-- * https://github.com/saadparwaiz1/cmp_luasnip
--

return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "VimEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-git",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local types = require("cmp.types")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		local action_abort = cmp.mapping.abort()
		local action_confirm_select = cmp.mapping.confirm({ select = true })
		local action_confirm_continue = cmp.mapping.confirm({ select = false })
		local action_insert_next = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
		local action_insert_prev = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
		local function action_cmdline_next()
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.complete()
			end
		end
		local function action_cmdline_prev()
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp.complete()
			end
		end
		local action_luasnip_next = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end)
		local action_luasnip_prev = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end)

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },

			mapping = {
				["<C-k>"] = { i = action_abort },
				["<C-j>"] = { i = action_confirm_select },
				["<C-Tab>"] = { i = action_confirm_select },
				["<CR>"] = { i = action_confirm_select },

				["<Tab>"] = { i = action_insert_next },
				["<Down>"] = { i = action_insert_next },

				["<S-Tab>"] = { i = action_insert_prev },
				["<Up>"] = { i = action_insert_prev },

				["<c-,>"] = { i = action_luasnip_next },
				["<c-."] = { i = action_luasnip_prev },
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "emoji" },
			},
		})

		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" },
			}, {
				{ name = "buffer" },
			}, {
				{ name = "path" },
			}, {
				{ name = "emoji" },
			}),
		})

		local mapping_cmdline = {
			["<C-k>"] = { c = action_abort },
			["<C-j>"] = { c = action_confirm_continue },
			["<C-Tab>"] = { c = action_confirm_continue },

			["<Tab>"] = { c = action_cmdline_next },
			["<Down>"] = { c = action_cmdline_next },

			["<S-Tab>"] = { c = action_cmdline_prev },
			["<Up>"] = { c = action_cmdline_prev },
		}

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = mapping_cmdline,
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = mapping_cmdline,
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
