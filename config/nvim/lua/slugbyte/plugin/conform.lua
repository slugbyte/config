-- a Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim
--
-- formatter
-- lua https://github.com/JohnnyMorganz/StyLua
-- go goimports https://pkg.go.dev/golang.org/x/tools/cmd/goimports
-- go gofmt https://pkg.go.dev/cmd/gofmt#section-sourcefiles
-- go golines https://github.com/segmentio/golines
-- templ https://templ.guide/quick-start/installation
-- sh https://github.com/koalaman/shellcheck

return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			-- lua = { "stylua" },
			go = { "goimports", "gofmt", "golines" },
			templ = { "templ" },
			-- zig = { " zigfmt" },
			-- sh = { "shellcheck" },
		},
	},
}
