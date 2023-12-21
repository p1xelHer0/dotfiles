local ft = require("core.config").get_lisp_ft()

local M = {
  {
    dir = "/Users/p1xelher0/code/github/p1xelHer0/gerbil.nvim",
  },

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
      require("nvim-paredit").setup()
    end,
  },

  -- Parinfer variants
  {
    enabled = false,
    "gpanders/nvim-parinfer",
    ft = ft,
    config = function()
      require("nvim-parinfer").setup()
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
