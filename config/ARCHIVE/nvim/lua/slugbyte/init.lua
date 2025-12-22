-- ######################################################################### options
vim.g.mapleader = " "
vim.g.local_leader = " "
vim.opt.runtimepath:append(",~/workspace/code/learn/learn-lua/nvim")

vim.opt.scrolloff = 4
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = "100"

vim.g.is_bash = true
vim.g.tmux_navigator_no_mappings = 1
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noinsert"
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.foldenable = false
-- vim.opt.foldcolumn = "auto"
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 2
vim.opt.hlsearch = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = { tab = ".  ", trail = "·", nbsp = "␣" }

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showbreak = "**"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = false
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.wrap = false

-- ######################################################################### LOAD PLUGINS
require("slugbyte.lazy")

-- ######################################################################### AUTOCMD

-- mometary auto highlight after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- only show cursorline on active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    desc = "enable cursorline when entering a window",
    callback = function()
        vim.wo.cursorline = true
    end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    desc = "disable cursorline when leaving a window",
    callback = function()
        vim.wo.cursorline = false
    end,
})

-- check for changes on vim focus
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    desc = "check for changes on nvim focus",
    command = "checktime",
})

-- vim resize splits
vim.api.nvim_create_autocmd("VimResized", {
    desc = "resize splits on vim resize",
    command = "tabdo wincmd =",
})

-- ######################################################################### USERCMD
-- reload nvim config
vim.api.nvim_create_user_command("ConfigReload", "luafile " .. vim.env.MYVIMRC, {
    desc = "reload nvim config",
})

-- ######################################################################### KEYMAP
local util = require("slugbyte.util")
local lackluster = require("lackluster.dev")
local telescope_builtin = require("telescope.builtin")
local zig = require("slugbyte.util.zig-build")
local dap = require("dap")
local unruly_worker = require("unruly-worker")
local slugbyte_define = require("slugbyte.define")

-- telescope diagnostics
util.keymap("<leader>d", unruly_worker.boost.telescope.diagnostics, "[D]iagnostic Search")

-- lackluster dev helpers
local colorscheme_list = { nil, "dark", "mint", "hack", "night" }
local colorscheme_index = 1
local colorscheme_index_max = #colorscheme_list

-- lackluster reload
util.keymap("<leader>cr", function()
    local colorscheme_name = colorscheme_list[colorscheme_index]
    lackluster.lackluster_reload({ theme = colorscheme_name })
end, "[C]olorsheche [R]eload")

-- lackluster load next theme
util.keymap("<leader>cn", function()
    colorscheme_index = colorscheme_index + 1
    if colorscheme_index > colorscheme_index_max then
        colorscheme_index = 1
    end

    local colorscheme_name = colorscheme_list[colorscheme_index]
    lackluster.lackluster_reload({ theme = colorscheme_name })
end, "[C]olorsheche [N]ext")

--- craete fn that applys spellgood or spellwrong to the word under the cursor
local spellfunc_create = function(is_spellgood)
    local spell_cmd = "spellgood"
    if is_spellgood then
        spell_cmd = "spellwrong"
    end
    return function()
        local reg_a_buf = vim.fn.getreg("a")
        vim.cmd('silent! normal! viw"ay')
        local word = vim.fn.getreg("a")
        vim.fn.setreg("a", reg_a_buf)
        if word == "" or word == nil then
            return
        end
        vim.cmd(string.format("silent! %s %s", spell_cmd, word))
        print(string.format("%s: %s", spell_cmd, word))
    end
end

util.keymap("<leader>cs", telescope_builtin.spell_suggest, "[C]heck [S]pell")
util.keymap("<leader>cg", spellfunc_create(true), "[C]heck Spell [G]ood")
util.keymap("<leader>cw", spellfunc_create(false), "[C]heck Spell [B]ad")

util.keymap("gs", "gg", "goto start")
util.keymap("ge", "G", "goto end")

util.keymap("s", telescope_builtin.lsp_document_symbols, "document lsp_document_symbols")

if slugbyte_define.SLUGBYTE_ZIG_RUN_USE_DAP then
    vim.keymap.set("n", "<C-b>", function()
        if dap.session() then
            dap.terminate({
                on_done = function()
                    dap.run_last()
                end,
            })
        else
            vim.cmd("DapNew")
        end
    end)

    vim.keymap.set("n", "<space>bt", dap.toggle_breakpoint)
    vim.keymap.set("n", "<space>by", dap.continue)
    vim.keymap.set("n", "<space>bn", dap.step_over)
    vim.keymap.set("n", "<space>bi", dap.step_into)
    vim.keymap.set("n", "<space>bo", dap.step_out)
    vim.keymap.set("n", "<space>bb", dap.step_back)
    vim.keymap.set("n", "<space>bx", dap.terminate)
else
    util.keymap("<C-b>", zig.reset, "reset zig build")
    util.keymap("<leader>zr", zig.run, "zig run build")
    util.keymap("<leader>zk", zig.kill, "zig kill")
    util.keymap("<leader>zf", zig.toggle_should_follow, "zig log follow toggle")
end
