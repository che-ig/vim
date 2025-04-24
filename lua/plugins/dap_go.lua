-- An extension for nvim-dap providing configurations for launching go debugger (delve) and debugging individual tests.
-- https://github.com/leoluz/nvim-dap-go
require('dap-go').setup { -- Additional dap configurations can be added.
    -- dap_configurations accepts a list of tables where each entry
    -- represents a dap configuration. For more details do:
    -- :help dap-configuration
    dap_configurations = {
        {type = "go", name = "Debug 1", request = "launch", program = "${file}"},
        {
            type = "go",
            name = "Debug test 1",
            request = "launch",
            mode = "test", -- Mode is important
            program = "${file}"
        }
    }, -- delve configurations
    delve = { -- the path to the executable dlv which will be used for debugging.
        -- by default, this is the "dlv" executable on your PATH.
        path = "dlv", -- time to wait for delve to initialize the debug session.
        -- defaul:t to 20 seconds
        -- initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port
        port = "${port}", -- additional args to pass to dlv
        args = {}
    }
}
