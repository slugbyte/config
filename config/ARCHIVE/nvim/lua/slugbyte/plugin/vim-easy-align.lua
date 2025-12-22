-- "https://github.com/junegunn/vim-easy-align"
return {
    "junegunn/vim-easy-align",
    config = function()
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "Easy Align" })
    end,
}
