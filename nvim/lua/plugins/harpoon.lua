return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon.setup(opts)

    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { desc = "Harpoon: " .. desc })
    end

    map("<Leader>a", function()
      harpoon:list():add()
    end, "Add")
    map("<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, "toggle quick menu")

    for i = 1, 9 do
      map("<Leader>" .. i, function()
        harpoon:list():select(i)
      end, "select " .. i)
    end
  end,
}
