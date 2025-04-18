local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  config = function(_, opts)
    local k = vim.keymap.set
    local k_opts = { noremap = true }
    local harpoon = require("harpoon")

    harpoon.setup(opts)

    k("n", "<Leader>a", function()
      harpoon:list():add()
    end, k_opts)

    k("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for i = 1, 9 do
      k("n", "<Leader>" .. i, function()
        harpoon:list():select(i)
      end, k_opts)
    end
  end,
}

return M
