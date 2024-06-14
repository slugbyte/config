local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        import = "slugbyte/plugin"
    },
    {
        ui = {
            icons = {
                cmd = " ",
                config = " ",
                event = " ",
                ft = " ",
                init = " ",
                import = " ",
                keys = " ",
                lazy = " ",
                loaded = "●",
                not_loaded = "○",
                plugin = " ",
                runtime = " ",
                require = " ",
                source = " ",
                start = " ",
                task = "✔ ",
                list = {
                    "●",
                    "➜",
                    "★",
                    "‒",
                },
            },
        },
        change_detection = {
            enabled = true,
            notify = false,
        },
        install = { colorscheme = { "lackluster-hack" } },
        dev = {
            path = "~/workspace/code/neovim"
        },
    }
)
