local lisps = {
  "clojure",
  "fennel",
  "janet",
  "lisp",
  "racket",
  "scheme",
}

local M = {
  --   enabled = false,
  --   "Olical/conjure",
  --   -- ft = lisps,
  --   opts = {},
  --   config = function(_, opts)
  --     require("conjure.main").main()
  --     require("conjure.mapping")["on-filetype"]()
  --   end,
  --   init = function()
  --     vim.g["conjure#debug"] = false
  --     vim.g["conjure#extract#tree_sitter#enabled"] = true
  --
  --     vim.g["conjure#mapping#log_split"] = "lx" -- most other plugins use `x`
  --
  --     -- Common Lisp
  --     vim.g["conjure#client#common_lisp#swank#connection#default_port"] = 50005
  --
  --     -- Gambit
  --     vim.g["conjure#client#scheme#stdio#command"] = "gsi"
  --     vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "%d*> "
  --     vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
  --   end,
  --
  --   -- vim-sexp variants
  --   {
  --     enabled = false,
  --     "tpope/vim-sexp-mappings-for-regular-people",
  --     dependencies = {
  --       "guns/vim-sexp",
  --       "tpope/vim-surround",
  --     },
  --     -- ft = lisps,
  --   },

  -- Paredit variants
  {
    enabled = false,
    "julienvincent/nvim-paredit",
    -- ft = lisps,
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
    -- ft = lisps,
    init = function() vim.b.parinfer_comment_chars = { ";", "#;" } end,
  },

  {
    enabled = true,
    "eraserhd/parinfer-rust",
    ft = lisps,
    build = "cargo build --release",
  },

  {
    enabled = true,
    "hiphish/rainbow-delimiters.nvim",
    ft = lisps,
    opts = {
      strategy = {
        -- ...
      },
      query = {
        -- ...
      },
    },
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
      vim.api.nvim_set_hl(0, "@punctuation.bracket.scheme", { link = "DiagnosticUnderlineError" })
    end,
  },

  {
    "bakpakin/janet.vim",
    ft = lisps,
  },
}

return M
