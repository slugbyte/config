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

        local function search_fuzzy()
            telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end

        local function new_rg_source(builtin_name, cwd)
            if cwd == nil then
                return function()
                    telescope_builtin[builtin_name]({
                        hidden = true,
                    })
                end
            else
                return function()
                    telescope_builtin[builtin_name]({
                        hidden = true,
                        cwd = cwd,
                    })
                end
            end
        end

        local nvim_config_path = vim.fn.stdpath("config")
        local search_nvim_config_files = new_rg_source("find_files", nvim_config_path)
        local search_nvim_config_grep = new_rg_source("live_grep", nvim_config_path)

        local conf_path = vim.env.HOME .. "/workspace/conf"
        local search_conf_files = new_rg_source("find_files", conf_path)
        local search_conf_grep = new_rg_source("live_grep", conf_path)

        local search_files = new_rg_source("find_files")
        local search_grep = new_rg_source("live_grep")
        local search_grep_word = new_rg_source("grep_string")

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
