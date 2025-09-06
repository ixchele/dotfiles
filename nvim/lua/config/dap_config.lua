local dap = require("dap")

-- Adapter pour GDB via OpenDebugAD7
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "/home/zbengued/.local/share/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

-- Configurations pour C et C++
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

-- Alias pour C
dap.configurations.c = dap.configurations.cpp
