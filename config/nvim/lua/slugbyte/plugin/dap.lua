return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "julianolf/nvim-dap-lldb",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            local define = require("slugbyte/define")

            dap.configurations.zig = {
                {
                    name = "Run Program",
                    type = "lldb",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    program = function()
                        -- Build with debug symbols
                        local out = vim.fn.system({ "zig", "build" })
                        -- Check for errors
                        if vim.v.shell_error ~= 0 then
                            vim.notify(out, vim.log.levels.ERROR)
                            return nil
                        end
                        -- Return path to the debuggable program
                        return define.zig_dap_exe
                    end,
                },
            }

            require("dapui").setup({
                controls = {
                    enabled = false,
                },
                layouts = {
                    {
                        elements = {
                            {
                                id = "watches",
                                size = 0.25,
                            },
                            {
                                id = "scopes",
                                size = 0.25,
                            },
                            {
                                id = "breakpoints",
                                size = 0.25,
                            },
                        },
                        -- {
                        --     id = "stacks",
                        --     size = 0.25,
                        -- },
                        position = "left",
                        size = 40,
                    },
                },
            })
            -- require("nvim-dap-virtual-text").setup({})

            require("dap-lldb").setup({})

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            -- dap.listeners.before.event_terminated.dapui_config = function()
            --     ui.close()
            -- end
            -- dap.listeners.before.event_exited.dapui_config = function()
            --     ui.close()
            -- end
        end,
    },
}
