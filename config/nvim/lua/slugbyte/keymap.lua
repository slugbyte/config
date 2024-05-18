local util = require("slugbyte.util")

local treesiter_inspect = function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    print(vim.inspect(result))
end
util.keymap("<C-g>", treesiter_inspect, "Debug Treesitter Under Cursor")
