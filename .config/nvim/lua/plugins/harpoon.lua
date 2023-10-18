local M = {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  config = function(_, opts)
    require("harpoon").setup(opts)

    local k = vim.keymap.set
    local k_opts = { noremap = true }

    k("n", "<Leader>a", require("harpoon.mark").add_file, k_opts)

    k("n", "<C-e>", require("harpoon.ui").toggle_quick_menu, k_opts)

    for i = 1, 9 do
      k("n", "<Leader>" .. i, function()
        require("harpoon.ui").nav_file(i)
      end, k_opts)
    end

    require("telescope").load_extension("harpoon")
  end,
}

return M
