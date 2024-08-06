print("nocie")
local noice = require("noice")
noice.setup({
    notify = {
        enabled = true, -- enables the Noice messages UI
    },
    commands = {
        last = {
            view = "split",
        },
    },
    messages = {
        enabled = true, -- enables the Noice messages UI
        --     view = "messages",           -- default view for messages
        --     view_error = "messages",     -- view for errors
        --     view_warn = "messages",      -- view for warnings
        --     view_history = "messages",   -- view for :messages
        --     view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    cmdline = {
        format = {
            cmdline = { icon = ":" },
            search_down = { icon = "/" },
            search_up = { icon = "\\" },
            filter = { icon = "$" },
            lua = { icon = ">" },
            help = { icon = "?" },
        },
    },
    format = {
        level = {
            icons = false,
        },
    },
    popupmenu = {
        kind_icons = false,
    },
    inc_rename = {
        cmdline = {
            format = {
                IncRename = { icon = "!" },
            },
        },
    },
})
