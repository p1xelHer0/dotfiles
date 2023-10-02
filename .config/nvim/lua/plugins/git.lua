local M = {
  {
    "NeogitOrg/neogit",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        opts = { icons = false },
      },
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Neogit" },
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
          text = require("core.config").get_icons().git.add,
          numhl = "GitSignsAddNr",
        },
        change = {
          hl = "GitSignsChange",
          text = require("core.config").get_icons().git.change,
          numhl = "GitSignsChangeNr",
        },
        delete = {
          hl = "GitSignsDelete",
          text = require("core.config").get_icons().git.delete,
          numhl = "GitSignsDeleteNr",
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = require("core.config").get_icons().git.top_delete,
          numhl = "GitSignsDeleteNr",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = require("core.config").get_icons().git.change_delete,
          numhl = "GitSignsChangeNr",
        },
        untracked = {
          hl = "GitSignsAdd",
          text = require("core.config").get_icons().git.untracked,
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
