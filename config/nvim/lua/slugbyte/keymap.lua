local util = require("slugbyte.util")
local lackluster = require("lackluster.dev")
local telescope_builtin = require("telescope.builtin")
local ts_actions = require("telescope.actions")
local ts_actions_state = require("telescope.actions.state")
local ts_actions_set = require("telescope.actions.set")
local telescope_themes = require("telescope.themes")

util.keymap("<C-g>", ":Inspect<CR>", "Debug highlight under cursor")
util.keymap("<leader>tz", ":Telescope zoxide list<CR>", "[T]elescope [Z]oxide")

local theme_list = { nil, "dark", "mint", "hack", "night" }
-- local theme_list = { "night", nil }
local theme_index = 1
local theme_index_max = #theme_list

util.keymap("<leader>cr", function()
    -- local theme_name = theme_list[theme_index]
    local theme_name = theme_list[theme_index]
    lackluster.lackluster_reload({ theme = theme_name })
end, "[C]olorsheche [R]eload")

util.keymap("<leader>cn", function()
    theme_index = theme_index + 1
    if theme_index > theme_index_max then
        theme_index = 1
    end

    local theme_name = theme_list[theme_index]
    lackluster.lackluster_reload({ theme = theme_name })
end, "[C]olorsheche [N]ext")


local spellfunc = function(spell_cmd)
    return function()
        local reg_a_buf = vim.fn.getreg("a")
        vim.cmd("silent! normal! viw\"ay")
        local word = vim.fn.getreg("a")
        vim.fn.setreg("a", reg_a_buf)
        if word == "" or word == nil then
            return
        end
        vim.cmd(string.format("silent! %s %s", spell_cmd, word))
        print(string.format("%s: %s", spell_cmd, word))
    end
end

local spellgood = spellfunc("spellgood")
local spellwrong = spellfunc("spellwrong")

util.keymap("<leader>cs", telescope_builtin.spell_suggest, "[C]heck [S]pell")
util.keymap("<leader>cg", spellgood, "[C]heck Spell [G]ood")
util.keymap("<leader>cw", spellwrong, "[C]heck Spell [B]ad")

local symbol_search = function()
    telescope_builtin.lsp_document_symbols(
        telescope_themes.get_dropdown({
            previewer = false,
            attach_mappings = function(prompt_bufnr, _)
                ts_actions.select_default:replace(function()
                    vim.schedule(function()
                        vim.cmd("normal! zt")
                    end)
                    ts_actions_set.select(prompt_bufnr, "default")
                end)
                return true
            end
        })
    )
end

util.keymap("s", symbol_search, "[S]ymbol search");
