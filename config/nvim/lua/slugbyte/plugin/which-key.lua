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

        require("which-key").setup({
            popup_mappings = {
                scroll_down = "<PageDown>", -- binding to scroll down inside the popup
                scroll_up = "<PageUp>",     -- binding to scroll up inside the popup
            },
            triggers = { "<leader>" },
        })

        require("which-key").register({
            ["<leader>j"] = { search_conf_files, "[J]ump Config Files" },
            ["<leader>J"] = { search_conf_grep, "[J]ump Config Grep" },
            ["<leader><Leader>"] = {
                name = "[S]pecial",
                ["w"] = {
                    name = "[W]hip"
                },
            },
            ["<leader>c"] = {
                name = "[C]heck Spelling"
            },
            ["<leader>t"] = {
                name = "[T]elescope"
            },
            ["<leader>l"] = {
                name = "[L]sp+"
            },
            ["<leader>z"] = {
                name = "[Z] Macro"
            },
            ["<leader>s"] = {
                name = "[S]eek"
            },
            ["<leader>d"] = {
                name = "[D]iagnostic"
            },
            ["<leader>?"] = { ":WhichKey<CR>", "[K]eys" },
        })
    end,
}
