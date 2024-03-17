-- lsp stufffff
--
-- mason installs and configures lsp servers
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
--
-- neodev helps configure lsp to work well with neovim apis
-- https://github.com/folke/neodev.nvim
--
-- fidget is just a pretty ui to help keep track of what lsp biz is goin on
-- https://github.com/j-hui/fidget.nvim

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- NOTE: Remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself
				-- many times.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				-- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header
				-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Find references for the word under your cursor.
				-- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				-- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				-- map("<leader>ld", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				-- Symbols are things like variables, functions, types, etc.
				-- map("<leader>lsd", require("telescope.builtin").lsp_document_symbols, "[L]sp [S]ymbols in [D]ocuments")

				-- Fuzzy find all the symbols in your current workspace
				--  Similar to document symbols, except searches over your whole project.
				-- map(
				-- 	"<leader>lsw",
				-- 	require("telescope.builtin").lsp_dynamic_workspace_symbols,
				-- 	"[Lsp] [S]ymbols in [W]orkspace "
				-- )

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				-- map("<leader>lr", vim.lsp.buf.rename, "[L]sp [R]ename")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				-- map("<leader>la", vim.lsp.buf.code_action, "[L]sp code [A]ction")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap
				-- map("<leader>lh", vim.lsp.buf.hover, "[L]sp [H]over Documentation")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP Specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			bashls = {},
			clangd = {},
			clojure_lsp = {},
			html = {},
			tsserver = {},
			zls = {},
			gopls = {
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		}

		require("mason").setup()
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		local on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		end

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					server.on_attach = on_attach
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
