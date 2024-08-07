require("bufferline").setup({
    options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        groups = {
            -- options = {
            --     toggle_hidden_on_enter = false -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
            -- },
            items = {
                {
                    name = "lua", -- Mandatory
                    priority = 2, -- determines where it will appear relative to other groups (Optional)
                    icon = "", -- Optional
                    auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                    matcher = function(buf) -- Mandatory
                        if buf.filename then
                            print("match lua")
                            return buf.filename:match("%.lua")
                        end
                    end,
                },
                {
                    name = "doc",
                    auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                    matcher = function(buf)
                        if buf.filename then
                            print("match doc")
                            return buf.filename:match("%.md")
                        else
                            print("nomatch doc")
                        end
                    end,
                },
            },
        },
    },
})
