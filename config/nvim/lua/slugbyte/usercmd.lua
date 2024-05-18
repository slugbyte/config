local util = require("slugbyte.util")

util.usercmd("PluginAdd", {
    desc = "New Lazy Plugin",
    nargs = 1,
    action = function(opt)
        local name = opt.args
        vim.cmd(string.format(":e ~/.config/nvim/lua/slugbyte/plugin/%s.lua", name))
    end,
})

util.usercmd("Fg", {
    desc = "Set forground color of hi group to RED",
    nargs = 1,
    action = function(opt)
        local name = opt.args
        vim.cmd(string.format(":hi %s guifg=#ff0000", name))
    end,

})

util.usercmd("Bg", {
    desc = "Set forground color of hi group to RED",
    nargs = 1,
    action = function(opt)
        local name = opt.args
        vim.cmd(string.format(":hi %s guibg=#ff0000", name))
    end,
})
