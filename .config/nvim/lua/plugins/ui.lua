local M = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme tokyonight]])
      end,
    },
    config = function()
      local auto_dark_mode = require("auto-dark-mode")
      auto_dark_mode.setup({
        set_dark_mode = function()
          vim.api.nvim_set_option("background", "dark")
        end,
        set_light_mode = function()
          vim.api.nvim_set_option("background", "light")
        end,
      })
      auto_dark_mode.init()
    end,
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = require("core.config").get_icons().general.indent,
      options = { try_as_border = false },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "NvimTree", "OUTLINE" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
  },
}

return M
