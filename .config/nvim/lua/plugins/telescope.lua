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
  },
  keys = {
    { mode = "n", "<C-p>", "<Cmd>Telescope find_files<CR>", { noremap = true, silent = true } },
    { mode = "n", "<Leader>f", "<Cmd>Telescope live_grep<CR>", { silent = true } },
    { mode = "n", "<Leader>b", "<Cmd>Telescope buffers<CR>", { silent = true, noremap = true } },
    { mode = "n", "<Leader>T", "<Cmd>Telescope<CR>", { silent = true, noremap = true } },
  },
  opts = {
    defaults = {
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      mappings = {
        n = {
          ["<C-c>"] = "close",
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end,
      },
    },
  },
}

return M
