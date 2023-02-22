local M = {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  { "tpope/vim-repeat", event = "VeryLazy" },
}

return M
