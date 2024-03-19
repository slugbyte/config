-- this is my own keymap plugin for the workman keyboard layout
-- https://github.com/slugbyte/unruly-worker
return {
	"slugbyte/unruly-worker",
	branch = "develop",
	event = "VimEnter",
	config = function()
		local unruly_worker = require("unruly-worker")
		unruly_worker.setup({
			-- enable_lsp_map = true,
			-- enable_select_map = false,
			-- enable_quote_command = false,
			-- enable_easy_window_navigate = true,
			-- enable_comment_map = true,
			-- enable_wrap_navigate = true,
			-- enable_visual_navigate = true,
			-- enable_double_jump = true,
			-- enable_quick_macro = true,
			-- enable_easy_source = true,
		})
	end,
}
