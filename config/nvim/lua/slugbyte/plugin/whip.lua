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
            dir = "/Users/slugbyte/workspace/data/text"
        })
        vim.keymap.set("", "<leader>w", whip.open, { desc = "whip Open" })
        vim.keymap.set("", "<leader><leader>wn", whip.make, { desc = "whip Make" })
        vim.keymap.set("", "<leader><leader>wf", whip.find_file, { desc = "whip File Search" })
        vim.keymap.set("", "<leader><leader>wg", whip.find_grep, { desc = "whip Grep Search" })
    end,
}
