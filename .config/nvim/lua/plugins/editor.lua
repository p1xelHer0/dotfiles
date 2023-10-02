local M = {
  { "editorconfig/editorconfig-vim", event = "VeryLazy" },

  { "tpope/vim-repeat", event = "VeryLazy" },

  { "tpope/vim-abolish", event = "VeryLazy" },

  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<Leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  {
    "andymass/vim-matchup",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    url = "https://git.sr.ht/~p00f/nvim-ts-rainbow",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "fnl", "clj", "lisp", "lsp", "cl", "fasl", "rkt" },
    config = function()
      -- https://github.com/p00f/nvim-ts-rainbow/issues/30
      local enabled_list = { "clojure", "fennel", "commonlisp", "query", "scheme", "racket" }
      local parsers = require("nvim-treesitter.parsers")
      local rainbow = {
        extended_mode = true,
        enable = true,
        disable = vim.tbl_filter(function(p)
          local disable = true
          for _, lang in pairs(enabled_list) do
            if p == lang then
              disable = false
            end
          end
          return disable
        end, parsers.available_parsers()),
      }

      require("nvim-treesitter.configs").setup({ rainbow = rainbow })
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    opts = {
      user_default_options = {
        names = false,
        mode = "background",
      },
      tailwind = true,
    },
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    cmd = {
      "TailwindColorsAttach",
      "TailwindColorsDeatach",
      "TailwindColorsRefresh",
      "TailwindColorsToggle",
    },
  },
}

return M
