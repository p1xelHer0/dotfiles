local M = {
  {
    "TimUntersberger/neogit",
    dependencies = { "sindrets/diffview.nvim" },
    cmd = { "Neogit " },
    config = function()
      local signs = require("core.config").get_icons()
      require("neogit").setup({
        auto_refresh = false,
        signs = {
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
        integrations = {
          diffview = true,
        },
      })
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    config = function()
      local cb = require("diffview.config").diffview_callback
      local signs = require("core.config").get_icons()
      require("diffview").setup({
        diff_binaries = false, -- Show diffs for binaries
        use_icons = false, -- Requires nvim-web-devicons
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        signs = { fold_closed = "", fold_open = "" },
        file_panel = {
          win_config = {
            position = "left", -- One of 'left', 'right', 'top', 'bottom'
            width = 35, -- Only applies when position is 'left' or 'right'
          },
        },
        key_bindings = {
          -- The `view` bindings are active in the diff buffers, only when the current
          -- tabpage is a Diffview.
          view = {
            ["<Tab>"] = cb("select_next_entry"), -- Open the diff for the next file
            ["<S-Tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
            ["<Leader>e"] = cb("focus_files"), -- Bring focus to the files panel
            ["<Leader>b"] = cb("toggle_files"), -- Toggle the files panel.
          },
          file_panel = {
            ["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
            ["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
            ["o"] = cb("select_entry"),
            ["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
            ["<Tab>"] = cb("select_next_entry"),
            ["<S-Sab>"] = cb("select_prev_entry"),
            ["<Leader>e"] = cb("focus_files"),
            ["<Leader>b"] = cb("toggle_files"),
          },
        },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Gitsigns " },
    config = function()
      local signs = require("core.config").get_icons()
      require("gitsigns").setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            -- text = "+",
            text = signs.general.indent,
            numhl = "GitSignsAddNr",
          },
          change = {
            hl = "GitSignsChange",
            -- text = "~",
            text = signs.general.indent,
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
            -- text = "~",
            text = signs.general.indent,
            numhl = "GitSignsChangeNr",
          },
          untracked = {
            hl = "GitSignsAdd",
            -- text = "~",
            text = signs.general.indent,
            numhl = "GitSignsAddNr",
          },
        },
      })
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
