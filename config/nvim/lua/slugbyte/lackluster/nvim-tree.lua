require("nvim-tree").setup({
    renderer = {
        icons = {
            symlink_arrow = " -> ",
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
                modified = false,
                diagnostics = false,
                bookmarks = false,
            },
        }
    },
})
