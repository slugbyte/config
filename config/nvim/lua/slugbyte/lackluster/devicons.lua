local lackluster = require("lackluster")
require('nvim-web-devicons').setup({
    color_icons = false,
    override = {
        ["default_icon"] = {
            color = lackluster.color.gray4,
            name = "Default",
        }
    }
})
