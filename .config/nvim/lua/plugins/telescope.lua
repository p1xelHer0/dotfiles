local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "ThePrimeagen/harpoon",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
  },
  cmd = { "Telescope" },
  keys = {
    { mode = "n", "<C-p>", "<Cmd>Telescope find_files<CR>", { noremap = true, silent = true } },
    { mode = "n", "<Leader>b", "<Cmd>Telescope buffers<CR>", { silent = true, noremap = true } },
    { mode = "n", "<Leader>d", "<Cmd>Telescope diagnostics<CR>", { silent = true } },
    { mode = "n", "<Leader>f", "<Cmd>Telescope live_grep<CR>", { silent = true } },
    { mode = "n", "<Leader>gs", "<Cmd>Telescope git_status<CR>", { silent = true } },
    { mode = "n", "<Leader>h", "<Cmd>Telescope harpoon marks<CR>", { silent = true } },
    { mode = "n", "<Leader>T", "<Cmd>Telescope<CR>", { silent = true, noremap = true } },
  },
  opts = function()
    local theme = "dropdown"
    local borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    -- prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
    -- results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    -- preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

    return {
      defaults = {
        mappings = {
          n = {
            ["q"] = "close",
          },
        },
        borderchars = borderchars,
        theme = theme,
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        ["ui-select"] = {
          theme = "cursor",
        },
      },
    }
  end,
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { reverse = true })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { reverse = true })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { reverse = true })

    require("telescope").setup(opts)
  end,
}

return M
