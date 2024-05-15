-- https://github.com/stevearc/oil.nvim
--
return {
    "stevearc/oil.nvim",
    config = function()
        local oil = require("oil")

        local popoup_config = {
            border  = "none",
            padding = 2,
        }

        oil.setup({
            delete_to_trash = true,
            use_default_keymaps = false,
            float = popoup_config,
            progress = popoup_config,
            preview = popoup_config,
            keymaps_help = popoup_config,
            ssh = popoup_config,
            columns = {
                "permissions",
                "size",
            },
            keymaps = {
                ["<c-k>"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-p>"] = "actions.preview",
                ["<C-x>"] = "actions.close",
                ["<C-r>"] = "actions.refresh",
                ["<C-o>"] = "actions.open_external",
                ["."] = "actions.parent",
                ["~"] = "actions.open_cwd",
                ["gc"] = "actions.cd",
                ["gs"] = "actions.change_sort",
                ["gt"] = "actions.toggle_trash",
            },
            view_options = {
                show_hidden = true,
            },
        })
        vim.keymap.set("n", "<leader><leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
