local M = {
  {
    "NeogitOrg/neogit",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        opts = {
          use_icons = false,
        },
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
        telescope = true,
      },
    },
    config = function(_, opts)
      require("neogit").setup(opts)
    end,
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
      on_attach = function(bufnr)
        require("keymap.git").setup(bufnr)

        vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitSignsAdd" })
        vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "GitSignsAddNr" })
        vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitSignsChange" })
        vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChangeNr" })
        vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "GitSignsChange" })
        vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "GitSignsChangeNr" })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GitSignsDelete" })
        vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "GitSignsDeleteNr" })
        vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "GitSignsDelete" })
        vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { link = "GitSignsDeleteNr" })
        vim.api.nvim_set_hl(0, "GitSignsUntracked", { link = "GitSignsAdd" })
        vim.api.nvim_set_hl(0, "GitSignsUntrackedNr", { link = "GitSignsAddNr" })
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
    init = function()
      vim.treesitter.language.register("markdown", "octo")
    end,
  },
}

return M
