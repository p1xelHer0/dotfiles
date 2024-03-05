local M = {
  enabled = true,
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    {
      "rcarriga/nvim-dap-ui",
      opts = {},
      config = function(_, opts)
        require("dapui").setup(opts)
      end,
    },
    -- "jbyuki/one-small-step-for-vimkind",
  },
  config = function()
    local dap = require("dap")
    dap.adapters.lldb = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
      name = "lldb",
    }

    local lldb_zig = {
      name = "Launch lldb",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-build/bin/")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    }

    local lldb_odin = {
      name = "Launch lldb",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.bin/main")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      preLaunchTask = "build",
      runInTerminal = false,
    }


    dap.configurations.zig = {
      lldb_zig,
    }

    dap.configurations.odin = {
      lldb_odin,
    }


    require("keymap.dap").setup()
  end,
}

return M
