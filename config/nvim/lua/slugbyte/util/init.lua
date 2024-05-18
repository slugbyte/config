local M = {}

---@class SlugbyteKeymapConfig
---@field mode string
---@field is_remap ?boolean
---@field is_silent ?boolean
---@field is_expr ?boolean

---@param key string
---@param action string|function
---@param desc string
---@param config ?SlugbyteKeymapConfig
M.keymap = function(key, action, desc, config)
    config = config or {}
    local mode = config.mode or ""
    vim.keymap.set(mode, key, action, {
        desc = desc,
        remap = config.is_remap or false,
        noremap = not config.is_remap or true,
        silent = config.is_silent or false,
        expr = config.is_expr or false
    })
end

---@class SlugbyteUsercmdConfig
---@field nargs ?number number of args passed to command (default 0)
---@field action string|function
---@field desc string
---@field is_bang ?boolean use bang when exec (default false)
---@field is_overwrite ?boolean overwrite existing command (default true)

---@param name string
---@param config SlugbyteUsercmdConfig
M.usercmd = function(name, config)
    vim.api.nvim_create_user_command(name, config.action, {
        desc = config.desc,
        nargs = config.nargs or 0,
        bang = config.is_bang or false,
        force = config.is_overwrite or true,
    })
end
return M
