local M = {
  enabled = false,
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
    require("keymap.dap").setup()
  end,
}

return M
