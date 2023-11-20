local M = {
  {
    "NeogitOrg/neogit",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        opts = { icons = false },
      },
    },
    cmd = { "Neogit" },
    keys = {
      {
        "<Leader>G",
        function()
          require("neogit").open()
        end,
      },
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
  },

  {
    "sindrets/diffview.nvim",
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
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "Octo",
      "Octo ",
    },
    opts = {
      file_panel = {
        use_icons = false,
      },
    },
    config = function(_, opts)
      require("octo").setup(opts)
    end,
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
