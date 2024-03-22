-- this is my own keymap plugin for the workman keyboard layout
-- https://github.com/slugbyte/unruly-worker
return {
	-- url = "slugbyte/unruly-worker",
	dir = "~/workspace/code/unruly-worker",
	name = "unruly-worker",
	-- branch = "develop",
	event = "VimEnter",
	config = function()
		local unruly_worker = require("unruly-worker")
		unruly_worker.setup({})
	end,
}
