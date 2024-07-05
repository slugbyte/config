-- use the Treesitter parser-generator to improve nav, highlight, and more
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
--
-- * Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
-- * Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- "nvim-treesitter/nvim-treesitter-context",
-- https://github.com/theHamsta/crazy-node-movement
return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local unruly_textobjects = require("unruly-worker.external.textobjects")

        require("nvim-treesitter.configs").setup({
            modules = {},
            -- ensure_installed = { "arduino", "bash", "c", "clojure", "css", "csv",
            -- "diff", "gitcommit", "gitignore", "glsl", "go", "html", "javascript",
            -- "json", "lua", "make", "markdown", "sql", "templ", "toml", "tsv",
            -- "typescript", "vim", "vimdoc", "yaml", "tmux", "zig", },
            sync_install = false,
            auto_install = false,
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    node_decremental = "<bs>",
                    scope_incremental = false,
                },
            },
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    if lang == "tmux" or lang == "sql" or lang == "help" then
                        return true
                    end

                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                    return false
                end,
                additional_vim_regex_highlighting = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    include_surrounding_whitespace = false,
                    keymaps = unruly_textobjects.select_keymaps,
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = unruly_textobjects.move_goto_next_start,
                    goto_previous_start = unruly_textobjects.move_goto_previous_start,
                    goto_next_end = unruly_textobjects.move_goto_next_end,
                    goto_previous_end = unruly_textobjects.move_goto_previous_end,
                },
            },
        })
    end,
}
