local util = require("slugbyte.util")

util.usercmd("PluginAdd", {
    desc = "New Lazy Plugin",
    nargs = 1,
    action = function(opt)
        local name = opt.args
        vim.cmd(string.format(":e ~/.config/nvim/lua/slugbyte/plugin/%s.lua", name))
    end,
})

local treesiter_inspect = function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    print(vim.inspect(result))
end

util.usercmd("HiDebug", {
    desc = "Print the syntax highlight under cursor",
    action = function()
        local hi_list_len = 0
        local hi_list = {}

        local ts_list = vim.treesitter.get_captures_at_cursor(0)
        for _, ts_item in ipairs(ts_list) do
            table.insert(hi_list, "@" .. ts_item)
            hi_list_len = hi_list_len + 1
        end

        local synstack = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
        for _, syn_id in ipairs(synstack) do
            local hi_item = vim.fn.synIDattr(vim.fn.synIDtrans(syn_id), "name")
            table.insert(hi_list, hi_item)
            hi_list_len = hi_list_len + 1
        end


        if hi_list_len > 0 then
            print(table.concat(hi_list, ", "))
        else
            print("no highlight group found")
        end
    end,
})

util.usercmd("HiFg", {
    desc = "Set forground color of hi group to RED",
    action = function()
        local synname = nil

        -- loop synnames
        local synstack = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
        for _, syn_id in ipairs(synstack) do
            synname = vim.fn.synIDattr(vim.fn.synIDtrans(syn_id), "name")
        end

        -- loop treesiter captures
        local ts_list = vim.treesitter.get_captures_at_cursor(0)
        for _, ts_item in ipairs(ts_list) do
            synname = "@" .. ts_item
        end

        if synname ~= nil then
            vim.cmd(string.format(":hi %s guifg=#ff0000", synname))
            print("synname: " .. synname)
        else
            print("no highlight group found")
        end
    end,
})

util.usercmd("HiBg", {
    desc = "Set forground color of hi group to RED",
    action = function()
        local synname = nil
        local synstack = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
        -- loop synnames
        for _, syn_id in ipairs(synstack) do
            synname = vim.fn.synIDattr(vim.fn.synIDtrans(syn_id), "name")
        end
        -- loop treesiter captures
        local ts_list = vim.treesitter.get_captures_at_cursor(0)
        for _, ts_item in ipairs(ts_list) do
            synname = "@" .. ts_item
        end
        if synname ~= nil then
            vim.cmd(string.format(":hi %s guibg=#ff0000", synname))
            print("synname: " .. synname)
        else
            print("no highlight group found")
        end
    end,
})
