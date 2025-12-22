-- displays a popup with possible key bindings
-- https://github.com/folke/which-key.nvim
return {
    "folke/which-key.nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local telescope_builtin = require("telescope.builtin")
        local function telescope_dir_searcher_create(builtin_name, cwd)
            return function()
                telescope_builtin[builtin_name]({
                    hidden = true,
                    cwd = cwd,
                })
            end
        end

        local conf_path = vim.env.HOME .. "/workspace/conf"
        local search_conf_files = telescope_dir_searcher_create("find_files", conf_path)
        local search_conf_grep = telescope_dir_searcher_create("live_grep", conf_path)

        local which_key = require("which-key")
        which_key.add({
            { "<leader>j", search_conf_files, desc = "[J]ump Config Files" },
            { "<leader>J", search_conf_grep, desc = "[J]ump Config Grep" },
            { "<leader><leader>", group = "[S]pecial" },
            { "<leader><leader>w", group = "[W]hip" },
            { "<leader>c", group = "[C]heck Spelling" },
            { "<leader>t", group = "[T]elescope" },
            { "<leader>l", group = "[L]sp" },
            { "<leader>z", group = "[M]acro" },
            { "<leader>s", group = "[S]eek" },
            { "<leader>d", group = "[D]iagnostic" },
            { "<leader>?", ":WhichKey<CR>", group = "[K]eys" },
        })
    end,
}
