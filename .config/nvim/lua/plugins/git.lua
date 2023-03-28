local M = {
  {
    "TimUntersberger/neogit",
    dependencies = { "sindrets/diffview.nvim", "nvim-lua/plenary.nvim" },
    cmd = { "Neogit", "Neogit " },
    opts = {
      integrations = {
        diffview = true,
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewLog",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    config = true,
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Gitsigns " },
    opts = {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = require("core.config").get_icons().general.indent,
          numhl = "GitSignsAddNr",
        },
        change = {
          hl = "GitSignsChange",
          text = require("core.config").get_icons().general.indent,
          numhl = "GitSignsChangeNr",
        },
        delete = {
          hl = "GitSignsDelete",
          text = "_",
          numhl = "GitSignsDeleteNr",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "‾",
          numhl = "GitSignsDeleteNr",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = require("core.config").get_icons().general.indent,
          numhl = "GitSignsChangeNr",
        },
        untracked = {
          hl = "GitSignsAdd",
          text = require("core.config").get_icons().general.indent,
          numhl = "GitSignsAddNr",
        },
      },
      on_attach = function(bufnr)
        require("keymap.git").setup(bufnr)
      end,
    },
  },

  {
    "rbong/vim-flog",
    dependencies = { "tpope/vim-fugitive" },
    cmd = { "Flog", "Flogsplit" },
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Gdiffsplit",
      "Gedit",
      "Git",
      "Gstatus",
      "Gvdiffsplit",
      "Gvsplit",
    },
  },
}

return M
