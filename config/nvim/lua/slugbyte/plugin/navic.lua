return {
    "https://github.com/SmiteshP/nvim-navic",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    config = function()
        local navic = require("nvim-navic")
        navic.setup({
            icons = {
                File = "f ",
                Module = "m ",
                Namespace = "N ",
                Package = "",
                Class = "C ",
                Method = "M ",
                Property = "P ",
                Field = "F ",
                Constructor = "C ",
                Enum = "E",
                Interface = "I",
                Function = "F ",
                Variable = "V ",
                Constant = "C ",
                String = "S ",
                Number = "N ",
                Boolean = "B ",
                Array = "A ",
                Object = "O ",
                Key = "K ",
                Null = "N ",
                EnumMember = "E ",
                Struct = "S ",
                Event = "E ",
                Operator = "O ",
                TypeParameter = "T ",
            },
            lsp = {
                auto_attach = false,
                preference = nil,
            },
            highlight = true,
            separator = " > ",
            depth_limit = 0,
            depth_limit_indicator = "..",
            safe_output = true,
            lazy_update_context = false,
            click = false,
            format_text = function(text)
                return text
            end,
        })
    end,
}
