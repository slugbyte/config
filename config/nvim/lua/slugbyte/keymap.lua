local util = require("slugbyte.util")
local plenary_reload = require("plenary.reload")

util.keymap("<C-g>", ":Inspect<CR>", "Debug highlight under cursor")
util.keymap("<leader>tz", ":Telescope zoxide list<CR>", "[T]elescope [Z]oxide")

local colorscheme_reload = function()
    plenary_reload.reload_module("lackluster")
    require("lackluster").load()
    print("Reloaded Lackluster")
end
util.keymap("<leader>c", colorscheme_reload, "[C]olorsheche [R]eload")
