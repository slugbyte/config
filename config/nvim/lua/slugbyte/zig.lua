local job_id = nil
local output_buf = vim.api.nvim_create_buf(false, true)
local output_win = nil
local should_rerun = false

local M = {}

M.run = function()
    if job_id ~= nil then
        print("[zig] allready running")
        return
    end

    if output_win == nil or (not vim.api.nvim_win_is_valid(output_win)) then
        local current_win = vim.api.nvim_get_current_win()
        vim.cmd("vsplit")
        output_win = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(current_win)
    end

    vim.api.nvim_win_set_buf(output_win, output_buf)
    vim.api.nvim_win_set_width(output_win, 70)

    vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})
    vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, { "[exec] $ zig build run" })

    job_id = vim.fn.jobstart({ "zig", "build", "run" }, {
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
    if job_id ~= nil then
        vim.fn.jobstop(job_id)
    end

    if output_win then
        vim.api.nvim_win_close(output_win, true)
        output_win = nil
    end
end

M.reset = function()
    if job_id ~= nil then
        should_rerun = true
        M.kill()
    else
        M.run()
    end
end

return M
