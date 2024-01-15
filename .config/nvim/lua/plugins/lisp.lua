local ft = require("core.config").get_lisp_ft()

local M = {
  {
    enabled = true,
    dir = "/Users/p1xelher0/code/github/p1xelHer0/gerbil.nvim",
    ft = "scheme",
    opts = {
      conjure = {
        setup = true,
        command = "gxi",
        prompt_pattern = "%d*> ",
      },
      paredit = {
        setup = true,
      },
    },
  },

  -- {
  --   "p1xelHer0/gerbil.nvim",
  --   ft = "scheme",
  --   -- Default settings
  --   opts = {
  --     conjure = {
  --       setup = true,
  --       command = "gxi",
  --       prompt_pattern = "%d*> ",
  --     },
  --   },
  -- },

  -- vim-sexp variants
  {
    enabled = false,
    "tpope/vim-sexp-mappings-for-regular-people",
    dependencies = {
      "guns/vim-sexp",
      "tpope/vim-surround",
    },
    ft = ft,
  },

  -- Paredit variants
  {
    enabled = true,
    "julienvincent/nvim-paredit",
    ft = ft,
    config = function()
      require("nvim-paredit").setup({
        indent = {
          enabled = true,
        },
      })
    end,
  },

  -- Parinfer variants
  {
    enabled = false,
    "gpanders/nvim-parinfer",
    ft = ft,
    init = function()
      vim.b.parinfer_comment_chars = { ";", "#;" }
    end,
  },

  {
    enabled = false,
    "eraserhd/parinfer-rust",
    ft = ft,
    build = "cargo build --release",
  },
}

return M
