-- this is my own keymap plugin for the workman keyboard layout
-- https://github.com/slugbyte/unruly-worker
return {
	"slugbyte/unruly-worker",
	branch = "develop",
	event = "VimEnter",
	config = function()
		local unruly_worker = require("unruly-worker")
		unruly_worker.setup({})
	end,
}
