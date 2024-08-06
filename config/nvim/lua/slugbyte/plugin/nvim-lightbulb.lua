-- https://github.com/kosayoda/nvim-lightbulb
return {
    "kosayoda/nvim-lightbulb",
    config = function()
        require("nvim-lightbulb").setup({
            autocmd = {
                enabled = true,
                updatetime = -1,
                events = { "CursorHold", "CursorHoldI" },
            },
            virtual_text = {
                enabled = true,
                text = "!",
                hl = "LightBulbSign",
            },
            sign = {
                enabled = false,
                text = "!!",
                hl = "LightBulbSign",
                hl_mode = "combine",
            },
        })
    end,
}
