-- https://github.com/slugbyte/whip.nvim
-- scrathpad manager

return {
    "slugbyte/whip.nvim",
    branch = "develop",
    dev = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local whip = require("whip")
        whip.setup({
            dir = "/home/slugbyte/workspace/data/text"
        })
        vim.keymap.set("", "<leader>W", whip.open, { desc = "[W]hip [O]pen" })
        vim.keymap.set("", "<leader><leader>wm", whip.make, { desc = "[W]hip [M]ake" })
        vim.keymap.set("", "<leader><leader>wd", whip.drop, { desc = "[W]hip [D]rop" })
        vim.keymap.set("", "<leader>w", whip.find_file, { desc = "[W]hip [F]ile Search" })
        vim.keymap.set("", "<leader><leader>wg", whip.find_grep, { desc = "[W]hip [G]rep Search" })
    end,
}
