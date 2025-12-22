local M = {}

-- effects slugbyte.util.zig.lua
M.SLUGBYTE_ZIG_BUILD_TASK = "run"
M.SLUGBYTE_ZIG_RUN_USE_DAP = false
M.SLUGBYTE_ZIG_DAP_EXE_PATH = "./zig-out/bin/paint"

M.RUNTIME_PATH = vim.split(package.path, ";")
table.insert(M.RUNTIME_PATH, "lua/?.lua")
table.insert(M.RUNTIME_PATH, "lua/?/init.lua")

return M
