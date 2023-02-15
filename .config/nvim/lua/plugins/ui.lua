local M = {
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      {
        "projekt0n/github-nvim-theme",
        config = function()
          require("github-theme").setup({
            function_style = "italic",
            sidebars = { "nvimtree", "qf", "terminal", "packer" },
          })
        end,
      },
      { dir = "~/code/github/rktjmp/p1xel" },
    },
    config = function()
      local dark_colorscheme = "github_dark_default"
      -- local dark_colorscheme = "p1xel"
      local light_colorscheme = "github_light_default"
      -- local light_colorscheme = "p1xel"
      local auto_dark_mode = require("auto-dark-mode")
      auto_dark_mode.setup({
        set_dark_mode = function()
          vim.api.nvim_set_option("background", "dark")
          vim.cmd.colorscheme(dark_colorscheme)
        end,
        set_light_mode = function()
          vim.api.nvim_set_option("background", "light")
          vim.cmd.colorscheme(light_colorscheme)
        end,
      })
      auto_dark_mode.init()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>" },
      { "<C-j>" },
      { "<C-k>" },
      { "<C-l>" },
    },
  },
}

return M
