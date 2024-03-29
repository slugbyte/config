-- this is my own keymap plugin for the workman keyboard layout
-- https://github.com/slugbyte/unruly-worker
return {
	"slugbyte/unruly-worker",
	-- dir = "/Users/slugbyte/workspace/code/unruly-worker",
	-- name = "unruly-worker",
	lazy = false,
	branch = "develop",
	dev = true,
	priority = 0, -- make sure to load this before all the other start plugins

	-- event = "VimEnter",
	config = function()
		local unruly_worker = require("unruly-worker")
		unruly_worker.setup({})
	end,
}
