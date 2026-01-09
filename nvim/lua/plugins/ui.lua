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

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function(_, _)
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
        },
      }

      return opts
    end,
  },
}

return M
