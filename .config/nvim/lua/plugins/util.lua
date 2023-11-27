local M = {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle",
    },
    ft = "markdown",
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  {
    enabled = false,
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },

  {
    "narutoxy/silicon.lua",
    opts = {
      theme = "auto",
      output = "/Users/p1xelher0/code/github/p1xelHer0/sh1tp0st/silicon/${year}-${month}-${date}_${time}.png",
      bgColor = require("internal.helpers").get_highlight("Normal", "fg"),
      bgImage = "",
      roundCorner = false,
      windowControls = false,
      lineNumber = false,
      font = "IosevkaTerm Nerd Font Mono",
      lineOffset = 0,
      linePad = 3,
      padHoriz = 30,
      padVert = 30,
      shadowBlurRadius = 0,
      shadowColor = "#555555",
      shadowOffsetX = 0,
      shadowOffsetY = 0,
      gobble = false,
      debug = false,
    },
    keys = {
      {
        "<F12>",
        function()
          vim.opt_local.cursorline = false
          require("silicon").visualise_api({ show_buf = true })
          vim.opt_local.cursorline = true
        end,
        mode = "n",
      },
      {
        "<F12>",
        function()
          require("silicon").visualise_api({})
        end,
        mode = "v",
      },
    },
    config = function(_, opts)
      require("silicon").setup(opts)
      require("core.autocmd").silicon_setup()
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
  },

  { "nvim-lua/plenary.nvim", lazy = true },
}

return M
