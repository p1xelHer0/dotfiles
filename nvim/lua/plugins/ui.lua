local M = {
  {
    dir = "~/code/codeberg/p1xelHer0/mibo",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) vim.cmd.colorscheme("mibo") end,
  },

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      -- vim.cmd.colorscheme("zenburned")
    end,
  },

  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) require("everforest").setup(opts) end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        harpoon = true,
        fidget = true,
      },
    },
    config = function(_, opts) end,
  },

  {
    url = "https://git.liten.app/krig/filth-theme",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) vim.o.background = "dark" end,
  },

  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts) end,
  },
}

return M
