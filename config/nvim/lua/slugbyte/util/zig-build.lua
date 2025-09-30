local job_id = nil
local output_buf = vim.api.nvim_create_buf(false, true)
local output_win = nil
local should_rerun = false
local slugbyte_define = require("slugbyte.define")
local should_follow = true

local follow_set = false

local M = {}

local is_zig_project_dir = function()
    return vim.loop.fs_stat("build.zig") ~= nil
end

local function buffer_tail_follow(buffer_number)
    if follow_set then
        return
    end
    follow_set = true
    vim.api.nvim_buf_attach(buffer_number, false, {
        on_lines = function()
            if output_win == nil then
                return
            end
            vim.schedule(function()
                if output_win == nil then
                    return
                end
                if should_follow then
                    vim.api.nvim_win_set_cursor(output_win, { vim.api.nvim_buf_line_count(buffer_number), 0 })
                end
            end)
        end,
    })
end

M.run = function()
    if not is_zig_project_dir() then
        print("not zig project")
        return
    end
    if job_id ~= nil then
        print("[zig] allready running")
        return
    end

    local is_vsplit = true

    if output_win == nil or (not vim.api.nvim_win_is_valid(output_win)) then
        local current_win = vim.api.nvim_get_current_win()
        local win_width = vim.api.nvim_win_get_width(current_win)
        if win_width > 150 then
            vim.cmd("botright vsplit")
        else
            vim.cmd("botright split")
            is_vsplit = false
        end
        buffer_tail_follow(output_buf)
        vim.api.nvim_set_current_buf(output_buf)
        output_win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(current_win)
    end

    vim.api.nvim_win_set_buf(output_win, output_buf)

    if is_vsplit then
        vim.api.nvim_win_set_width(output_win, 120)
    else
        vim.api.nvim_win_set_height(output_win, 15)
    end

    vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})
    vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, { "[exec] $ zig build run" })

    job_id = vim.fn.jobstart({ "zig", "build", slugbyte_define.SLUGBYTE_ZIG_BUILD_TASK, "-Dworkdir=/home/slugbyte/Dropbox/data/image/paint-dev" }, {
        on_exit = function()
            job_id = nil
            if should_rerun then
                should_rerun = false
                M.run()
            end
        end,
        on_stdout = function(_, data, _)
            for _, line in ipairs(data) do
                if line ~= "" then
                    vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, { "[....] " .. line })
                end
            end
        end,
        on_stderr = function(_, data, _)
            for _, line in ipairs(data) do
                if line ~= "" then
                    vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, { "[info] " .. line })
                end
            end
        end,
    })
end

M.kill = function()
    if not is_zig_project_dir() then
        print("not zig project")
        return
    end
    if job_id ~= nil then
        vim.fn.jobstop(job_id)
    end

    if output_win ~= nil and (vim.api.nvim_win_is_valid(output_win)) then
        vim.api.nvim_win_close(output_win, true)
        output_win = nil
    end
end

M.reset = function()
    if not is_zig_project_dir() then
        print("not zig project")
        return
    end
    if job_id ~= nil then
        should_rerun = true
        M.kill()
    else
        M.run()
    end
end

M.toggle_should_follow = function()
    should_follow = not should_follow
end

return M
